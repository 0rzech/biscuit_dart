// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../term.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $VariableTermExtension on VariableTerm {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is VariableTerm && variable == other.variable;

  int get _hashCode => Object.hash('VariableTerm', variable);

  String _toString() => 'VariableTerm(variable: $variable)';
}

extension $IntegerTermExtension on IntegerTerm {
  bool _equals(Object other) =>
      identical(this, other) || other is IntegerTerm && value == other.value;

  int get _hashCode => Object.hash('IntegerTerm', value);

  String _toString() => 'IntegerTerm(value: $value)';
}

extension $StrTermExtension on StrTerm {
  bool _equals(Object other) =>
      identical(this, other) || other is StrTerm && string == other.string;

  int get _hashCode => Object.hash('StrTerm', string);

  String _toString() => 'StrTerm(string: $string)';
}

extension $DateTermExtension on DateTerm {
  bool _equals(Object other) =>
      identical(this, other) || other is DateTerm && date == other.date;

  int get _hashCode => Object.hash('DateTerm', date);

  String _toString() => 'DateTerm(date: $date)';
}

extension $BytesTermExtension on BytesTerm {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is BytesTerm && const ListEquality().equals(bytes, other.bytes);

  int get _hashCode =>
      Object.hash('BytesTerm', const ListEquality().hash(bytes));

  String _toString() => 'BytesTerm(bytes: $bytes)';
}

extension $BoolTermExtension on BoolTerm {
  bool _equals(Object other) =>
      identical(this, other) || other is BoolTerm && boolean == other.boolean;

  int get _hashCode => Object.hash('BoolTerm', boolean);

  String _toString() => 'BoolTerm(boolean: $boolean)';
}

extension $SetTermExtension on SetTerm {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is SetTerm && const SetEquality().equals(set, other.set);

  int get _hashCode => Object.hash('SetTerm', const SetEquality().hash(set));

  String _toString() => 'SetTerm(set: $set)';
}

extension $ParameterTermExtension on ParameterTerm {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ParameterTerm && parameter == other.parameter;

  int get _hashCode => Object.hash('ParameterTerm', parameter);

  String _toString() => 'ParameterTerm(parameter: $parameter)';
}

extension $NilTermExtension on NilTerm {
  String _toString() => 'NilTerm()';
}

extension $ArrayTermExtension on ArrayTerm {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ArrayTerm && const ListEquality().equals(array, other.array);

  int get _hashCode =>
      Object.hash('ArrayTerm', const ListEquality().hash(array));

  String _toString() => 'ArrayTerm(array: $array)';
}

extension $MapTermExtension on MapTerm {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is MapTerm && const MapEquality().equals(map, other.map);

  int get _hashCode => Object.hash('MapTerm', const MapEquality().hash(map));

  String _toString() => 'MapTerm(map: $map)';
}
