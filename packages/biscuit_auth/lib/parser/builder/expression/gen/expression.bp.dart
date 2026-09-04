// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../expression.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $ExpressionExtension on Expression {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is Expression &&
          const ListEquality<Op>().equals(ops.value, other.ops.value);

  int get _hashCode =>
      Object.hash('Expression', const ListEquality<Op>().hash(ops.value));

  String _toString() => 'Expression(ops: $ops)';
}
