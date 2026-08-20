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
          const ListEquality().equals(body, other.body) &&
          const ListEquality().equals(expressions, other.expressions) &&
          const MapEquality().equals(parameters, other.parameters) &&
          const ListEquality().equals(scopes, other.scopes) &&
          const MapEquality().equals(scopeParameters, other.scopeParameters);

  int get _hashCode => Object.hash(
    'Rule',
    head,
    const ListEquality().hash(body),
    const ListEquality().hash(expressions),
    const MapEquality().hash(parameters),
    const ListEquality().hash(scopes),
    const MapEquality().hash(scopeParameters),
  );

  String _toString() =>
      'Rule(head: $head, body: $body, expressions: $expressions, parameters: $parameters, scopes: $scopes, scopeParameters: $scopeParameters)';
}
