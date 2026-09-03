// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:typed_data';

import 'package:biscuit_auth/parser/builder/compare_to.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/op.bp.dart';

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

  const factory negate() = UnaryOp.negate;
  const factory parens() = UnaryOp.parens;
  const factory length() = UnaryOp.length;
  const factory type() = UnaryOp.type;
  const factory unFfi(String name) = UnaryOp.ffi;

  const factory lessThan() = BinaryOp.lessThan;
  const factory greaterThan() = BinaryOp.greaterThan;
  const factory lessOrEqual() = BinaryOp.lessOrEqual;
  const factory greaterOrEqual() = BinaryOp.greaterOrEqual;
  const factory equal() = BinaryOp.equal;
  const factory contains() = BinaryOp.contains;
  const factory prefix() = BinaryOp.prefix;
  const factory suffix() = BinaryOp.suffix;
  const factory regex() = BinaryOp.regex;
  const factory add() = BinaryOp.add;
  const factory sub() = BinaryOp.sub;
  const factory mul() = BinaryOp.mul;
  const factory div() = BinaryOp.div;
  const factory and() = BinaryOp.and;
  const factory or() = BinaryOp.or;
  const factory intersection() = BinaryOp.intersection;
  const factory union() = BinaryOp.union;
  const factory bitwiseAnd() = BinaryOp.bitwiseAnd;
  const factory bitwiseOr() = BinaryOp.bitwiseOr;
  const factory bitwiseXor() = BinaryOp.bitwiseXor;
  const factory notEqual() = BinaryOp.notEqual;
  const factory heterogeneousEqual() = BinaryOp.heterogeneousEqual;
  const factory heterogeneousNotEqual() = BinaryOp.heterogeneousNotEqual;
  const factory lazyAnd() = BinaryOp.lazyAnd;
  const factory lazyOr() = BinaryOp.lazyOr;
  const factory all() = BinaryOp.all;
  const factory any() = BinaryOp.any;
  const factory get() = BinaryOp.get;
  const factory tryOr() = BinaryOp.tryOr;
  const factory binFfi(String name) = BinaryOp.ffi;

  const factory closure({required List<String> params, required List<Op> ops}) =
      ClosureOp;

  void collectParameters(HashMap<String, Term?> parameters) {
    switch (this) {
      case final Term term:
        term.extractParameters(parameters);
      case ClosureOp(params: _, :final ops):
        for (final op in ops) {
          op.collectParameters(parameters);
        }
      default:
        {}
    }
  }
}

sealed class const Term() extends Op implements Comparable<Term> {
  const factory variable(String value) = VariableTerm;
  const factory int(int value) = IntTerm;
  const factory str(String value) = StrTerm;
  factory date(DateTime value) = DateTerm;
  const factory bytes(Uint8List value) = BytesTerm;
  const factory bool(bool value) = BoolTerm;
  const factory set(SplayTreeSet<Term> value) = SetTerm;
  const factory parameter(String value) = ParameterTerm;
  const factory nil() = NilTerm;
  const factory array(List<Term> value) = ArrayTerm;
  const factory map(SplayTreeMap<MapKey, Term> value) = MapTerm;

  void extractParameters(HashMap<String, Term?> parameters) {
    switch (this) {
      case ParameterTerm(:final value):
        parameters[value] = null;

      case SetTerm(:final value):
        for (final item in value) {
          item.extractParameters(parameters);
        }

      case ArrayTerm(:final value):
        for (final item in value) {
          item.extractParameters(parameters);
        }

      case MapTerm(:final value):
        for (final MapEntry(:key, value: term) in value.entries) {
          if (key case ParameterTerm(value: final parameter)) {
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
        VariableTerm(:final value) => value.compareTo(
          (other as VariableTerm).value,
        ),
        IntTerm(:final value) => value.compareTo((other as IntTerm).value),
        StrTerm(:final value) => value.compareTo((other as StrTerm).value),
        DateTerm(:final value) => value.compareTo((other as DateTerm).value),
        BytesTerm(:final value) => value.compareTo((other as BytesTerm).value),
        BoolTerm(:final value) => value.compareTo((other as BoolTerm).value),
        SetTerm(:final value) => value.compareTo((other as SetTerm).value),
        ParameterTerm(:final value) => value.compareTo(
          (other as ParameterTerm).value,
        ),
        NilTerm _ => 0,
        ArrayTerm(:final value) => value.compareTo((other as ArrayTerm).value),
        MapTerm(:final value) => value.compareTo((other as MapTerm).value),
      };
    }

    return _typeOrder(this).compareTo(_typeOrder(other));
  }

  int _typeOrder(Term term) => switch (term) {
    VariableTerm _ => 0,
    IntTerm _ => 1,
    StrTerm _ => 2,
    DateTerm _ => 3,
    BytesTerm _ => 4,
    BoolTerm _ => 5,
    SetTerm _ => 6,
    ParameterTerm _ => 7,
    NilTerm _ => 8,
    ArrayTerm _ => 9,
    MapTerm _ => 10,
  };
}

sealed class const MapKey() extends Term {
  const factory parameter(String value) = ParameterTerm;
  const factory integer(int value) = IntTerm;
  const factory str(String value) = StrTerm;
}

@boilerplate
final class const VariableTerm(final String value) extends Term {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const IntTerm(final int value) extends MapKey {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const StrTerm(final String value) extends MapKey {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class DateTerm extends Term {
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
final class const BytesTerm(final Uint8List value) extends Term {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const BoolTerm(final bool value) extends Term {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const SetTerm(final SplayTreeSet<Term> value) extends Term {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const ParameterTerm(final String value) extends MapKey {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const NilTerm() extends Term {
  @override
  String toString() => _toString();
}

@boilerplate
final class const ArrayTerm(final List<Term> value) extends Term {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const MapTerm(final SplayTreeMap<MapKey, Term> value) extends Term {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

sealed class const UnaryOp() extends Op {
  const factory negate() = Negate;
  const factory parens() = Parens;
  const factory length() = Length;
  const factory type() = Type;
  const factory ffi(String name) = UnFfi;
}

@boilerplate
final class const Negate() extends UnaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Parens() extends UnaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Length() extends UnaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Type() extends UnaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const UnFfi(final String name) extends UnaryOp {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

sealed class const BinaryOp() extends Op {
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
final class const LessThan() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const GreaterThan() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const LessOrEqual() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const GreaterOrEqual() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Equal() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Contains() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Prefix() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Suffix() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Regex() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Add() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Sub() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Mul() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Div() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const And() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Or() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Intersection() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Union() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const BitwiseAnd() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const BitwiseOr() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const BitwiseXor() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const NotEqual() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const HeterogeneousEqual() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const HeterogeneousNotEqual() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const LazyAnd() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const LazyOr() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const All() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Any() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const Get() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const TryOr() extends BinaryOp {
  @override
  String toString() => _toString();
}

@boilerplate
final class const BinFfi(final String name) extends BinaryOp {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const ClosureOp({
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
