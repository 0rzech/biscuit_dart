// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/parser/builder/term.dart';
import 'package:collection/collection.dart';

sealed class const Op() {
  const factory value(Term term) = ValueOp;
  const factory negate() = UnaryOp.negate;
  const factory parens() = UnaryOp.parens;
  const factory length() = UnaryOp.length;
  const factory type() = UnaryOp.type;
  const factory unFfi(String name) = UnFfi;
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
      case ValueOp(:final term):
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

final class const ValueOp(final Term term) extends Op {
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ValueOp && term == other.term;

  @override
  int get hashCode => Object.hash('ValueOp', term);

  @override
  String toString() => 'ValueOp($term)';
}

sealed class const UnaryOp() extends Op {
  const factory negate() = Negate;
  const factory parens() = Parens;
  const factory length() = Length;
  const factory type() = Type;
  const factory ffi(String name) = UnFfi;
}

final class const Negate() extends UnaryOp {
  @override
  String toString() => 'Negate';
}

final class const Parens() extends UnaryOp {
  @override
  String toString() => 'Parens';
}

final class const Length() extends UnaryOp {
  @override
  String toString() => 'Length';
}

final class const Type() extends UnaryOp {
  @override
  String toString() => 'Type';
}

final class const UnFfi(final String name) extends UnaryOp {
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UnFfi && name == other.name;

  @override
  int get hashCode => Object.hash('UnFfi', name);

  @override
  String toString() => 'UnFfi($name)';
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

final class const LessThan() extends BinaryOp {
  @override
  String toString() => 'LessThan';
}

final class const GreaterThan() extends BinaryOp {
  @override
  String toString() => 'GreaterThan';
}

final class const LessOrEqual() extends BinaryOp {
  @override
  String toString() => 'LessOrEqual';
}

final class const GreaterOrEqual() extends BinaryOp {
  @override
  String toString() => 'GreaterOrEqual';
}

final class const Equal() extends BinaryOp {
  @override
  String toString() => 'Equal';
}

final class const Contains() extends BinaryOp {
  @override
  String toString() => 'Contains';
}

final class const Prefix() extends BinaryOp {
  @override
  String toString() => 'Prefix';
}

final class const Suffix() extends BinaryOp {
  @override
  String toString() => 'Suffix';
}

final class const Regex() extends BinaryOp {
  @override
  String toString() => 'Regex';
}

final class const Add() extends BinaryOp {
  @override
  String toString() => 'Add';
}

final class const Sub() extends BinaryOp {
  @override
  String toString() => 'Sub';
}

final class const Mul() extends BinaryOp {
  @override
  String toString() => 'Mul';
}

final class const Div() extends BinaryOp {
  @override
  String toString() => 'Div';
}

final class const And() extends BinaryOp {
  @override
  String toString() => 'And';
}

final class const Or() extends BinaryOp {
  @override
  String toString() => 'Or';
}

final class const Intersection() extends BinaryOp {
  @override
  String toString() => 'Intersection';
}

final class const Union() extends BinaryOp {
  @override
  String toString() => 'Union';
}

final class const BitwiseAnd() extends BinaryOp {
  @override
  String toString() => 'BitwiseAnd';
}

final class const BitwiseOr() extends BinaryOp {
  @override
  String toString() => 'BitwiseOr';
}

final class const BitwiseXor() extends BinaryOp {
  @override
  String toString() => 'BitwiseXor';
}

final class const NotEqual() extends BinaryOp {
  @override
  String toString() => 'NotEqual';
}

final class const HeterogeneousEqual() extends BinaryOp {
  @override
  String toString() => 'HeterogeneousEqual';
}

final class const HeterogeneousNotEqual() extends BinaryOp {
  @override
  String toString() => 'HeterogeneousNotEqual';
}

final class const LazyAnd() extends BinaryOp {
  @override
  String toString() => 'LazyAnd';
}

final class const LazyOr() extends BinaryOp {
  @override
  String toString() => 'LazyOr';
}

final class const All() extends BinaryOp {
  @override
  String toString() => 'All';
}

final class const Any() extends BinaryOp {
  @override
  String toString() => 'Any';
}

final class const Get() extends BinaryOp {
  @override
  String toString() => 'Get';
}

final class const TryOr() extends BinaryOp {
  @override
  String toString() => 'TryOr';
}

final class const BinFfi(final String name) extends BinaryOp {
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BinFfi && name == other.name;

  @override
  int get hashCode => Object.hash('BinFfi', name);

  @override
  String toString() => 'BinFfi($name)';
}

final class const ClosureOp({
  required final List<String> params,
  required final List<Op> ops,
}) extends Op {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClosureOp &&
          const ListEquality().equals(params, other.params) &&
          const ListEquality().equals(ops, other.ops);

  @override
  int get hashCode => Object.hash(
    'ClosureOp',
    const ListEquality().hash(params),
    const ListEquality().hash(ops),
  );

  @override
  String toString() => 'ClosureOp(params: $params, ops: $ops)';
}
