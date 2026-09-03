// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/src//boilerplate_gen_annotations.dart';
import 'package:biscuit_auth/token/public_keys.dart';
import 'package:meta/meta.dart';

part 'gen/scope.bp.dart';

@immutable
sealed class const Scope() {
  const factory authority() = AuthorityScope;
  const factory previous() = PreviousScope;
  const factory publicKey(int keyId) = PublicKeyScope;

  String stringify(PublicKeys keys);
}

@boilerplate
final class const AuthorityScope() extends Scope {
  @override
  String stringify(PublicKeys _) => 'authority';

  @override
  String toString() => _toString();
}

@boilerplate
final class const PreviousScope() extends Scope {
  @override
  String stringify(PublicKeys _) => 'previous';

  @override
  String toString() => _toString();
}

@boilerplate
final class const PublicKeyScope(final int keyId) extends Scope {
  @override
  String stringify(PublicKeys keys) => switch (keys.getOrNull(keyId)) {
    null => '<unknown public key id>',
    final key => key.stringify(),
  };

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
