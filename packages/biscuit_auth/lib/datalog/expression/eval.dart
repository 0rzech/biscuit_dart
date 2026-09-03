// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/datalog/expression/expression.dart';
import 'package:biscuit_auth/datalog/expression/op.dart';
import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/error.dart';
import 'package:collection/collection.dart';

extension EvalUnaryOp on Unary {
  Term eval(
    Term value,
    TemporarySymbolTable symbols,
    HashMap<String, ExternFn> externFunctions,
  ) {
    switch ((this, value)) {
      case (Negate _, Bool(:final value)):
        return .bool(!value);

      case (Parens _, final t):
        return t;

      case (Length _, Str(:final id)):
        if (symbols.getOrNull(id) case final symbol?) {
          return .int(symbol.length);
        }

        throw ExecutionError.unknownSymbol(id);

      case (Length _, Bytes(value: final bytes)):
        return .int(bytes.length);

      case (Length _, Set(value: final set)):
        return .int(set.length);

      case (Length _, Array(value: final array)):
        return .int(array.length);

      case (Length _, Map(value: final map)):
        return .int(map.length);

      case (Type _, final t):
        return .str(
          symbols.insert(switch (t) {
            Variable _ => throw const ExecutionError.invalidType(),
            Int _ => 'integer',
            Str _ => 'string',
            Date _ => 'date',
            Bytes _ => 'bytes',
            Bool _ => 'bool',
            Set _ => 'set',
            Nil _ => 'null',
            Array _ => 'array',
            Map _ => 'map',
          }),
        );

      case (UnFfi(:final id), final t):
        final name = symbols.getOrNull(id);
        if (name == null) throw ExecutionError.unknownSymbol(id);

        final fn = externFunctions[name];
        if (fn == null) throw ExecutionError.undefinedExtern(name);

        return fn.call(symbols, name, t, null);

      default:
        throw const ExecutionError.invalidType();
    }
  }
}

extension EvalBinaryOp on Binary {
  Term eval(
    Term left,
    Term right,
    TemporarySymbolTable symbols,
    HashMap<String, ExternFn> externFunctions,
  ) {
    switch ((this, left, right)) {
      // integer

      case (LessThan _, final Int l, final Int r):
        return .bool(l.value < r.value);

      case (GreaterThan _, final Int l, final Int r):
        return .bool(l.value > r.value);

      case (LessOrEqual _, final Int l, final Int r):
        return .bool(l.value <= r.value);

      case (GreaterOrEqual _, final Int l, final Int r):
        return .bool(l.value >= r.value);

      case (Equal _, final Int l, final Int r):
      case (HeterogeneousEqual _, final Int l, final Int r):
        return .bool(l.value == r.value);

      case (NotEqual _, final Int l, final Int r):
      case (HeterogeneousNotEqual _, final Int l, final Int r):
        return .bool(l.value != r.value);

      case (Add _, final Int l, final Int r):
        if ((r.value > 0 && l.value > Int.maxValue - r.value) ||
            (r.value < 0 && l.value < Int.minValue - r.value)) {
          throw const ExecutionError.overflow();
        }

        return .int(l.value + r.value);

      case (Sub _, final Int l, final Int r):
        if ((r.value > 0 && l.value < Int.minValue + r.value) ||
            (r.value < 0 && l.value > Int.maxValue + r.value)) {
          throw const ExecutionError.overflow();
        }

        return .int(l.value + r.value);

      case (Mul _, final Int l, final Int r):
        if (l.value == 0 || r.value == 0) return const .int(0);

        if (l.value.abs() > Int.maxValue ~/ r.value.abs()) {
          throw const ExecutionError.overflow();
        }

        return .int(l.value * r.value);

      case (Div _, final Int l, final Int r):
        if (r.value == 0) throw const ExecutionError.divisionByZero();

        if (l.value == Int.minValue && r.value == -1) {
          throw const ExecutionError.overflow();
        }

        return .int(l.value ~/ r.value);

      case (BitwiseAnd _, final Int l, final Int r):
        return .int(l.value & r.value);

      case (BitwiseOr _, final Int l, final Int r):
        return .int(l.value | r.value);

      case (BitwiseXor _, final Int l, final Int r):
        return .int(l.value ^ r.value);

      // string

      case (Prefix _, Str(id: final sid), Str(id: final pid)):
        return switch ((symbols.getOrNull(sid), symbols.getOrNull(pid))) {
          (final String s?, final String pre?) => .bool(s.startsWith(pre)),
          (String _?, null) => throw ExecutionError.unknownSymbol(pid),
          _ => throw ExecutionError.unknownSymbol(sid),
        };

      case (Suffix _, Str(id: final sid), Str(id: final pid)):
        return switch ((symbols.getOrNull(sid), symbols.getOrNull(pid))) {
          (final String s?, final String suf?) => .bool(s.endsWith(suf)),
          (String _?, null) => throw ExecutionError.unknownSymbol(pid),
          _ => throw ExecutionError.unknownSymbol(sid),
        };

      case (Regex _, Str(id: final sid), Str(id: final rid)):
        switch ((symbols.getOrNull(sid), symbols.getOrNull(rid))) {
          case (final String s?, final String r?):
            try {
              return .bool(RegExp(r).firstMatch(s) != null);
            } on FormatError {
              return const .bool(false);
            }
          case (String _?, null):
            throw ExecutionError.unknownSymbol(rid);
          default:
            throw ExecutionError.unknownSymbol(sid);
        }

      case (Contains _, Str(id: final sid), Str(id: final pid)):
        return switch ((symbols.getOrNull(sid), symbols.getOrNull(pid))) {
          (final String s?, final String pat?) => .bool(s.contains(pat)),
          (String _?, null) => throw ExecutionError.unknownSymbol(pid),
          _ => throw ExecutionError.unknownSymbol(sid),
        };

      case (Add _, Str(id: final lid), Str(id: final rid)):
        return switch ((symbols.getOrNull(lid), symbols.getOrNull(rid))) {
          (final String l?, final String r?) => .str(symbols.insert('$l$r')),
          (String _?, null) => throw ExecutionError.unknownSymbol(rid),
          _ => throw ExecutionError.unknownSymbol(lid),
        };

      case (Equal _, Str(id: final l), Str(id: final r)):
      case (HeterogeneousEqual _, Str(id: final l), Str(id: final r)):
        return .bool(l.value == r.value);

      case (NotEqual _, Str(id: final l), Str(id: final r)):
      case (HeterogeneousNotEqual _, Str(id: final l), Str(id: final r)):
        return .bool(l.value != r.value);

      // date

      case (LessThan _, final Date l, final Date r):
        return .bool(l.value < r.value);

      case (GreaterThan _, final Date l, final Date r):
        return .bool(l.value > r.value);

      case (LessOrEqual _, final Date l, final Date r):
        return .bool(l.value <= r.value);

      case (GreaterOrEqual _, final Date l, final Date r):
        return .bool(l.value >= r.value);

      case (Equal _, final Date l, final Date r):
      case (HeterogeneousEqual _, final Date l, final Date r):
        return .bool(l.value == r.value);

      case (NotEqual _, final Date l, final Date r):
      case (HeterogeneousNotEqual _, final Date l, final Date r):
        return .bool(l.value != r.value);

      // bytes

      case (Equal _, final Bytes l, final Bytes r):
      case (HeterogeneousEqual _, final Bytes l, final Bytes r):
        return .bool(const ListEquality<int>().equals(l.value, r.value));

      case (NotEqual _, final Bytes l, final Bytes r):
      case (HeterogeneousNotEqual _, final Bytes l, final Bytes r):
        return .bool(!const ListEquality<int>().equals(l.value, r.value));

      // set

      case (Equal _, final Set l, final Set r):
      case (HeterogeneousEqual _, final Set l, final Set r):
        return .bool(const SetEquality<Term>().equals(l.value, r.value));

      case (NotEqual _, final Set l, final Set r):
      case (HeterogeneousNotEqual _, final Set l, final Set r):
        return .bool(!const SetEquality<Term>().equals(l.value, r.value));

      case (Intersection _, final Set l, final Set r):
        return .set(l.value.intersection(r.value) as SplayTreeSet<Term>);

      case (Union _, final Set l, final Set r):
        return .set(l.value.union(r.value) as SplayTreeSet<Term>);

      case (Contains _, final Set l, final Set r):
        return .bool(l.value.containsAll(r.value));

      case (Contains _, final Set l, final Int r):
        return .bool(l.value.contains(r));

      case (Contains _, final Set l, final Date r):
        return .bool(l.value.contains(r));

      case (Contains _, final Set l, final Bool r):
        return .bool(l.value.contains(r));

      case (Contains _, final Set l, final Str r):
        return .bool(l.value.contains(r));

      case (Contains _, final Set l, final Bytes r):
        return .bool(l.value.contains(r));

      // bool

      case (And _, final Bool l, final Bool r):
        return .bool(l.value && r.value);

      case (Or _, final Bool l, final Bool r):
        return .bool(l.value || r.value);

      case (Equal _, final Bool l, final Bool r):
      case (HeterogeneousEqual _, final Bool l, final Bool r):
        return .bool(l.value == r.value);

      case (NotEqual _, final Bool l, final Bool r):
      case (HeterogeneousNotEqual _, final Bool l, final Bool r):
        return .bool(l.value != r.value);

      // null

      case (Equal _, Nil _, Nil _):
      case (HeterogeneousEqual _, Nil _, Nil _):
        return const .bool(true);

      case (Equal _, Nil _, _):
      case (Equal _, _, Nil _):
      case (HeterogeneousEqual _, Nil _, _):
      case (HeterogeneousEqual _, _, Nil _):
        return const .bool(false);

      case (NotEqual _, Nil _, Nil _):
      case (HeterogeneousNotEqual _, Nil _, Nil _):
        return const .bool(false);

      case (NotEqual _, Nil _, _):
      case (NotEqual _, _, Nil _):
      case (HeterogeneousNotEqual _, Nil _, _):
      case (HeterogeneousNotEqual _, _, Nil _):
        return const .bool(true);

      // array

      case (Equal _, final Array l, final Array r):
      case (HeterogeneousEqual _, final Array l, final Array r):
        return .bool(const ListEquality<Term>().equals(l.value, r.value));

      case (NotEqual _, final Array l, final Array r):
      case (HeterogeneousNotEqual _, final Array l, final Array r):
        return .bool(!const ListEquality<Term>().equals(l.value, r.value));

      case (Contains _, final Array l, final r):
        return .bool(l.value.contains(r));

      case (Prefix _, final Array l, final Array r):
        return .bool(l.value.startsWith(r.value));

      case (Suffix _, final Array l, final Array r):
        return .bool(l.value.endsWith(r.value));

      case (Get _, final Array l, final Int r):
        return l.value.elementAtOrNull(r.value) ?? const .nil();

      // map

      case (Equal _, final Map l, final Map r):
      case (HeterogeneousEqual _, final Map l, final Map r):
        return .bool(
          const MapEquality<MapKey, Term>().equals(l.value, r.value),
        );

      case (NotEqual _, final Map l, final Map r):
      case (HeterogeneousNotEqual _, final Map l, final Map r):
        return .bool(
          !const MapEquality<MapKey, Term>().equals(l.value, r.value),
        );

      case (Contains _, final Map l, final r):
        return .bool(l.value.containsKey(r));

      case (Get _, final Map l, final Int r):
        return l.value[r] ?? const .nil();

      case (Get _, final Map l, final Str r):
        return l.value[r] ?? const .nil();

      // heterogeneousEqual catch all

      case (HeterogeneousEqual _, _, _):
        return const .bool(false);

      case (HeterogeneousNotEqual _, _, _):
        return const .bool(true);

      // ffi

      case (BinFfi(:final id), final l, final r):
        final name = symbols.getOrNull(id);
        if (name == null) throw ExecutionError.unknownSymbol(id);

        final fn = externFunctions[name];
        if (fn == null) throw ExecutionError.undefinedExtern(name);

        return fn.call(symbols, name, l, r);

      // catch all

      default:
        throw const ExecutionError.invalidType();
    }
  }

  Term evalWithClosure(
    Term left,
    List<Op> right,
    List<SymbolId> params,
    HashMap<SymbolId, Term> values,
    TemporarySymbolTable symbols,
    HashMap<String, ExternFn> externFunctions,
  ) {
    switch ((this, left, params)) {
      case (TryOr _, final fallback, []):
        try {
          return Expression(right).eval(values, symbols, externFunctions);
        } on Exception {
          return fallback;
        }

      case (LazyOr _, Bool(value: final isTrue), []):
        return isTrue
            ? const .bool(true)
            : Expression(right).eval(values, symbols, externFunctions);

      case (LazyAnd _, Bool(value: final isTrue), []):
        return !isTrue
            ? const .bool(false)
            : Expression(right).eval(values, symbols, externFunctions);

      case (All _, Set(value: final set), [final param]):
        final e = Expression(right);
        for (final value in set) {
          values[param] = value;
          try {
            switch (e.eval(values, symbols, externFunctions)) {
              case Bool(value: false):
                return const .bool(false);
              case Bool(value: true):
                break;
              default:
                throw const ExecutionError.invalidType();
            }
          } finally {
            values.remove(param);
          }
        }
        return const .bool(true);

      case (Any _, Set(value: final set), [final param]):
        final e = Expression(right);
        for (final value in set) {
          values[param] = value;
          try {
            switch (e.eval(values, symbols, externFunctions)) {
              case Bool(value: false):
                break;
              case Bool(value: true):
                return const .bool(true);
              default:
                throw const ExecutionError.invalidType();
            }
          } finally {
            values.remove(param);
          }
        }
        return const .bool(false);

      case (All _, Array(value: final array), [final param]):
        final e = Expression(right);
        for (final value in array) {
          values[param] = value;
          try {
            switch (e.eval(values, symbols, externFunctions)) {
              case Bool(value: false):
                return const .bool(false);
              case Bool(value: true):
                break;
              default:
                throw const ExecutionError.invalidType();
            }
          } finally {
            values.remove(param);
          }
        }
        return const .bool(true);

      case (Any _, Array(value: final array), [final param]):
        final e = Expression(right);
        for (final value in array) {
          values[param] = value;
          try {
            switch (e.eval(values, symbols, externFunctions)) {
              case Bool(value: false):
                break;
              case Bool(value: true):
                return const .bool(true);
              default:
                throw const ExecutionError.invalidType();
            }
          } finally {
            values.remove(param);
          }
        }
        return const .bool(false);

      case (All _, Map(value: final map), [final param]):
        final e = Expression(right);
        for (final MapEntry(:key, :value) in map.entries) {
          values[param] = .array([key, value]);
          try {
            switch (e.eval(values, symbols, externFunctions)) {
              case Bool(value: false):
                return const .bool(false);
              case Bool(value: true):
                break;
              default:
                throw const ExecutionError.invalidType();
            }
          } finally {
            values.remove(param);
          }
        }
        return const .bool(true);

      case (Any _, Map(value: final map), [final param]):
        final e = Expression(right);
        for (final MapEntry(:key, :value) in map.entries) {
          values[param] = .array([key, value]);
          try {
            switch (e.eval(values, symbols, externFunctions)) {
              case Bool(value: false):
                break;
              case Bool(value: true):
                return const .bool(true);
              default:
                throw const ExecutionError.invalidType();
            }
          } finally {
            values.remove(param);
          }
        }
        return const .bool(false);

      case (_, _, _):
        throw const ExecutionError.invalidType();
    }
  }
}

extension ListPrefixSuffix<E> on List<E> {
  bool startsWith(List<E> prefix) {
    if (prefix.length > length) return false;

    for (var i = 0; i < prefix.length; ++i) {
      if (prefix[i] != this[i]) return false;
    }

    return true;
  }

  bool endsWith(List<E> suffix) {
    if (suffix.length > length) return false;

    final self = reversed.iterator;
    final suff = suffix.reversed.iterator;

    while (suff.moveNext()) {
      if (suff.current != (self..moveNext()).current) return false;
    }

    return true;
  }
}
