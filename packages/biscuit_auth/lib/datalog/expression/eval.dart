// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/datalog/expression/expression.dart';
import 'package:biscuit_auth/datalog/expression/op.dart';
import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/error.dart';
import 'package:collection/collection.dart';

extension EvalUnaryOp on UnaryOp {
  Term eval(
    Term value,
    TemporarySymbolTable symbols,
    HashMap<String, ExternFn> externFunctions,
  ) {
    switch ((this, value)) {
      case (Negate _, BoolTerm(:final value)):
        return .bool(!value);

      case (Parens _, final t):
        return t;

      case (Length _, StrTerm(:final id)):
        if (symbols.getOrNull(id) case final symbol?) {
          return .int(symbol.length);
        }

        throw ExecutionError.unknownSymbol(id);

      case (Length _, BytesTerm(value: final bytes)):
        return .int(bytes.length);

      case (Length _, SetTerm(value: final set)):
        return .int(set.length);

      case (Length _, ArrayTerm(value: final array)):
        return .int(array.length);

      case (Length _, MapTerm(value: final map)):
        return .int(map.length);

      case (Type _, final t):
        return .str(
          symbols.insert(switch (t) {
            VariableTerm _ => throw const ExecutionError.invalidType(),
            IntTerm _ => 'integer',
            StrTerm _ => 'string',
            DateTerm _ => 'date',
            BytesTerm _ => 'bytes',
            BoolTerm _ => 'bool',
            SetTerm _ => 'set',
            NilTerm _ => 'null',
            ArrayTerm _ => 'array',
            MapTerm _ => 'map',
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

extension EvalBinaryOp on BinaryOp {
  Term eval(
    Term left,
    Term right,
    TemporarySymbolTable symbols,
    HashMap<String, ExternFn> externFunctions,
  ) {
    switch ((this, left, right)) {
      // integer

      case (LessThan _, final IntTerm l, final IntTerm r):
        return .bool(l.value < r.value);

      case (GreaterThan _, final IntTerm l, final IntTerm r):
        return .bool(l.value > r.value);

      case (LessOrEqual _, final IntTerm l, final IntTerm r):
        return .bool(l.value <= r.value);

      case (GreaterOrEqual _, final IntTerm l, final IntTerm r):
        return .bool(l.value >= r.value);

      case (Equal _, final IntTerm l, final IntTerm r):
      case (HeterogeneousEqual _, final IntTerm l, final IntTerm r):
        return .bool(l.value == r.value);

      case (NotEqual _, final IntTerm l, final IntTerm r):
      case (HeterogeneousNotEqual _, final IntTerm l, final IntTerm r):
        return .bool(l.value != r.value);

      case (Add _, final IntTerm l, final IntTerm r):
        if ((r.value > 0 && l.value > IntTerm.maxValue - r.value) ||
            (r.value < 0 && l.value < IntTerm.minValue - r.value)) {
          throw const ExecutionError.overflow();
        }

        return .int(l.value + r.value);

      case (Sub _, final IntTerm l, final IntTerm r):
        if ((r.value > 0 && l.value < IntTerm.minValue + r.value) ||
            (r.value < 0 && l.value > IntTerm.maxValue + r.value)) {
          throw const ExecutionError.overflow();
        }

        return .int(l.value + r.value);

      case (Mul _, final IntTerm l, final IntTerm r):
        if (l.value == 0 || r.value == 0) return const .int(0);

        if (l.value.abs() > IntTerm.maxValue ~/ r.value.abs()) {
          throw const ExecutionError.overflow();
        }

        return .int(l.value * r.value);

      case (Div _, final IntTerm l, final IntTerm r):
        if (r.value == 0) throw const ExecutionError.divisionByZero();

        if (l.value == IntTerm.minValue && r.value == -1) {
          throw const ExecutionError.overflow();
        }

        return .int(l.value ~/ r.value);

      case (BitwiseAnd _, final IntTerm l, final IntTerm r):
        return .int(l.value & r.value);

      case (BitwiseOr _, final IntTerm l, final IntTerm r):
        return .int(l.value | r.value);

      case (BitwiseXor _, final IntTerm l, final IntTerm r):
        return .int(l.value ^ r.value);

      // string

      case (Prefix _, StrTerm(id: final sid), StrTerm(id: final pid)):
        return switch ((symbols.getOrNull(sid), symbols.getOrNull(pid))) {
          (final String s?, final String pre?) => .bool(s.startsWith(pre)),
          (String _?, null) => throw ExecutionError.unknownSymbol(pid),
          _ => throw ExecutionError.unknownSymbol(sid),
        };

      case (Suffix _, StrTerm(id: final sid), StrTerm(id: final pid)):
        return switch ((symbols.getOrNull(sid), symbols.getOrNull(pid))) {
          (final String s?, final String suf?) => .bool(s.endsWith(suf)),
          (String _?, null) => throw ExecutionError.unknownSymbol(pid),
          _ => throw ExecutionError.unknownSymbol(sid),
        };

      case (Regex _, StrTerm(id: final sid), StrTerm(id: final rid)):
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

      case (Contains _, StrTerm(id: final sid), StrTerm(id: final pid)):
        return switch ((symbols.getOrNull(sid), symbols.getOrNull(pid))) {
          (final String s?, final String pat?) => .bool(s.contains(pat)),
          (String _?, null) => throw ExecutionError.unknownSymbol(pid),
          _ => throw ExecutionError.unknownSymbol(sid),
        };

      case (Add _, StrTerm(id: final lid), StrTerm(id: final rid)):
        return switch ((symbols.getOrNull(lid), symbols.getOrNull(rid))) {
          (final String l?, final String r?) => .str(symbols.insert('$l$r')),
          (String _?, null) => throw ExecutionError.unknownSymbol(rid),
          _ => throw ExecutionError.unknownSymbol(lid),
        };

      case (Equal _, StrTerm(id: final l), StrTerm(id: final r)):
      case (HeterogeneousEqual _, StrTerm(id: final l), StrTerm(id: final r)):
        return .bool(l.value == r.value);

      case (NotEqual _, StrTerm(id: final l), StrTerm(id: final r)):
      case (
        HeterogeneousNotEqual _,
        StrTerm(id: final l),
        StrTerm(id: final r),
      ):
        return .bool(l.value != r.value);

      // date

      case (LessThan _, final DateTerm l, final DateTerm r):
        return .bool(l.value < r.value);

      case (GreaterThan _, final DateTerm l, final DateTerm r):
        return .bool(l.value > r.value);

      case (LessOrEqual _, final DateTerm l, final DateTerm r):
        return .bool(l.value <= r.value);

      case (GreaterOrEqual _, final DateTerm l, final DateTerm r):
        return .bool(l.value >= r.value);

      case (Equal _, final DateTerm l, final DateTerm r):
      case (HeterogeneousEqual _, final DateTerm l, final DateTerm r):
        return .bool(l.value == r.value);

      case (NotEqual _, final DateTerm l, final DateTerm r):
      case (HeterogeneousNotEqual _, final DateTerm l, final DateTerm r):
        return .bool(l.value != r.value);

      // bytes

      case (Equal _, final BytesTerm l, final BytesTerm r):
      case (HeterogeneousEqual _, final BytesTerm l, final BytesTerm r):
        return .bool(const ListEquality<int>().equals(l.value, r.value));

      case (NotEqual _, final BytesTerm l, final BytesTerm r):
      case (HeterogeneousNotEqual _, final BytesTerm l, final BytesTerm r):
        return .bool(!const ListEquality<int>().equals(l.value, r.value));

      // set

      case (Equal _, final SetTerm l, final SetTerm r):
      case (HeterogeneousEqual _, final SetTerm l, final SetTerm r):
        return .bool(const SetEquality<Term>().equals(l.value, r.value));

      case (NotEqual _, final SetTerm l, final SetTerm r):
      case (HeterogeneousNotEqual _, final SetTerm l, final SetTerm r):
        return .bool(!const SetEquality<Term>().equals(l.value, r.value));

      case (Intersection _, final SetTerm l, final SetTerm r):
        return .set(l.value.intersection(r.value) as SplayTreeSet<Term>);

      case (Union _, final SetTerm l, final SetTerm r):
        return .set(l.value.union(r.value) as SplayTreeSet<Term>);

      case (Contains _, final SetTerm l, final SetTerm r):
        return .bool(l.value.containsAll(r.value));

      case (Contains _, final SetTerm l, final IntTerm r):
        return .bool(l.value.contains(r));

      case (Contains _, final SetTerm l, final DateTerm r):
        return .bool(l.value.contains(r));

      case (Contains _, final SetTerm l, final BoolTerm r):
        return .bool(l.value.contains(r));

      case (Contains _, final SetTerm l, final StrTerm r):
        return .bool(l.value.contains(r));

      case (Contains _, final SetTerm l, final BytesTerm r):
        return .bool(l.value.contains(r));

      // bool

      case (And _, final BoolTerm l, final BoolTerm r):
        return .bool(l.value && r.value);

      case (Or _, final BoolTerm l, final BoolTerm r):
        return .bool(l.value || r.value);

      case (Equal _, final BoolTerm l, final BoolTerm r):
      case (HeterogeneousEqual _, final BoolTerm l, final BoolTerm r):
        return .bool(l.value == r.value);

      case (NotEqual _, final BoolTerm l, final BoolTerm r):
      case (HeterogeneousNotEqual _, final BoolTerm l, final BoolTerm r):
        return .bool(l.value != r.value);

      // null

      case (Equal _, NilTerm _, NilTerm _):
      case (HeterogeneousEqual _, NilTerm _, NilTerm _):
        return const .bool(true);

      case (Equal _, NilTerm _, _):
      case (Equal _, _, NilTerm _):
      case (HeterogeneousEqual _, NilTerm _, _):
      case (HeterogeneousEqual _, _, NilTerm _):
        return const .bool(false);

      case (NotEqual _, NilTerm _, NilTerm _):
      case (HeterogeneousNotEqual _, NilTerm _, NilTerm _):
        return const .bool(false);

      case (NotEqual _, NilTerm _, _):
      case (NotEqual _, _, NilTerm _):
      case (HeterogeneousNotEqual _, NilTerm _, _):
      case (HeterogeneousNotEqual _, _, NilTerm _):
        return const .bool(true);

      // array

      case (Equal _, final ArrayTerm l, final ArrayTerm r):
      case (HeterogeneousEqual _, final ArrayTerm l, final ArrayTerm r):
        return .bool(const ListEquality<Term>().equals(l.value, r.value));

      case (NotEqual _, final ArrayTerm l, final ArrayTerm r):
      case (HeterogeneousNotEqual _, final ArrayTerm l, final ArrayTerm r):
        return .bool(!const ListEquality<Term>().equals(l.value, r.value));

      case (Contains _, final ArrayTerm l, final r):
        return .bool(l.value.contains(r));

      case (Prefix _, final ArrayTerm l, final ArrayTerm r):
        return .bool(l.value.startsWith(r.value));

      case (Suffix _, final ArrayTerm l, final ArrayTerm r):
        return .bool(l.value.endsWith(r.value));

      case (Get _, final ArrayTerm l, final IntTerm r):
        return l.value.elementAtOrNull(r.value) ?? const .nil();

      // map

      case (Equal _, final MapTerm l, final MapTerm r):
      case (HeterogeneousEqual _, final MapTerm l, final MapTerm r):
        return .bool(
          const MapEquality<MapKey, Term>().equals(l.value, r.value),
        );

      case (NotEqual _, final MapTerm l, final MapTerm r):
      case (HeterogeneousNotEqual _, final MapTerm l, final MapTerm r):
        return .bool(
          !const MapEquality<MapKey, Term>().equals(l.value, r.value),
        );

      case (Contains _, final MapTerm l, final r):
        return .bool(l.value.containsKey(r));

      case (Get _, final MapTerm l, final IntTerm r):
        return l.value[r] ?? const .nil();

      case (Get _, final MapTerm l, final StrTerm r):
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

      case (LazyOr _, BoolTerm(value: final isTrue), []):
        return isTrue
            ? const .bool(true)
            : Expression(right).eval(values, symbols, externFunctions);

      case (LazyAnd _, BoolTerm(value: final isTrue), []):
        return !isTrue
            ? const .bool(false)
            : Expression(right).eval(values, symbols, externFunctions);

      case (All _, SetTerm(value: final set), [final param]):
        final e = Expression(right);
        for (final value in set) {
          values[param] = value;
          try {
            switch (e.eval(values, symbols, externFunctions)) {
              case BoolTerm(value: false):
                return const .bool(false);
              case BoolTerm(value: true):
                break;
              default:
                throw const ExecutionError.invalidType();
            }
          } finally {
            values.remove(param);
          }
        }
        return const .bool(true);

      case (Any _, SetTerm(value: final set), [final param]):
        final e = Expression(right);
        for (final value in set) {
          values[param] = value;
          try {
            switch (e.eval(values, symbols, externFunctions)) {
              case BoolTerm(value: false):
                break;
              case BoolTerm(value: true):
                return const .bool(true);
              default:
                throw const ExecutionError.invalidType();
            }
          } finally {
            values.remove(param);
          }
        }
        return const .bool(false);

      case (All _, ArrayTerm(value: final array), [final param]):
        final e = Expression(right);
        for (final value in array) {
          values[param] = value;
          try {
            switch (e.eval(values, symbols, externFunctions)) {
              case BoolTerm(value: false):
                return const .bool(false);
              case BoolTerm(value: true):
                break;
              default:
                throw const ExecutionError.invalidType();
            }
          } finally {
            values.remove(param);
          }
        }
        return const .bool(true);

      case (Any _, ArrayTerm(value: final array), [final param]):
        final e = Expression(right);
        for (final value in array) {
          values[param] = value;
          try {
            switch (e.eval(values, symbols, externFunctions)) {
              case BoolTerm(value: false):
                break;
              case BoolTerm(value: true):
                return const .bool(true);
              default:
                throw const ExecutionError.invalidType();
            }
          } finally {
            values.remove(param);
          }
        }
        return const .bool(false);

      case (All _, MapTerm(value: final map), [final param]):
        final e = Expression(right);
        for (final MapEntry(:key, :value) in map.entries) {
          values[param] = .array([key, value]);
          try {
            switch (e.eval(values, symbols, externFunctions)) {
              case BoolTerm(value: false):
                return const .bool(false);
              case BoolTerm(value: true):
                break;
              default:
                throw const ExecutionError.invalidType();
            }
          } finally {
            values.remove(param);
          }
        }
        return const .bool(true);

      case (Any _, MapTerm(value: final map), [final param]):
        final e = Expression(right);
        for (final MapEntry(:key, :value) in map.entries) {
          values[param] = .array([key, value]);
          try {
            switch (e.eval(values, symbols, externFunctions)) {
              case BoolTerm(value: false):
                break;
              case BoolTerm(value: true):
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
