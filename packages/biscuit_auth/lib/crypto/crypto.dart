// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/parser/builder/bytes.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:cryptography/cryptography.dart' as crypto;
import 'package:meta/meta.dart';

part 'gen/crypto.bp.dart';

sealed class const PublicKey() {
  String stringify();

  @visibleForTesting
  @protected
  void ensureKeyType(crypto.KeyPairType actual, crypto.KeyPairType expected) {
    if (actual != expected) {
      throw PublicKeyError.unsupportedKeyType(actual.name);
    }
  }
}

@boilerplate
final class Ed25519PublicKey(final crypto.SimplePublicKey _key)
    extends PublicKey {
  this {
    ensureKeyType(_key.type, .ed25519);
  }

  @override
  String stringify() =>
      uint8ListToBytesStr(.fromList(_key.bytes), prefix: 'ed25519/');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class P256(final crypto.EcPublicKey _key) extends PublicKey {
  this {
    ensureKeyType(_key.type, .p256);
  }

  @override
  String stringify() => uint8ListToBytesStr(
    .new(_key.x.length + 1)
      ..add(_key.y.last.isEven ? 0x2 : 0x3)
      ..addAll(_key.x),
    prefix: 'secp256r1/',
  );

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

sealed class const PublicKeyError(super.message) extends FormatException {
  factory unsupportedKeyType(String typeName) = UnsupportedKeyTypeError;
}

@Boilerplate(string: false)
final class UnsupportedKeyTypeError extends PublicKeyError {
  const new(String typeName)
    : super('Key type should be ed25519 or p256, but was: $typeName');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
