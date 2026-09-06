// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:typed_data';

import 'package:biscuit_auth/parser/grammar/expr.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:biscuit_auth/src/collection.dart';
import 'package:biscuit_auth/src/compare_to.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/expression.bp.dart';

@immutable
@boilerplate
final class Expression {
  final ControlledList<Op> ops;

  new(List<Op> ops) : ops = .new(ops);

  factory fromAst(Expr node) => .new(node.toOpcodes());

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@immutable
sealed class const Op() {
  const factory variable(String value) = Term.variable;
  const factory int(int value) = Term.int;
  const factory str(String value) = Term.str;
  factory date(DateTime value) = Term.date;
  const factory bytes(Uint8List value) = Term.bytes;
  const factory bool(bool value) = Term.bool;
  const factory set(SplayTreeSet<Term> value) = Term.set;
  const factory parameter(String value) = Term.parameter;
  const factory nil() = Term.nil;
  const factory array(List<Term> value) = Term.array;
  const factory map(SplayTreeMap<MapKey, Term> value) = Term.map;

  const factory negate() = Unary.negate;
  const factory parens() = Unary.parens;
  const factory length() = Unary.length;
  const factory type() = Unary.type;
  const factory unFfi(String name) = Unary.ffi;

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
  const factory binFfi(String name) = Binary.ffi;

  const factory closure({required List<String> params, required List<Op> ops}) =
      Closure;

  void collectParameters(HashMap<String, Term?> parameters) {
    switch (this) {
      case final Term term:
        term.extractParameters(parameters);
      case Closure(params: _, :final ops):
        for (final op in ops) {
          op.collectParameters(parameters);
        }
      default:
        {}
    }
  }
}

sealed class const Term() extends Op implements Comparable<Term> {
  const factory variable(String value) = Variable;
  const factory int(int value) = Int;
  const factory str(String value) = Str;
  factory date(DateTime value) = Date;
  const factory bytes(Uint8List value) = Bytes;
  const factory bool(bool value) = Bool;
  const factory set(SplayTreeSet<Term> value) = Set;
  const factory parameter(String value) = Parameter;
  const factory nil() = Nil;
  const factory array(List<Term> value) = Array;
  const factory map(SplayTreeMap<MapKey, Term> value) = Map;

  void extractParameters(HashMap<String, Term?> parameters) {
    switch (this) {
      case Parameter(:final value):
        parameters[value] = null;

      case Set(:final value):
        for (final item in value) {
          item.extractParameters(parameters);
        }

      case Array(:final value):
        for (final item in value) {
          item.extractParameters(parameters);
        }

      case Map(:final value):
        for (final MapEntry(:key, value: term) in value.entries) {
          if (key case Parameter(value: final parameter)) {
            parameters[parameter] = null;
          }
          term.extractParameters(parameters);
        }

      default:
        break;
    }
  }

  @override
  int compareTo(Term other) {
    if (runtimeType == other.runtimeType) {
      return switch (this) {
        Variable(:final value) => value.compareTo((other as Variable).value),
        Int(:final value) => value.compareTo((other as Int).value),
        Str(:final value) => value.compareTo((other as Str).value),
        Date(:final value) => value.compareTo((other as Date).value),
        Bytes(:final value) => value.compareTo((other as Bytes).value),
        Bool(:final value) => value.compareTo((other as Bool).value),
        Set(:final value) => value.compareTo((other as Set).value),
        Parameter(:final value) => value.compareTo((other as Parameter).value),
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
    Parameter _ => 7,
    Nil _ => 8,
    Array _ => 9,
    Map _ => 10,
  };
}

sealed class const MapKey() extends Term {
  const factory parameter(String value) = Parameter;
  const factory integer(int value) = Int;
  const factory str(String value) = Str;
}

@boilerplate
final class const Variable(final String value) extends Term {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const Int(final int value) extends MapKey {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const Str(final String value) extends MapKey {
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

  new(DateTime date) : value = date.millisecondsSinceEpoch ~/ 1_000;

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
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const Bool(final bool value) extends Term {
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
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const Parameter(final String value) extends MapKey {
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
  String toString() => _toString();
}

@boilerplate
final class const Array(final List<Term> value) extends Term {
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
  const factory ffi(String name) = UnFfi;
}

@boilerplate
final class const Negate() extends Unary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Parens() extends Unary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Length() extends Unary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Type() extends Unary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const UnFfi(final String name) extends Unary {
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
  const factory ffi(String name) = BinFfi;
}

@boilerplate
final class const LessThan() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const GreaterThan() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const LessOrEqual() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const GreaterOrEqual() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Equal() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Contains() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Prefix() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Suffix() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Regex() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Add() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Sub() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Mul() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Div() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const And() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Or() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Intersection() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Union() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const BitwiseAnd() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const BitwiseOr() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const BitwiseXor() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const NotEqual() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const HeterogeneousEqual() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const HeterogeneousNotEqual() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const LazyAnd() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const LazyOr() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const All() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Any() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Get() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const TryOr() extends Binary {
  @override
  String toString() => _toString();
}

@boilerplate
final class const BinFfi(final String name) extends Binary {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const Closure({
  required final List<String> params,
  required final List<Op> ops,
}) extends Op {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
