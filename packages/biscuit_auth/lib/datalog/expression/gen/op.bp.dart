// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../op.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $VariableExtension on Variable {
  bool _equals(Object other) =>
      identical(this, other) || other is Variable && id == other.id;

  int get _hashCode => Object.hash('Variable', id);

  String _toString() => 'Variable(id: $id)';
}

extension $IntExtension on Int {
  bool _equals(Object other) =>
      identical(this, other) || other is Int && value == other.value;

  int get _hashCode => Object.hash('Int', value);

  String _toString() => 'Int(value: $value)';
}

extension $StrExtension on Str {
  bool _equals(Object other) =>
      identical(this, other) || other is Str && id == other.id;

  int get _hashCode => Object.hash('Str', id);

  String _toString() => 'Str(id: $id)';
}

extension $DateExtension on Date {
  bool _equals(Object other) =>
      identical(this, other) || other is Date && value == other.value;

  int get _hashCode => Object.hash('Date', value);

  String _toString() => 'Date(value: $value)';
}

extension $BytesExtension on Bytes {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is Bytes && const ListEquality<int>().equals(value, other.value);

  int get _hashCode =>
      Object.hash('Bytes', const ListEquality<int>().hash(value));

  String _toString() => 'Bytes(value: $value)';
}

extension $BoolExtension on Bool {
  bool _equals(Object other) =>
      identical(this, other) || other is Bool && value == other.value;

  int get _hashCode => Object.hash('Bool', value);

  String _toString() => 'Bool(value: $value)';
}

extension $SetExtension on Set {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is Set && const SetEquality<Term>().equals(value, other.value);

  int get _hashCode =>
      Object.hash('Set', const SetEquality<Term>().hash(value));

  String _toString() => 'Set(value: $value)';
}

extension $NilExtension on Nil {
  String _toString() => 'Nil()';
}

extension $ArrayExtension on Array {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is Array && const ListEquality<Term>().equals(value, other.value);

  int get _hashCode =>
      Object.hash('Array', const ListEquality<Term>().hash(value));

  String _toString() => 'Array(value: $value)';
}

extension $MapExtension on Map {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is Map &&
          const MapEquality<MapKey, Term>().equals(value, other.value);

  int get _hashCode =>
      Object.hash('Map', const MapEquality<MapKey, Term>().hash(value));

  String _toString() => 'Map(value: $value)';
}

extension $NegateExtension on Negate {
  String _toString() => 'Negate()';
}

extension $ParensExtension on Parens {
  String _toString() => 'Parens()';
}

extension $LengthExtension on Length {
  String _toString() => 'Length()';
}

extension $TypeExtension on Type {
  String _toString() => 'Type()';
}

extension $UnFfiExtension on UnFfi {
  bool _equals(Object other) =>
      identical(this, other) || other is UnFfi && id == other.id;

  int get _hashCode => Object.hash('UnFfi', id);

  String _toString() => 'UnFfi(id: $id)';
}

extension $LessThanExtension on LessThan {
  String _toString() => 'LessThan()';
}

extension $GreaterThanExtension on GreaterThan {
  String _toString() => 'GreaterThan()';
}

extension $LessOrEqualExtension on LessOrEqual {
  String _toString() => 'LessOrEqual()';
}

extension $GreaterOrEqualExtension on GreaterOrEqual {
  String _toString() => 'GreaterOrEqual()';
}

extension $EqualExtension on Equal {
  String _toString() => 'Equal()';
}

extension $ContainsExtension on Contains {
  String _toString() => 'Contains()';
}

extension $PrefixExtension on Prefix {
  String _toString() => 'Prefix()';
}

extension $SuffixExtension on Suffix {
  String _toString() => 'Suffix()';
}

extension $RegexExtension on Regex {
  String _toString() => 'Regex()';
}

extension $AddExtension on Add {
  String _toString() => 'Add()';
}

extension $SubExtension on Sub {
  String _toString() => 'Sub()';
}

extension $MulExtension on Mul {
  String _toString() => 'Mul()';
}

extension $DivExtension on Div {
  String _toString() => 'Div()';
}

extension $AndExtension on And {
  String _toString() => 'And()';
}

extension $OrExtension on Or {
  String _toString() => 'Or()';
}

extension $IntersectionExtension on Intersection {
  String _toString() => 'Intersection()';
}

extension $UnionExtension on Union {
  String _toString() => 'Union()';
}

extension $BitwiseAndExtension on BitwiseAnd {
  String _toString() => 'BitwiseAnd()';
}

extension $BitwiseOrExtension on BitwiseOr {
  String _toString() => 'BitwiseOr()';
}

extension $BitwiseXorExtension on BitwiseXor {
  String _toString() => 'BitwiseXor()';
}

extension $NotEqualExtension on NotEqual {
  String _toString() => 'NotEqual()';
}

extension $HeterogeneousEqualExtension on HeterogeneousEqual {
  String _toString() => 'HeterogeneousEqual()';
}

extension $HeterogeneousNotEqualExtension on HeterogeneousNotEqual {
  String _toString() => 'HeterogeneousNotEqual()';
}

extension $LazyAndExtension on LazyAnd {
  String _toString() => 'LazyAnd()';
}

extension $LazyOrExtension on LazyOr {
  String _toString() => 'LazyOr()';
}

extension $AllExtension on All {
  String _toString() => 'All()';
}

extension $AnyExtension on Any {
  String _toString() => 'Any()';
}

extension $GetExtension on Get {
  String _toString() => 'Get()';
}

extension $TryOrExtension on TryOr {
  String _toString() => 'TryOr()';
}

extension $BinFfiExtension on BinFfi {
  bool _equals(Object other) =>
      identical(this, other) || other is BinFfi && id == other.id;

  int get _hashCode => Object.hash('BinFfi', id);

  String _toString() => 'BinFfi(id: $id)';
}

extension $ClosureExtension on Closure {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is Closure &&
          const ListEquality<SymbolId>().equals(params, other.params) &&
          const ListEquality<Op>().equals(ops, other.ops);

  int get _hashCode => Object.hash(
    'Closure',
    const ListEquality<SymbolId>().hash(params),
    const ListEquality<Op>().hash(ops),
  );

  String _toString() => 'Closure(params: $params, ops: $ops)';
}
