// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../scope.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $AuthorityScopeExtension on AuthorityScope {
  String _toString() => 'AuthorityScope()';
}

extension $PreviousScopeExtension on PreviousScope {
  String _toString() => 'PreviousScope()';
}

extension $PublicKeyScopeExtension on PublicKeyScope {
  bool _equals(Object other) =>
      identical(this, other) || other is PublicKeyScope && keyId == other.keyId;

  int get _hashCode => Object.hash('PublicKeyScope', keyId);

  String _toString() => 'PublicKeyScope(keyId: $keyId)';
}
