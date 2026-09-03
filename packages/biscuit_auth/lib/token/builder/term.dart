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
    case final d.VariableTerm t:
      if (symbols.getOrNull(t.id) case final symbol?) return .variable(symbol);

      throw ExecutionError.unknownVariable(t.id);

    case final d.IntTerm t:
      return .int(t.value);

    case final d.StrTerm t:
      if (symbols.getOrNull(t.id) case final symbol?) return .str(symbol);

      throw ExecutionError.unknownSymbol(t.id);

    case final d.DateTerm t:
      return .date(DateTime.fromMillisecondsSinceEpoch(t.value * 1000));

    case final d.BytesTerm t:
      return .bytes(t.value);

    case final d.BoolTerm t:
      return .bool(t.value);

    case final d.SetTerm t:
      return .set(.of(t.value.map((t) => fromDatalog(t, symbols))));

    case final d.NilTerm _:
      return const .nil();

    case final d.ArrayTerm t:
      return .array(.of(t.value.map((t) => fromDatalog(t, symbols))));

    case final d.MapTerm t:
      return .map(
        .of(
          t.value.map((key, value) {
            switch (key) {
              case final d.IntTerm k:
                return .new(.integer(k.value), fromDatalog(value, symbols));

              case final d.StrTerm k:
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
  final VariableTerm t => d.Term.variable(symbols.insert(t.value)),
  final IntTerm t => d.Term.int(t.value),
  final StrTerm t => d.Term.str(symbols.insert(t.value)),
  final DateTerm t => d.Term.date(.fromMillisecondsSinceEpoch(t.value * 1000)),
  final BytesTerm t => d.Term.bytes(t.value),
  final BoolTerm t => d.Term.bool(t.value),
  final SetTerm t => d.Term.set(.of(t.value.map((t) => toDatalog(t, symbols)))),
  final NilTerm _ => const d.Term.nil(),
  final ArrayTerm t => d.Term.array(
    .of(t.value.map((t) => toDatalog(t, symbols))),
  ),
  final MapTerm t => d.Term.map(
    .from(
      t.value.map((key, value) {
        switch (key) {
          case final IntTerm k:
            return .new(d.MapKey.int(k.value), toDatalog(value, symbols));
          case final StrTerm k:
            return .new(
              d.MapKey.str(symbols.insert(k.value)),
              toDatalog(value, symbols),
            );
          case final ParameterTerm k:
            throw StateError('Remaining parameter: ${k.value}');
        }
      }),
    ),
  ),
  final ParameterTerm t => throw StateError('Remaining parameter: ${t.value}'),
};

extension TermToken on Term {
  Term applyParameters(HashMap<String, Term?> parameters) {
    switch (this) {
      case ParameterTerm(:final value):
        if (parameters[value] case final term?) return term;

        return .parameter(value);

      case MapTerm(value: final map):
        final newMap = SplayTreeMap<MapKey, Term>();

        for (final MapEntry(:key, :value) in map.entries) {
          if (key case ParameterTerm(value: final p)) {
            final MapKey newKey = switch (parameters[p]) {
              IntTerm(value: final i) => .integer(i),
              StrTerm(value: final s) => .str(s),
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

      case ArrayTerm(:final value):
        return .array(
          .generate(value.length, (i) => value[i].applyParameters(parameters)),
        );

      case SetTerm(:final value):
        return .set(.of(value.map((t) => t.applyParameters(parameters))));

      default:
        return this;
    }
  }
}
