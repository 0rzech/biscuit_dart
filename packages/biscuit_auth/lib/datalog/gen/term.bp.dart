// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../term.dart';

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
