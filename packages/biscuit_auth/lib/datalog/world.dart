// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/datalog/expression/expression.dart';
import 'package:biscuit_auth/datalog/fact.dart';
import 'package:biscuit_auth/datalog/origin.dart';
import 'package:biscuit_auth/datalog/rule.dart';
import 'package:biscuit_auth/datalog/run_limits.dart';
import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/error.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';

part 'gen/world.bp.dart';

@Boilerplate(equality: false)
final class World {
  final _facts = FactSet();
  final _rules = RuleSet();
  final _externFunctions = HashMap<String, ExternFn>();
  var _iterations = 0;

  void addFact(Origin origin, Fact fact) => _facts.add(origin, fact);

  void addRule(SymbolId origin, TrustedOrigins scope, Rule rule) =>
      _rules.insert(origin, scope, rule);

  void run(SymbolTable symbols, {RunLimits? limits}) {
    limits ??= RunLimits.defaults;
    final stopwatch = Stopwatch()..start();
    var index = 0;

    while (true) {
      final newFacts = FactSet();

      for (final MapEntry(key: scope, value: rules) in _rules.value.entries) {
        for (final (ruleOrigin, rule) in rules) {
          for (final (origin, fact) in rule.apply(
            _facts.trustedIterator(scope),
            ruleOrigin,
            symbols,
            _externFunctions,
          )) {
            newFacts.add(origin, fact);
          }
        }
      }

      final prevLength = _facts.length();
      final currLength = (_facts..merge(newFacts)).length();

      if (prevLength == currLength) break;

      if (++index == limits.maxIterations) {
        throw const ExecutionError.tooManyIterations();
      }

      if (currLength >= limits.maxFacts) {
        throw const ExecutionError.tooManyFacts();
      }

      if (stopwatch.elapsed >= limits.maxTime) {
        throw const ExecutionError.timeout();
      }
    }

    _iterations += index;
  }

  FactSet queryRule({
    required Rule rule,
    required SymbolId origin,
    required TrustedOrigins scope,
    required SymbolTable symbols,
  }) {
    final newFacts = FactSet();
    final iter = _facts.trustedIterator(scope);

    for (final (origin, fact) in rule.apply(
      iter,
      origin,
      symbols,
      _externFunctions,
    )) {
      newFacts.add(origin, fact);
    }

    return newFacts;
  }

  bool queryMatch({
    required Rule rule,
    required SymbolId origin,
    required TrustedOrigins scope,
    required SymbolTable symbols,
  }) => rule.findMatch(
    _facts.trustedIterator(scope),
    origin,
    symbols,
    _externFunctions,
  );

  bool queryMatchAll({
    required Rule rule,
    required TrustedOrigins scope,
    required SymbolTable symbols,
  }) => rule.checkMatchAll(
    _facts.trustedIterator(scope),
    symbols,
    _externFunctions,
  );

  String stringify(SymbolTable symbols) {
    final facts = _facts.value.entries
        .map((entry) => entry.value)
        .expand((facts) => facts.map((fact) => fact.stringify(symbols)));

    final rules = _rules.value.entries
        .map((entry) => entry.value)
        .expand((rules) => rules.map((tup) => tup.$2.stringify(symbols)));

    return 'World {\n  facts: $facts\n  rules: $rules\n}';
  }

  @override
  String toString() => _toString();
}

extension type FactSet._(HashMap<Origin, HashSet<Fact>> value) {
  factory() => ._(.new());

  void add(Origin origin, Fact fact) => value.update(
    origin,
    (facts) => facts..add(fact),
    ifAbsent: () => .new()..add(fact),
  );

  int length() => value.values.fold(0, (acc, facts) => acc + facts.length);

  bool isEmpty() => value.values.every((facts) => facts.isEmpty);

  Iterable<(Origin, Fact)> trustedIterator(TrustedOrigins blockIds) => value
      .entries
      .where((entry) => blockIds.contains(entry.key))
      .expand((entry) => entry.value.map((fact) => (entry.key, fact)));

  Iterable<(Origin, Fact)> get all => value.entries.expand(
    (entry) => entry.value.map((fact) => (entry.key, fact)),
  );

  void merge(FactSet other) {
    for (final MapEntry(key: origin, value: newFacts) in other.value.entries) {
      value.update(
        origin,
        (facts) => facts..addAll(newFacts),
        ifAbsent: () => newFacts,
      );
    }
  }
}

extension type RuleSet._(
  HashMap<TrustedOrigins, List<(SymbolId, Rule)>> value,
) {
  factory() => ._(.new());

  void insert(SymbolId origin, TrustedOrigins scope, Rule rule) => value.update(
    scope,
    (rules) => rules..add((origin, rule)),
    ifAbsent: () => [(origin, rule)],
  );

  Iterable<(TrustedOrigins, Rule)> get allIterator => value.entries.expand(
    (entry) => entry.value.map((rules) => (entry.key, rules.$2)),
  );
}
