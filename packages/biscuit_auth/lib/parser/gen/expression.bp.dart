// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../expression.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $ValueExprExtension on ValueExpr {
  bool _equals(Object other) =>
      identical(this, other) || other is ValueExpr && term == other.term;

  int get _hashCode => Object.hash('ValueExpr', term);

  String _toString() => 'ValueExpr(term: $term)';
}

extension $UnaryExprExtension on UnaryExpr {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is UnaryExpr && op == other.op && expr == other.expr;

  int get _hashCode => Object.hash('UnaryExpr', op, expr);

  String _toString() => 'UnaryExpr(op: $op, expr: $expr)';
}

extension $BinaryExprExtension on BinaryExpr {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is BinaryExpr &&
          op == other.op &&
          left == other.left &&
          right == other.right;

  int get _hashCode => Object.hash('BinaryExpr', op, left, right);

  String _toString() => 'BinaryExpr(op: $op, left: $left, right: $right)';
}

extension $ClosureExprExtension on ClosureExpr {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ClosureExpr &&
          const ListEquality().equals(params, other.params) &&
          expr == other.expr;

  int get _hashCode =>
      Object.hash('ClosureExpr', const ListEquality().hash(params), expr);

  String _toString() => 'ClosureExpr(params: $params, expr: $expr)';
}
