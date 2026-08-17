// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:typed_data';

import 'package:collection/collection.dart';

sealed class const Scope() {
  const factory authority() = AuthorityScope;
  const factory previous() = PreviousScope;
  const factory publicKey(PublicKey publicKey) = PublicKeyScope;
  const factory parameter(String name) = ParameterScope;
}

final class const AuthorityScope() extends Scope {
  @override
  String toString() => 'AuthorityScope';
}

final class const PreviousScope() extends Scope {
  @override
  String toString() => 'PreviousScope';
}

final class const PublicKeyScope(final PublicKey publicKey) extends Scope {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublicKeyScope && publicKey == other.publicKey;

  @override
  int get hashCode => Object.hash('PublicKeyScope', publicKey);

  @override
  String toString() => 'PublicKeyScope($publicKey)';
}

final class const ParameterScope(final String name) extends Scope {
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ParameterScope && name == other.name;

  @override
  int get hashCode => Object.hash('ParameterScope', name);

  @override
  String toString() => 'ParameterScope($name)';
}

sealed class const PublicKey(final Uint8List key) {
  const factory ed25519(Uint8List key) = Ed25519PublicKey;
  const factory secp256r1(Uint8List key) = Secp256r1PublicKey;
}

final class const Ed25519PublicKey(super.key) extends PublicKey {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ed25519PublicKey && const ListEquality().equals(key, other.key);

  @override
  int get hashCode =>
      Object.hash('Ed25519PublicKey', key, const ListEquality().hash(key));

  @override
  String toString() => 'Ed25519PublicKey($key)';
}

final class const Secp256r1PublicKey(super.key) extends PublicKey {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Secp256r1PublicKey &&
          const ListEquality().equals(key, other.key);

  @override
  int get hashCode =>
      Object.hash('Secp256r1PublicKey', key, const ListEquality().hash(key));

  @override
  String toString() => 'Secp256r1PublicKey($key)';
}
