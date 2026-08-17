// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/parser/builder/rule.dart';
import 'package:collection/collection.dart';

sealed class const Check(final List<Rule> rules) {
  const factory one(List<Rule> rules) = OneCheck;
  const factory all(List<Rule> rules) = AllCheck;
  const factory reject(List<Rule> rules) = RejectCheck;
}

final class const OneCheck(super.rules) extends Check {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OneCheck && const ListEquality().equals(rules, other.rules);

  @override
  int get hashCode => Object.hash('OneCheck', const ListEquality().hash(rules));

  @override
  String toString() => 'OneCheck($rules}';
}

final class const AllCheck(super.rules) extends Check {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllCheck && const ListEquality().equals(rules, other.rules);

  @override
  int get hashCode => Object.hash('AllCheck', const ListEquality().hash(rules));

  @override
  String toString() => 'AllCheck($rules}';
}

final class const RejectCheck(super.rules) extends Check {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RejectCheck && const ListEquality().equals(rules, other.rules);

  @override
  int get hashCode =>
      Object.hash('RejectCheck', const ListEquality().hash(rules));

  @override
  String toString() => 'RejectCheck($rules}';
}
