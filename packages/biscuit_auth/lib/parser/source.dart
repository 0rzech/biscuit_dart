// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/parser/builder/check.dart';
import 'package:biscuit_auth/parser/builder/fact.dart';
import 'package:biscuit_auth/parser/builder/policy.dart';
import 'package:biscuit_auth/parser/builder/rule.dart';
import 'package:biscuit_auth/parser/builder/scope.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:collection/collection.dart';

part 'gen/source.boilerplate.dart';

@boilerplate
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
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
