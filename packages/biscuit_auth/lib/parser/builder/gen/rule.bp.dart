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
          const ListEquality<Predicate>().equals(body, other.body) &&
          const ListEquality<Expression>().equals(
            expressions,
            other.expressions,
          ) &&
          const MapEquality<String, Term?>().equals(
            parameters,
            other.parameters,
          ) &&
          const ListEquality<Scope>().equals(scopes, other.scopes) &&
          const MapEquality<String, PublicKey?>().equals(
            scopeParameters,
            other.scopeParameters,
          );

  int get _hashCode => Object.hash(
    'Rule',
    head,
    const ListEquality<Predicate>().hash(body),
    const ListEquality<Expression>().hash(expressions),
    const MapEquality<String, Term?>().hash(parameters),
    const ListEquality<Scope>().hash(scopes),
    const MapEquality<String, PublicKey?>().hash(scopeParameters),
  );

  String _toString() =>
      'Rule(head: $head, body: $body, expressions: $expressions, parameters: $parameters, scopes: $scopes, scopeParameters: $scopeParameters)';
}
