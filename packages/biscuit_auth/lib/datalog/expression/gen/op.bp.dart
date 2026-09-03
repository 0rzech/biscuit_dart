// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../op.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $VariableTermExtension on VariableTerm {
  bool _equals(Object other) =>
      identical(this, other) || other is VariableTerm && id == other.id;

  int get _hashCode => Object.hash('VariableTerm', id);

  String _toString() => 'VariableTerm(id: $id)';
}

extension $IntTermExtension on IntTerm {
  bool _equals(Object other) =>
      identical(this, other) || other is IntTerm && value == other.value;

  int get _hashCode => Object.hash('IntTerm', value);

  String _toString() => 'IntTerm(value: $value)';
}

extension $StrTermExtension on StrTerm {
  bool _equals(Object other) =>
      identical(this, other) || other is StrTerm && id == other.id;

  int get _hashCode => Object.hash('StrTerm', id);

  String _toString() => 'StrTerm(id: $id)';
}

extension $DateTermExtension on DateTerm {
  bool _equals(Object other) =>
      identical(this, other) || other is DateTerm && value == other.value;

  int get _hashCode => Object.hash('DateTerm', value);

  String _toString() => 'DateTerm(value: $value)';
}

extension $BytesTermExtension on BytesTerm {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is BytesTerm &&
          const ListEquality<int>().equals(value, other.value);

  int get _hashCode =>
      Object.hash('BytesTerm', const ListEquality<int>().hash(value));

  String _toString() => 'BytesTerm(value: $value)';
}

extension $BoolTermExtension on BoolTerm {
  bool _equals(Object other) =>
      identical(this, other) || other is BoolTerm && value == other.value;

  int get _hashCode => Object.hash('BoolTerm', value);

  String _toString() => 'BoolTerm(value: $value)';
}

extension $SetTermExtension on SetTerm {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is SetTerm && const SetEquality<Term>().equals(value, other.value);

  int get _hashCode =>
      Object.hash('SetTerm', const SetEquality<Term>().hash(value));

  String _toString() => 'SetTerm(value: $value)';
}

extension $NilTermExtension on NilTerm {
  String _toString() => 'NilTerm()';
}

extension $ArrayTermExtension on ArrayTerm {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ArrayTerm &&
          const ListEquality<Term>().equals(value, other.value);

  int get _hashCode =>
      Object.hash('ArrayTerm', const ListEquality<Term>().hash(value));

  String _toString() => 'ArrayTerm(value: $value)';
}

extension $MapTermExtension on MapTerm {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is MapTerm &&
          const MapEquality<MapKey, Term>().equals(value, other.value);

  int get _hashCode =>
      Object.hash('MapTerm', const MapEquality<MapKey, Term>().hash(value));

  String _toString() => 'MapTerm(value: $value)';
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

extension $ClosureOpExtension on ClosureOp {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ClosureOp &&
          const ListEquality<SymbolId>().equals(params, other.params) &&
          const ListEquality<Op>().equals(ops, other.ops);

  int get _hashCode => Object.hash(
    'ClosureOp',
    const ListEquality<SymbolId>().hash(params),
    const ListEquality<Op>().hash(ops),
  );

  String _toString() => 'ClosureOp(params: $params, ops: $ops)';
}
