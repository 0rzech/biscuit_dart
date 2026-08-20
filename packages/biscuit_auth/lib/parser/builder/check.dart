// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/parser/builder/rule.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:collection/collection.dart';

part 'gen/check.boilerplate.dart';

sealed class const Check(final List<Rule> rules) {
  const factory one(List<Rule> rules) = OneCheck;
  const factory all(List<Rule> rules) = AllCheck;
  const factory reject(List<Rule> rules) = RejectCheck;
}

@boilerplate
final class const OneCheck(super.rules) extends Check {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const AllCheck(super.rules) extends Check {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const RejectCheck(super.rules) extends Check {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
