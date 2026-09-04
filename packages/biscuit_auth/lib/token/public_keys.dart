// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/crypto/crypto.dart';
import 'package:biscuit_auth/error.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:biscuit_auth/src/collection.dart';

part 'gen/public_keys.bp.dart';

@Boilerplate(equality: false)
final class const PublicKeys._(final List<PublicKey> _keys) {
  factory([List<PublicKey>? keys]) => ._(keys ?? []);

  PublicKey? getOrNull(int id) => _keys.elementAtOrNull(id);

  void extend(PublicKeys other) => disjoint(_keys, other._keys)
      ? _keys.addAll(other._keys)
      : throw const FormatError.publicKeyTableOverlap();

  @override
  String toString() => _toString();
}
