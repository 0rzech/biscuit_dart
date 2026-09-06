// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/datalog/combinator.dart';
import 'package:biscuit_auth/datalog/expression/expression.dart';
import 'package:biscuit_auth/datalog/expression/op.dart';
import 'package:biscuit_auth/datalog/fact.dart';
import 'package:biscuit_auth/datalog/origin.dart';
import 'package:biscuit_auth/datalog/scope.dart';
import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/error.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:biscuit_auth/src/collection.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/rule.bp.dart';

@immutable
@boilerplate
final class const Rule._(
  final Predicate head,
  final ControlledList<Predicate> body,
  final ControlledList<Expression> expressions,
  final ControlledList<Scope> scopes,
) {
  factory({
    required SymbolId headName,
    required List<Term> headTerms,
    required List<Predicate> predicates,
  }) => ._(
    .new(headName, headTerms),
    .new(predicates),
    const .new([]),
    const .new([]),
  );

  factory withExpressions({
    required SymbolId headName,
    required List<Term> headTerms,
    required List<Predicate> predicates,
    required List<Expression> expressions,
  }) => ._(
    .new(headName, headTerms),
    .new(predicates),
    .new(expressions),
    const .new([]),
  );

  HashSet<SymbolId> variablesSet() {
    final result = HashSet<SymbolId>();
    for (final predicate in body) {
      for (final term in predicate.terms.whereType<Variable>()) {
        result.add(term.id);
      }
    }
    return result;
  }

  Iterable<(Origin, Fact)> apply(
    Iterable<(Origin, Fact)> facts,
    SymbolId ruleOrigin,
    SymbolTable symbols,
    HashMap<String, ExternFn> externFunctions,
  ) {
    return FactCombinator(
          variables: .new(variablesSet()),
          predicates: body.slice(0, body.length),
          facts: facts,
          symbols: symbols,
        )
        .map((tup) {
          final (origin, variables) = tup;
          final temporarySymbols = TemporarySymbolTable(symbols);

          for (final e in expressions) {
            switch (e.eval(variables, temporarySymbols, externFunctions)) {
              case Bool(value: true):
                break;
              case Bool(value: false):
                return (origin, variables, false);
              default:
                throw const ExecutionError.invalidType();
            }
          }

          return (origin, variables, true);
        })
        .map((tup) {
          final (origin, map, resultIsTrue) = tup;

          if (resultIsTrue) {
            final p = head.copyWith(terms: [...head.terms]);

            for (var i = 0; i < p.terms.length; ++i) {
              if (p.terms[i] case Variable(:final id)) {
                if (map[id] case final term?) {
                  p.terms[i] = term;
                } else {
                  return null;
                }
              }
            }

            return (origin..add(ruleOrigin), Fact(p));
          }

          return null;
        })
        .whereType<(Origin, Fact)>();
  }

  bool findMatch(
    Iterable<(Origin, Fact)> facts,
    SymbolId ruleOrigin,
    SymbolTable symbols,
    HashMap<String, ExternFn> externFunctions,
  ) => apply(facts, ruleOrigin, symbols, externFunctions).isNotEmpty;

  bool checkMatchAll(
    Iterable<(Origin, Fact)> facts,
    SymbolTable symbols,
    HashMap<String, ExternFn> externFunctions,
  ) {
    var found = false;

    for (final (_, variables) in FactCombinator(
      variables: .new(variablesSet()),
      predicates: body.slice(0, body.length),
      facts: facts,
      symbols: symbols,
    )) {
      found = true;
      final temporarySymbols = TemporarySymbolTable(symbols);

      for (final e in expressions) {
        switch (e.eval(variables, temporarySymbols, externFunctions)) {
          case Bool(value: final isMatch):
            if (!isMatch) return false;

          default:
            throw const ExecutionError.invalidType();
        }
      }
    }

    return found;
  }

  String? validateVariables(SymbolTable symbols) {
    final headVariables = HashSet<SymbolId>();

    for (final term in head.terms) {
      if (term case Variable(:final id)) headVariables.add(id);
    }

    for (final predicate in body) {
      for (final term in predicate.terms) {
        if (term case Variable(:final id)) {
          headVariables.remove(id);
          if (headVariables.isEmpty) return null;
        }
      }
    }

    if (headVariables.isEmpty) return null;

    final names = headVariables
        .map((s) => '\$${symbols.getOrDefault(s)}')
        .join(', ');

    return 'rule head contains variables that are not used in predicates'
        "of the rule's body: $names";
  }

  String stringify(SymbolTable symbols) {
    final sb = StringBuffer(head.stringify(symbols))
      ..write(' <- ')
      ..writeAll(body.map((p) => p.stringify(symbols)), ', ');

    if (expressions.isNotEmpty) {
      if (body.isNotEmpty) sb.write(', ');

      sb.writeAll(expressions.map((e) => e.stringify(symbols)), ', ');
    }

    if (scopes.isNotEmpty) {
      sb.write(' trusting ');
      sb.writeAll(scopes.map((s) => s.stringify(symbols.publicKeys)), ', ');
    }

    return sb.toString();
  }

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
