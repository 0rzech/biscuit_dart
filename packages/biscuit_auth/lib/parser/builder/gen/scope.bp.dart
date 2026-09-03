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
      identical(this, other) ||
      other is PublicKeyScope && publicKey == other.publicKey;

  int get _hashCode => Object.hash('PublicKeyScope', publicKey);

  String _toString() => 'PublicKeyScope(publicKey: $publicKey)';
}

extension $ParameterScopeExtension on ParameterScope {
  bool _equals(Object other) =>
      identical(this, other) || other is ParameterScope && name == other.name;

  int get _hashCode => Object.hash('ParameterScope', name);

  String _toString() => 'ParameterScope(name: $name)';
}

extension $Ed25519PublicKeyExtension on Ed25519PublicKey {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is Ed25519PublicKey &&
          const ListEquality<int>().equals(key, other.key);

  int get _hashCode =>
      Object.hash('Ed25519PublicKey', const ListEquality<int>().hash(key));

  String _toString() => 'Ed25519PublicKey(key: $key)';
}

extension $Secp256r1PublicKeyExtension on Secp256r1PublicKey {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is Secp256r1PublicKey &&
          const ListEquality<int>().equals(key, other.key);

  int get _hashCode =>
      Object.hash('Secp256r1PublicKey', const ListEquality<int>().hash(key));

  String _toString() => 'Secp256r1PublicKey(key: $key)';
}
