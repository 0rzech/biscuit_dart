// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/parser/builder/term.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/fact.bp.dart';

@immutable
@boilerplate
final class const Fact._(
  final Predicate predicate,
  final HashMap<String, Term?>? parameters,
) {
  factory(String name, Iterable<Term> terms) {
    final parameters = HashMap<String, Term?>();
    final predicate = Predicate(name, [
      for (final term in terms) term..extractParameters(parameters),
    ]);

    return ._(predicate, parameters);
  }

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class Predicate(final String name, [var List<Term> terms = const []]) {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
