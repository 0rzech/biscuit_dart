// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/datalog/term.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/op.bp.dart';

@immutable
sealed class const Op() {
  const factory value(Term term) = ValueOp;
  const factory negate() = UnaryOp.negate;
  const factory parens() = UnaryOp.parens;
  const factory length() = UnaryOp.length;
  const factory type() = UnaryOp.type;
  const factory unFfi(SymbolId name) = UnFfi;
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
  const factory binFfi(SymbolId id) = BinaryOp.ffi;
  const factory closure({
    required List<SymbolId> params,
    required List<Op> ops,
  }) = ClosureOp;
}

@boilerplate
final class const ValueOp(final Term term) extends Op {
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
  const factory ffi(SymbolId id) = UnFfi;

  String stringify(String symbol, SymbolTable symbols);
}

@boilerplate
final class const Negate() extends UnaryOp {
  @override
  String stringify(String symbol, SymbolTable _) => '!$symbol';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Parens() extends UnaryOp {
  @override
  String stringify(String symbol, SymbolTable _) => '($symbol)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Length() extends UnaryOp {
  @override
  String stringify(String symbol, SymbolTable _) => '$symbol.length()';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Type() extends UnaryOp {
  @override
  String stringify(String symbol, SymbolTable _) => '$symbol.type()';

  @override
  String toString() => _toString();
}

@boilerplate
final class const UnFfi(final SymbolId id) extends UnaryOp {
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
  const factory ffi(SymbolId id) = BinFfi;

  String stringify(String left, String right, SymbolTable symbols);
}

@boilerplate
final class const LessThan() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left < $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const GreaterThan() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left > $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const LessOrEqual() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left <= $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const GreaterOrEqual() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left >= $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Equal() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left === $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Contains() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.contains($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Prefix() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.starts_with($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Suffix() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.ends_with($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Regex() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.matches($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Add() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left + $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Sub() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left - $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Mul() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left * $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Div() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left / $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const And() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left &&! $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Or() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left ||! $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Intersection() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.intersection($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Union() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.union($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const BitwiseAnd() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left & $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const BitwiseOr() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left | $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const BitwiseXor() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left ^ $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const NotEqual() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left !== $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const HeterogeneousEqual() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left == $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const HeterogeneousNotEqual() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left != $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const LazyAnd() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left && $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const LazyOr() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left || $right';

  @override
  String toString() => _toString();
}

@boilerplate
final class const All() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.all($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Any() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.any($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const Get() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.get($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const TryOr() extends BinaryOp {
  @override
  String stringify(String left, String right, SymbolTable _) =>
      '$left.tryOr($right)';

  @override
  String toString() => _toString();
}

@boilerplate
final class const BinFfi(final SymbolId id) extends BinaryOp {
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
final class const ClosureOp({
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
