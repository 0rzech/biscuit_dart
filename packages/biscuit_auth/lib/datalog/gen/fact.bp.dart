// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../fact.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $FactExtension on Fact {
  bool _equals(Object other) =>
      identical(this, other) || other is Fact && predicate == other.predicate;

  int get _hashCode => Object.hash('Fact', predicate);

  String _toString() => 'Fact(predicate: $predicate)';
}

extension $PredicateExtension on Predicate {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is Predicate &&
          name == other.name &&
          const ListEquality<Term>().equals(terms, other.terms);

  int get _hashCode =>
      Object.hash('Predicate', name, const ListEquality<Term>().hash(terms));

  String _toString() => 'Predicate(name: $name, terms: $terms)';
}
