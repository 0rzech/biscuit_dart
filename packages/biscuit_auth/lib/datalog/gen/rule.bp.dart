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
          const ListEquality<Scope>().equals(scopes, other.scopes);

  int get _hashCode => Object.hash(
    'Rule',
    head,
    const ListEquality<Predicate>().hash(body),
    const ListEquality<Expression>().hash(expressions),
    const ListEquality<Scope>().hash(scopes),
  );

  String _toString() =>
      'Rule(head: $head, body: $body, expressions: $expressions, scopes: $scopes)';
}
