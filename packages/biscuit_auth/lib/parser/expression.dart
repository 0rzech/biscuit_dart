// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/parser/builder/expression/op.dart';
import 'package:biscuit_auth/parser/builder/term.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

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

final class const ValueExpr(final Term term) extends Expr {
  @override
  void addOps(List<Op> ops) => ops.add(.value(term));

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ValueExpr && term == other.term;

  @override
  int get hashCode => Object.hash('ValueExpr', term);

  @override
  String toString() => 'ValueExpr(term: $term)';
}

final class const UnaryExpr(final UnaryOp op, final Expr expr) extends Expr {
  @override
  String? validate() => expr.validate();

  @override
  void addOps(List<Op> ops) {
    expr.addOps(ops);
    ops.add(op);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnaryExpr && op == other.op && expr == other.expr;

  @override
  int get hashCode => Object.hash('UnaryExpr', op, expr);

  @override
  String toString() => 'UnaryExpr(op: $op, expr: $expr)';
}

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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BinaryExpr &&
          op == other.op &&
          left == other.left &&
          right == other.right;

  @override
  int get hashCode => Object.hash('BinaryExpr', op, left, right);

  @override
  String toString() => 'BinaryExpr(op: $op, left: $left, right: $right)';
}

final class const ClosureExpr(final List<String> params, final Expr expr)
    extends Expr {
  @override
  String? validate() => expr.validate();

  @override
  void addOps(List<Op> ops) =>
      ops.add(.closure(params: params, ops: expr.toOpcodes()));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClosureExpr &&
          const ListEquality().equals(params, other.params) &&
          expr == other.expr;

  @override
  int get hashCode =>
      Object.hash('ClosureExpr', const ListEquality().hash(params), expr);

  @override
  String toString() => 'ClosureExpr(params: $params, expr: $expr)';
}
