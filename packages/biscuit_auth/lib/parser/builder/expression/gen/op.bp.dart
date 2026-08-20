// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../op.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $ValueOpExtension on ValueOp {
  bool _equals(Object other) =>
      identical(this, other) || other is ValueOp && term == other.term;

  int get _hashCode => Object.hash('ValueOp', term);

  String _toString() => 'ValueOp(term: $term)';
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
      identical(this, other) || other is UnFfi && name == other.name;

  int get _hashCode => Object.hash('UnFfi', name);

  String _toString() => 'UnFfi(name: $name)';
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
      identical(this, other) || other is BinFfi && name == other.name;

  int get _hashCode => Object.hash('BinFfi', name);

  String _toString() => 'BinFfi(name: $name)';
}

extension $ClosureOpExtension on ClosureOp {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ClosureOp &&
          const ListEquality().equals(params, other.params) &&
          const ListEquality().equals(ops, other.ops);

  int get _hashCode => Object.hash(
    'ClosureOp',
    const ListEquality().hash(params),
    const ListEquality().hash(ops),
  );

  String _toString() => 'ClosureOp(params: $params, ops: $ops)';
}
