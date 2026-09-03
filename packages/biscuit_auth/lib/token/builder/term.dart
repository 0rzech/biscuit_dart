// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/datalog/expression/op.dart' as d;
import 'package:biscuit_auth/error.dart';
import 'package:biscuit_auth/parser/builder/expression/op.dart';

export 'package:biscuit_auth/parser/builder/expression/op.dart';

Term fromDatalog(d.Term term, TemporarySymbolTable symbols) {
  switch (term) {
    case final d.Variable t:
      if (symbols.getOrNull(t.id) case final symbol?) return .variable(symbol);

      throw ExecutionError.unknownVariable(t.id);

    case final d.Int t:
      return .int(t.value);

    case final d.Str t:
      if (symbols.getOrNull(t.id) case final symbol?) return .str(symbol);

      throw ExecutionError.unknownSymbol(t.id);

    case final d.Date t:
      return .date(DateTime.fromMillisecondsSinceEpoch(t.value * 1000));

    case final d.Bytes t:
      return .bytes(t.value);

    case final d.Bool t:
      return .bool(t.value);

    case final d.Set t:
      return .set(.of(t.value.map((t) => fromDatalog(t, symbols))));

    case final d.Nil _:
      return const .nil();

    case final d.Array t:
      return .array(.of(t.value.map((t) => fromDatalog(t, symbols))));

    case final d.Map t:
      return .map(
        .of(
          t.value.map((key, value) {
            switch (key) {
              case final d.Int k:
                return .new(.integer(k.value), fromDatalog(value, symbols));

              case final d.Str k:
                if (symbols.getOrNull(k.id) case final symbol?) {
                  return .new(.str(symbol), fromDatalog(value, symbols));
                }
                throw ExecutionError.unknownSymbol(k.id);
            }
          }),
        ),
      );
  }
}

d.Term toDatalog(Term term, TemporarySymbolTable symbols) => switch (term) {
  final Variable t => d.Term.variable(symbols.insert(t.value)),
  final Int t => d.Term.int(t.value),
  final Str t => d.Term.str(symbols.insert(t.value)),
  final Date t => d.Term.date(.fromMillisecondsSinceEpoch(t.value * 1000)),
  final Bytes t => d.Term.bytes(t.value),
  final Bool t => d.Term.bool(t.value),
  final Set t => d.Term.set(.of(t.value.map((t) => toDatalog(t, symbols)))),
  final Nil _ => const d.Term.nil(),
  final Array t => d.Term.array(.of(t.value.map((t) => toDatalog(t, symbols)))),
  final Map t => d.Term.map(
    .from(
      t.value.map((key, value) {
        switch (key) {
          case final Int k:
            return .new(d.MapKey.int(k.value), toDatalog(value, symbols));
          case final Str k:
            return .new(
              d.MapKey.str(symbols.insert(k.value)),
              toDatalog(value, symbols),
            );
          case final Parameter k:
            throw StateError('Remaining parameter: ${k.value}');
        }
      }),
    ),
  ),
  final Parameter t => throw StateError('Remaining parameter: ${t.value}'),
};

extension TermToken on Term {
  Term applyParameters(HashMap<String, Term?> parameters) {
    switch (this) {
      case Parameter(:final value):
        if (parameters[value] case final term?) return term;

        return .parameter(value);

      case Map(value: final map):
        final newMap = SplayTreeMap<MapKey, Term>();

        for (final MapEntry(:key, :value) in map.entries) {
          if (key case Parameter(value: final p)) {
            final MapKey newKey = switch (parameters[p]) {
              Int(value: final i) => .integer(i),
              Str(value: final s) => .str(s),
              null => .parameter(p),
              // FIXME: we should return an error
              _ => .parameter(p),
            };

            newMap[newKey] = value.applyParameters(parameters);
          } else {
            newMap[key] = value.applyParameters(parameters);
          }
        }

        return .map(newMap);

      case Array(:final value):
        return .array(
          .generate(value.length, (i) => value[i].applyParameters(parameters)),
        );

      case Set(:final value):
        return .set(.of(value.map((t) => t.applyParameters(parameters))));

      default:
        return this;
    }
  }
}
