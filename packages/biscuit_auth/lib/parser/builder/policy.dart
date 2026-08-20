// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/parser/builder/rule.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:collection/collection.dart';

part 'gen/policy.boilerplate.dart';

sealed class const Policy(final List<Rule> rules) {
  const factory allow(List<Rule> rules) = AllowPolicy;
  const factory deny(List<Rule> rules) = DenyPolicy;
}

@boilerplate
final class const AllowPolicy(super.rules) extends Policy {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const DenyPolicy(super.rules) extends Policy {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
