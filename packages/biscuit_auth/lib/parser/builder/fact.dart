// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/parser/builder/term.dart';
import 'package:collection/collection.dart';

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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Fact &&
          predicate == other.predicate &&
          const MapEquality().equals(parameters, other.parameters);

  @override
  int get hashCode =>
      Object.hash('Fact', predicate, const MapEquality().hash(parameters));

  @override
  String toString() => 'Fact(predicate: $predicate, parameters: $parameters)';
}

final class Predicate(final String name, [var List<Term> terms = const []]) {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Predicate &&
          name == other.name &&
          const ListEquality().equals(terms, terms);

  @override
  int get hashCode =>
      Object.hash('Predicate', name, const ListEquality().hash(terms));

  @override
  String toString() => 'Predicate(name: $name, terms: $terms)';
}
