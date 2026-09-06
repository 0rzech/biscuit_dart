// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:typed_data';

import 'package:biscuit_auth/datalog/eval.dart';
import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/error.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:biscuit_auth/src/bytes.dart';
import 'package:biscuit_auth/src/collection.dart';
import 'package:biscuit_auth/src/compare_to.dart';
import 'package:biscuit_auth/token/builder/term.dart' as b;
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/expression.bp.dart';

@immutable
@Boilerplate(string: false)
final class const ExternFn(
  final b.Term Function({required b.Term left, b.Term? right}) callback,
) {
  Term call(TemporarySymbolTable symbols, String name, Term left, Term? right) {
    try {
      final term = callback(
        left: b.fromDatalog(left, symbols),
        right: right == null ? null : b.fromDatalog(right, symbols),
      );
      return b.toDatalog(term, symbols);
    } on ExecutionError {
      rethrow;
    } on Exception catch (e) {
      throw ExecutionError.externVal(name: name, error: e.toString());
    }
  }

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => '<function>';
}

@immutable
@boilerplate
final class Expression {
  final ControlledList<Op> ops;

  new(List<Op> ops) : ops = .new(ops);

  Term eval(
    HashMap<SymbolId, Term> values,
    TemporarySymbolTable symbols,
    HashMap<String, ExternFn> externFunctions,
  ) {
    final stack = <Object>[];

    for (final op in ops) {
      switch (op) {
        // value

        case final Term term:
          if (term case Variable(:final id)) {
            if (values[id] case final value?) {
              stack.add(value);
            } else {
              throw ExecutionError.unknownVariable(id);
            }
          } else {
            stack.add(term);
          }

        // unary

        case final Unary _:
          if (stack.isEmpty) throw const ExecutionError.invalidStack();

          if (stack.removeLast() case final Term t) {
            stack.add(op.eval(t, symbols, externFunctions));
          } else {
            throw const ExecutionError.invalidStack();
          }

        // binary

        case final Binary _:
          if (stack.length < 2) throw const ExecutionError.invalidStack();

          switch ((stack.removeLast(), stack.removeLast())) {
            case (final Term r, final Term l):
              stack.add(op.eval(l, r, symbols, externFunctions));

            case (Closure(:final params, :final ops), final Term t):
            case (final Term t, Closure(:final params, :final ops)):
              if (params.any(values.containsKey)) {
                throw const ExecutionError.shadowedVariable();
              }

              stack.add(
                op.evalWithClosure(
                  t,
                  ops,
                  params,
                  values,
                  symbols,
                  externFunctions,
                ),
              );

            default:
              throw const ExecutionError.invalidStack();
          }

        // closure

        case final Closure c:
          stack.add(c);
      }
    }

    return switch (stack) {
      [final Term t] => t,
      _ => throw const ExecutionError.invalidStack(),
    };
  }

  String? stringify(SymbolTable symbols) {
    final stack = <String>[];

    for (final op in ops) {
      switch (op) {
        case final Term term:
          stack.add(term.stringify(symbols));

        case Unary _:
          if (stack.isEmpty) return null;

          stack.add(op.stringify(stack.removeLast(), symbols));

        case Binary _:
          if (stack.length < 2) return null;

          final (right, left) = (stack.removeLast(), stack.removeLast());
          stack.add(op.stringify(left, right, symbols));

        case Closure(:final params, :final ops):
          final body = Expression(ops).stringify(symbols);
          if (body == null) return null;

          if (params.isEmpty) {
            stack.add(body);
          } else {
            final group = params
                .map((id) => Term.variable(id).stringify(symbols))
                .join(', ');
            stack.add('$group -> $body');
          }
      }
    }

    return stack.length == 1 ? stack.first : null;
  }

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@immutable
sealed class const Op() {
  const factory variable(SymbolId id) = Term.variable;
  const factory int(int value) = Term.int;
  const factory str(SymbolId value) = Term.str;
  factory date(DateTime value) = Term.date;
  const factory bytes(Uint8List value) = Term.bytes;
  const factory bool(bool value) = Term.bool;
  const factory set(SplayTreeSet<Term> value) = Term.set;
  const factory nil() = Term.nil;
  const factory array(List<Term> value) = Term.array;
  const factory map(SplayTreeMap<MapKey, Term> value) = Term.map;

  const factory negate() = Unary.negate;
  const factory parens() = Unary.parens;
  const factory length() = Unary.length;
  const factory type() = Unary.type;
  const factory unFfi(SymbolId name) = Unary.ffi;

  const factory lessThan() = Binary.lessThan;
  const factory greaterThan() = Binary.greaterThan;
  const factory lessOrEqual() = Binary.lessOrEqual;
  const factory greaterOrEqual() = Binary.greaterOrEqual;
  const factory equal() = Binary.equal;
  const factory contains() = Binary.contains;
  const factory prefix() = Binary.prefix;
  const factory suffix() = Binary.suffix;
  const factory regex() = Binary.regex;
  const factory add() = Binary.add;
  const factory sub() = Binary.sub;
  const factory mul() = Binary.mul;
  const factory div() = Binary.div;
  const factory and() = Binary.and;
  const factory or() = Binary.or;
  const factory intersection() = Binary.intersection;
  const factory union() = Binary.union;
  const factory bitwiseAnd() = Binary.bitwiseAnd;
  const factory bitwiseOr() = Binary.bitwiseOr;
  const factory bitwiseXor() = Binary.bitwiseXor;
  const factory notEqual() = Binary.notEqual;
  const factory heterogeneousEqual() = Binary.heterogeneousEqual;
  const factory heterogeneousNotEqual() = Binary.heterogeneousNotEqual;
  const factory lazyAnd() = Binary.lazyAnd;
  const factory lazyOr() = Binary.lazyOr;
  const factory all() = Binary.all;
  const factory any() = Binary.any;
  const factory get() = Binary.get;
  const factory tryOr() = Binary.tryOr;
  const factory binFfi(SymbolId id) = Binary.ffi;

  const factory closure({
    required List<SymbolId> params,
    required List<Op> ops,
  }) = Closure;
}

sealed class const Term() extends Op implements Comparable<Term> {
  const factory variable(SymbolId id) = Variable;
  const factory int(int value) = Int;
  const factory str(SymbolId value) = Str;
  factory date(DateTime value) = Date;
  const factory bytes(Uint8List value) = Bytes;
  const factory bool(bool value) = Bool;
  const factory set(SplayTreeSet<Term> value) = Set;
  const factory nil() = Nil;
  const factory array(List<Term> value) = Array;
  const factory map(SplayTreeMap<MapKey, Term> value) = Map;

  String stringify(SymbolTable symbols);

  @override
  int compareTo(Term other) {
    if (runtimeType == other.runtimeType) {
      return switch (this) {
        Variable(:final id) => id.value.compareTo((other as Variable).id.value),
        Int(:final value) => value.compareTo((other as Int).value),
        Str(:final id) => id.value.compareTo((other as Str).id.value),
        Date(:final value) => value.compareTo((other as Date).value),
        Bytes(:final value) => value.compareTo((other as Bytes).value),
        Bool(:final value) => value.compareTo((other as Bool).value),
        Set(:final value) => value.compareTo((other as Set).value),
        Nil _ => 0,
        Array(:final value) => value.compareTo((other as Array).value),
        Map(:final value) => value.compareTo((other as Map).value),
      };
    }

    return _typeOrder(this).compareTo(_typeOrder(other));
  }

  int _typeOrder(Term term) => switch (term) {
    Variable _ => 0,
    Int _ => 1,
    Str _ => 2,
    Date _ => 3,
    Bytes _ => 4,
    Bool _ => 5,
    Set _ => 6,
    Nil _ => 7,
    Array _ => 8,
    Map _ => 9,
  };
}

@boilerplate
final class const Variable(final SymbolId id) extends Term {
  @override
  String stringify(SymbolTable symbols) => '\$${symbols.getOrDefault(id)}';

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

sealed class const MapKey() extends Term {
  const factory int(int value) = Int;
  const factory str(SymbolId id) = Str;
}

@boilerplate
final class const Int(final int value) extends MapKey {
  this
    : assert(
        value >= minValue && value <= maxValue,
        'Value must be >= $minValue and <= $maxValue, but was: $value',
      );

  static const minValue = bool.fromEnvironment('dart.library.js_interop')
      ? -maxValue // Web
      : -maxValue - 1; // Native

  static const maxValue = bool.fromEnvironment('dart.library.js_interop')
      ? 0x1fffffffffffff // Web
      : 0x7fffffffffffffff; // Native

  @override
  String stringify(SymbolTable _) => value.toString();

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const Str(final SymbolId id) extends MapKey {
  @override
  String stringify(SymbolTable symbols) => symbols.getOrDefault(id);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class Date extends Term {
  final int value;

  new(DateTime date) : value = date.toUtc().millisecondsSinceEpoch ~/ 1000;

  @override
  String stringify(SymbolTable _) =>
      DateTime.fromMillisecondsSinceEpoch(value * 1000).toIso8601String();

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const Bytes(final Uint8List value) extends Term {
  @override
  String stringify(SymbolTable _) => uint8ListToBytesStr(value, prefix: 'hex:');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const Bool(final bool value) extends Term {
  Bool get negate => .new(!value);

  @override
  String stringify(SymbolTable _) => value.toString();

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const Set(final SplayTreeSet<Term> value) extends Term {
  @override
  String stringify(SymbolTable symbols) => value.isEmpty
      ? '{,}'
      : '{${value.map((term) => term.stringify(symbols)).join(', ')}}';

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const Nil() extends Term {
  @override
  String stringify(SymbolTable _) => 'null';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Array(final List<Term> value) extends Term {
  @override
  String stringify(SymbolTable symbols) =>
      '{${value.map((term) => term.stringify(symbols)).join(', ')}}';

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const Map(final SplayTreeMap<MapKey, Term> value) extends Term {
  @override
  String stringify(SymbolTable symbols) =>
      '{${value.entries.map((entry) => switch (entry.key) {
        Int(:final value) => '$value: ${entry.value.stringify(symbols)}',
        Str(:final id) => '"${symbols.getOrDefault(id)}": '
            '${entry.value.stringify(symbols)}',
      }).join(', ')}}';

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

sealed class const Unary() extends Op {
  const factory negate() = Negate;
  const factory parens() = Parens;
  const factory length() = Length;
  const factory type() = Type;
  const factory ffi(SymbolId id) = UnFfi;

  String stringify(String symbol, SymbolTable symbols);
}

@boilerplate
final class const Negate() extends Unary {
  @override
  String stringify(String symbol, SymbolTable _) => '!$symbol';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Parens() extends Unary {
  @override
  String stringify(String symbol, SymbolTable _) => '($symbol)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Length() extends Unary {
  @override
  String stringify(String symbol, SymbolTable _) => '$symbol.length()';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Type() extends Unary {
  @override
  String stringify(String symbol, SymbolTable _) => '$symbol.type()';

  @override
  String toString() => _toString();
}

@boilerplate
final class const UnFfi(final SymbolId id) extends Unary {
  @override
  String stringify(String symbol, SymbolTable symbols) =>
      '$symbol.extern::${symbols.getOrDefault(id)}()';

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

sealed class const Binary() extends Op {
  const factory lessThan() = LessThan;
  const factory greaterThan() = GreaterThan;
  const factory lessOrEqual() = LessOrEqual;
  const factory greaterOrEqual() = GreaterOrEqual;
  const factory equal() = Equal;
  const factory contains() = Contains;
  const factory prefix() = Prefix;
  const factory suffix() = Suffix;
  const factory regex() = Regex;
  const factory add() = Add;
  const factory sub() = Sub;
  const factory mul() = Mul;
  const factory div() = Div;
  const factory and() = And;
  const factory or() = Or;
  const factory intersection() = Intersection;
  const factory union() = Union;
  const factory bitwiseAnd() = BitwiseAnd;
  const factory bitwiseOr() = BitwiseOr;
  const factory bitwiseXor() = BitwiseXor;
  const factory notEqual() = NotEqual;
  const factory heterogeneousEqual() = HeterogeneousEqual;
  const factory heterogeneousNotEqual() = HeterogeneousNotEqual;
  const factory lazyAnd() = LazyAnd;
  const factory lazyOr() = LazyOr;
  const factory all() = All;
  const factory any() = Any;
  const factory get() = Get;
  const factory tryOr() = TryOr;
  const factory ffi(SymbolId id) = BinFfi;

  String stringify(String left, String right, SymbolTable symbols);
}

@boilerplate
final class const LessThan() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left < $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const GreaterThan() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left > $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const LessOrEqual() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left <= $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const GreaterOrEqual() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left >= $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Equal() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left === $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Contains() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.contains($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Prefix() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.starts_with($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Suffix() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.ends_with($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Regex() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.matches($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Add() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left + $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Sub() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left - $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Mul() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left * $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Div() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left / $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const And() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left &&! $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Or() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left ||! $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Intersection() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.intersection($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Union() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.union($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const BitwiseAnd() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left & $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const BitwiseOr() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left | $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const BitwiseXor() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left ^ $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const NotEqual() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left !== $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const HeterogeneousEqual() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left == $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const HeterogeneousNotEqual() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left != $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const LazyAnd() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left && $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const LazyOr() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left || $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const All() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.all($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Any() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.any($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Get() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.get($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const TryOr() extends Binary {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.tryOr($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const BinFfi(final SymbolId id) extends Binary {
  @override
  String stringify(String left, String right, SymbolTable symbols) =>
      '$left.extern::${symbols.getOrDefault(id)}($right)';

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const Closure({
  required final List<SymbolId> params,
  required final List<Op> ops,
}) extends Op {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
