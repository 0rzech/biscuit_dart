// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:typed_data';

import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/scope.bp.dart';

@immutable
sealed class const Scope() {
  const factory authority() = AuthorityScope;
  const factory previous() = PreviousScope;
  const factory publicKey(PublicKey publicKey) = PublicKeyScope;
  const factory parameter(String name) = ParameterScope;
}

@boilerplate
final class const AuthorityScope() extends Scope {
  @override
  String toString() => _toString();
}

@boilerplate
final class const PreviousScope() extends Scope {
  @override
  String toString() => _toString();
}

@boilerplate
final class const PublicKeyScope(final PublicKey publicKey) extends Scope {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const ParameterScope(final String name) extends Scope {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

sealed class const PublicKey(final Uint8List key) {
  const factory ed25519(Uint8List key) = Ed25519PublicKey;
  const factory secp256r1(Uint8List key) = Secp256r1PublicKey;
}

@boilerplate
final class const Ed25519PublicKey(super.key) extends PublicKey {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const Secp256r1PublicKey(super.key) extends PublicKey {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
