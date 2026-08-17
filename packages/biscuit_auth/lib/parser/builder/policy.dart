// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/parser/builder/rule.dart';
import 'package:collection/collection.dart';

sealed class const Policy(final List<Rule> rules) {
  const factory allow(List<Rule> rules) = AllowPolicy;
  const factory deny(List<Rule> rules) = DenyPolicy;
}

final class const AllowPolicy(super.rules) extends Policy {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllowPolicy && const ListEquality().equals(rules, other.rules);

  @override
  int get hashCode =>
      Object.hash('AllowPolicy', const ListEquality().hash(rules));

  @override
  String toString() => 'AllowPolicy($rules)';
}

final class const DenyPolicy(super.rules) extends Policy {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DenyPolicy && const ListEquality().equals(rules, other.rules);

  @override
  int get hashCode =>
      Object.hash('DenyPolicy', const ListEquality().hash(rules));

  @override
  String toString() => 'DenyPolicy($rules)';
}
