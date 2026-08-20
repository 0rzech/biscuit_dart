// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../source.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $SourceExtension on Source {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is Source &&
          const ListEquality().equals(scopes, other.scopes) &&
          const ListEquality().equals(facts, other.facts) &&
          const ListEquality().equals(rules, other.rules) &&
          const ListEquality().equals(checks, other.checks) &&
          const ListEquality().equals(policies, other.policies);

  int get _hashCode => Object.hash(
    'Source',
    const ListEquality().hash(scopes),
    const ListEquality().hash(facts),
    const ListEquality().hash(rules),
    const ListEquality().hash(checks),
    const ListEquality().hash(policies),
  );

  String _toString() =>
      'Source(scopes: $scopes, facts: $facts, rules: $rules, checks: $checks, policies: $policies)';
}
