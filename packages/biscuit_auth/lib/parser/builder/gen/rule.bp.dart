// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../rule.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $RuleExtension on Rule {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is Rule &&
          head == other.head &&
          const ListEquality<Predicate>().equals(
            body.value,
            other.body.value,
          ) &&
          const ListEquality<Expression>().equals(
            expressions.value,
            other.expressions.value,
          ) &&
          const MapEquality<String, Term?>().equals(
            parameters,
            other.parameters,
          ) &&
          const ListEquality<Scope>().equals(
            scopes.value,
            other.scopes.value,
          ) &&
          const MapEquality<String, PublicKey?>().equals(
            scopeParameters,
            other.scopeParameters,
          );

  int get _hashCode => Object.hash(
    'Rule',
    head,
    const ListEquality<Predicate>().hash(body.value),
    const ListEquality<Expression>().hash(expressions.value),
    const MapEquality<String, Term?>().hash(parameters),
    const ListEquality<Scope>().hash(scopes.value),
    const MapEquality<String, PublicKey?>().hash(scopeParameters),
  );

  String _toString() =>
      'Rule(head: $head, body: $body, expressions: $expressions, parameters: $parameters, scopes: $scopes, scopeParameters: $scopeParameters)';
}
