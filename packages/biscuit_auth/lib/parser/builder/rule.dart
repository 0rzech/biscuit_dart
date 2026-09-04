// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/parser/builder/expression/expression.dart';
import 'package:biscuit_auth/parser/builder/expression/op.dart';
import 'package:biscuit_auth/parser/builder/fact.dart';
import 'package:biscuit_auth/parser/builder/scope.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:biscuit_auth/src/collection.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/rule.bp.dart';

@immutable
@boilerplate
final class const Rule._({
  required final Predicate head,
  required final ControlledList<Predicate> body,
  required final ControlledList<Expression> expressions,
  required final HashMap<String, Term?>? parameters,
  required final ControlledList<Scope> scopes,
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
      body: .new(predicates),
      expressions: .new(expressions),
      parameters: parameters,
      scopes: .new(scopes),
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
      if (term case Variable(:final value)) {
        freeVariables.add(value);
      }
    }

    for (final expression in expressions) {
      for (final op in expression.ops) {
        if (op case Variable(:final value)) {
          freeVariables.add(value);
        }
      }
    }

    for (final predicate in body) {
      for (final term in predicate.terms) {
        if (term case Variable(:final value)) {
          freeVariables.remove(value);
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
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
