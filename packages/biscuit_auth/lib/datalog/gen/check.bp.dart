// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../check.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $OneCheckExtension on OneCheck {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is OneCheck &&
          const ListEquality<Rule>().equals(queries, other.queries);

  int get _hashCode =>
      Object.hash('OneCheck', const ListEquality<Rule>().hash(queries));

  String _toString() => 'OneCheck(queries: $queries)';
}

extension $AllCheckExtension on AllCheck {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is AllCheck &&
          const ListEquality<Rule>().equals(queries, other.queries);

  int get _hashCode =>
      Object.hash('AllCheck', const ListEquality<Rule>().hash(queries));

  String _toString() => 'AllCheck(queries: $queries)';
}

extension $RejectCheckExtension on RejectCheck {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is RejectCheck &&
          const ListEquality<Rule>().equals(queries, other.queries);

  int get _hashCode =>
      Object.hash('RejectCheck', const ListEquality<Rule>().hash(queries));

  String _toString() => 'RejectCheck(queries: $queries)';
}
