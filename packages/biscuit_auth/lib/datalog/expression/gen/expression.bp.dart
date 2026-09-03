// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../expression.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $ExternFnExtension on ExternFn {
  bool _equals(Object other) =>
      identical(this, other) || other is ExternFn && callback == other.callback;

  int get _hashCode => Object.hash('ExternFn', callback);
}

extension $ExpressionExtension on Expression {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is Expression && const ListEquality<Op>().equals(ops, other.ops);

  int get _hashCode =>
      Object.hash('Expression', const ListEquality<Op>().hash(ops));

  String _toString() => 'Expression(ops: $ops)';
}
