// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../check.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $OneCheckExtension on OneCheck {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is OneCheck && const ListEquality().equals(rules, other.rules);

  int get _hashCode =>
      Object.hash('OneCheck', const ListEquality().hash(rules));

  String _toString() => 'OneCheck(rules: $rules)';
}

extension $AllCheckExtension on AllCheck {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is AllCheck && const ListEquality().equals(rules, other.rules);

  int get _hashCode =>
      Object.hash('AllCheck', const ListEquality().hash(rules));

  String _toString() => 'AllCheck(rules: $rules)';
}

extension $RejectCheckExtension on RejectCheck {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is RejectCheck && const ListEquality().equals(rules, other.rules);

  int get _hashCode =>
      Object.hash('RejectCheck', const ListEquality().hash(rules));

  String _toString() => 'RejectCheck(rules: $rules)';
}
