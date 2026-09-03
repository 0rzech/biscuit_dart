// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../crypto.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $Ed25519PublicKeyExtension on Ed25519PublicKey {
  bool _equals(Object other) =>
      identical(this, other) || other is Ed25519PublicKey && _key == other._key;

  int get _hashCode => Object.hash('Ed25519PublicKey', _key);

  String _toString() => 'Ed25519PublicKey(_key: $_key)';
}

extension $P256Extension on P256 {
  bool _equals(Object other) =>
      identical(this, other) || other is P256 && _key == other._key;

  int get _hashCode => Object.hash('P256', _key);

  String _toString() => 'P256(_key: $_key)';
}

extension $UnsupportedKeyTypeErrorExtension on UnsupportedKeyTypeError {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is UnsupportedKeyTypeError &&
          message == other.message &&
          source == other.source &&
          offset == other.offset;

  int get _hashCode =>
      Object.hash('UnsupportedKeyTypeError', message, source, offset);
}
