// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/parser/builder/expression/expression.dart';
import 'package:biscuit_auth/parser/builder/expression/op.dart';
import 'package:biscuit_auth/parser/builder/fact.dart';
import 'package:biscuit_auth/parser/builder/scope.dart';
import 'package:biscuit_auth/parser/builder/term.dart';
import 'package:collection/collection.dart';

final class const Rule._({
  required final Predicate head,
  required final List<Predicate> body,
  required final List<Expression> expressions,
  required final HashMap<String, Term?>? parameters,
  required final List<Scope> scopes,
  required final HashMap<String, PublicKey?>? scopeParameters,
}) {
  factory({
    required Predicate head,
    required List<Predicate> predicates,
    required List<Expression> expressions,
    required List<Scope> scopes,
  }) {
    final parameters = HashMap<String, Term?>();
    final scopeParameters = HashMap<String, PublicKey?>();

    for (final term in head.terms) {
      term.extractParameters(parameters);
    }

    for (final predicate in predicates) {
      for (final term in predicate.terms) {
        term.extractParameters(parameters);
      }
    }

    for (final expression in expressions) {
      for (final op in expression.ops) {
        op.collectParameters(parameters);
      }
    }

    for (final scope in scopes) {
      if (scope case ParameterScope(:final name)) {
        scopeParameters[name] = null;
      }
    }

    return ._(
      head: head,
      body: predicates,
      expressions: expressions,
      parameters: parameters,
      scopes: scopes,
      scopeParameters: scopeParameters,
    );
  }

  factory basic({
    required String headName,
    required List<Term> headTerms,
    required List<Predicate> predicates,
  }) => .new(
    head: Predicate(headName, headTerms),
    predicates: predicates,
    expressions: const [],
    scopes: const [],
  );

  factory constrained({
    required String headName,
    required List<Term> headTerms,
    required List<Predicate> predicates,
    required List<Expression> expressions,
  }) => .new(
    head: Predicate(headName, headTerms),
    predicates: predicates,
    expressions: expressions,
    scopes: const [],
  );

  String? validateVariables() {
    final freeVariables = HashSet<String>();

    for (final term in head.terms) {
      if (term case VariableTerm(:final variable)) {
        freeVariables.add(variable);
      }
    }

    for (final expression in expressions) {
      for (final op in expression.ops) {
        if (op case ValueOp(term: VariableTerm(:final variable))) {
          freeVariables.add(variable);
        }
      }
    }

    for (final predicate in body) {
      for (final term in predicate.terms) {
        if (term case VariableTerm(:final variable)) {
          freeVariables.remove(variable);
          if (freeVariables.isEmpty) {
            return null;
          }
        }
      }
    }

    if (freeVariables.isEmpty) {
      return null;
    }

    return 'the rule contains variables that are not bound by predicates in '
        "the rule's body: ${freeVariables.join(', ')}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Rule &&
          head == other.head &&
          const ListEquality().equals(body, other.body) &&
          const ListEquality().equals(expressions, other.expressions) &&
          const MapEquality().equals(parameters, other.parameters) &&
          const ListEquality().equals(scopes, other.scopes) &&
          const MapEquality().equals(scopeParameters, other.scopeParameters);

  @override
  int get hashCode => Object.hash(
    'Rule',
    head,
    const ListEquality().hash(body),
    const ListEquality().hash(expressions),
    const MapEquality().hash(parameters),
    const ListEquality().hash(scopes),
    const MapEquality().hash(scopeParameters),
  );

  @override
  String toString() =>
      'Rule(head: $head, body: $body, expressions: $expressions, '
      'parameters: $parameters, scopes: $scopes, '
      'scopeParameters: $scopeParameters)';
}
