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
          const ListEquality<Scope>().equals(scopes, other.scopes) &&
          const ListEquality<Fact>().equals(facts, other.facts) &&
          const ListEquality<Rule>().equals(rules, other.rules) &&
          const ListEquality<Check>().equals(checks, other.checks) &&
          const ListEquality<Policy>().equals(policies, other.policies);

  int get _hashCode => Object.hash(
    'Source',
    const ListEquality<Scope>().hash(scopes),
    const ListEquality<Fact>().hash(facts),
    const ListEquality<Rule>().hash(rules),
    const ListEquality<Check>().hash(checks),
    const ListEquality<Policy>().hash(policies),
  );

  String _toString() =>
      'Source(scopes: $scopes, facts: $facts, rules: $rules, checks: $checks, policies: $policies)';
}
