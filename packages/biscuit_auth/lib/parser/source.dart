// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/parser/builder/check.dart';
import 'package:biscuit_auth/parser/builder/fact.dart';
import 'package:biscuit_auth/parser/builder/policy.dart';
import 'package:biscuit_auth/parser/builder/rule.dart';
import 'package:biscuit_auth/parser/builder/scope.dart';
import 'package:collection/collection.dart';

final class const Source({
  required final List<Scope> scopes,
  required final List<Fact> facts,
  required final List<Rule> rules,
  required final List<Check> checks,
  required final List<Policy> policies,
}) {
  factory empty({
    List<Scope>? scopes,
    List<Fact>? facts,
    List<Rule>? rules,
    List<Check>? checks,
    List<Policy>? policies,
  }) => .new(
    scopes: scopes ?? [],
    facts: facts ?? [],
    rules: rules ?? [],
    checks: checks ?? [],
    policies: policies ?? [],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Source &&
          const ListEquality().equals(scopes, other.scopes) &&
          const ListEquality().equals(facts, other.facts) &&
          const ListEquality().equals(rules, other.rules) &&
          const ListEquality().equals(checks, other.checks) &&
          const ListEquality().equals(policies, other.policies);

  @override
  int get hashCode => Object.hash(
    'Source',
    const ListEquality().hash(scopes),
    const ListEquality().hash(facts),
    const ListEquality().hash(rules),
    const ListEquality().hash(checks),
    const ListEquality().hash(policies),
  );

  @override
  String toString() =>
      'Source(scopes: $scopes, facts: $facts, rules: $rules, '
      'checks: $checks, policies: $policies)';
}
