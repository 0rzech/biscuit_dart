// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../matched_variables.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $MatchedVariablesExtension on MatchedVariables {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is MatchedVariables &&
          const MapEquality<SymbolId, Term?>().equals(
            _variables,
            other._variables,
          );

  int get _hashCode => Object.hash(
    'MatchedVariables',
    const MapEquality<SymbolId, Term?>().hash(_variables),
  );

  String _toString() => 'MatchedVariables(_variables: $_variables)';
}
