// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/parser/builder/expression/op.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/expression.bp.dart';

@immutable
sealed class const Expr() {
  const factory value(Term term) = ValueExpr;
  const factory unary(UnaryOp op, Expr expr) = UnaryExpr;
  const factory binary(BinaryOp op, Expr left, Expr right) = BinaryExpr;
  const factory closure(List<String> params, Expr expr) = ClosureExpr;

  bool get isComparison => false;

  String? validate() => null;

  List<Op> toOpcodes() {
    final ops = <Op>[];
    addOps(ops);
    return ops;
  }

  @visibleForTesting
  void addOps(List<Op> ops);
}

@boilerplate
final class const ValueExpr(final Term term) extends Expr {
  @override
  void addOps(List<Op> ops) => ops.add(term);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const UnaryExpr(final UnaryOp op, final Expr expr) extends Expr {
  @override
  String? validate() => expr.validate();

  @override
  void addOps(List<Op> ops) {
    expr.addOps(ops);
    ops.add(op);
  }

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const BinaryExpr(
  final BinaryOp op,
  final Expr left,
  final Expr right,
) extends Expr {
  @override
  bool get isComparison => switch (op) {
    const .lessOrEqual() ||
    const .greaterOrEqual() ||
    const .lessThan() ||
    const .greaterThan() ||
    const .equal() ||
    const .notEqual() ||
    const .heterogeneousEqual() ||
    const .heterogeneousNotEqual() => true,
    _ => false,
  };

  @override
  String? validate() {
    return isComparison && (left.isComparison || right.isComparison)
        ? 'Associative comparisons are forbidden. Use parentheses for grouping.'
        : left.validate() ?? right.validate();
  }

  @override
  void addOps(List<Op> ops) {
    left.addOps(ops);
    right.addOps(ops);
    ops.add(op);
  }

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const ClosureExpr(final List<String> params, final Expr expr)
    extends Expr {
  @override
  String? validate() => expr.validate();

  @override
  void addOps(List<Op> ops) =>
      ops.add(.closure(params: params, ops: expr.toOpcodes()));

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
