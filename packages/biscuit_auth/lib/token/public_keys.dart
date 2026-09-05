// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/crypto/crypto.dart';
import 'package:biscuit_auth/error.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:biscuit_auth/src/collection.dart';
import 'package:collection/collection.dart';

part 'gen/public_keys.bp.dart';

@boilerplate
final class const PublicKeys._(final List<PublicKey> _keys) {
  factory([List<PublicKey>? keys]) => ._(keys ?? []);

  PublicKey? getOrNull(int id) => _keys.elementAtOrNull(id);

  void extend(PublicKeys other) => disjoint(_keys, other._keys)
      ? _keys.addAll(other._keys)
      : throw const FormatError.publicKeyTableOverlap();

  /// Inserts the key and returns its index in the table.
  /// If the key is already in the table, returns its index.
  int insert(PublicKey key) => switch (_keys.indexOf(key)) {
    -1 => (_keys..add(key)).length - 1,
    final i => i,
  };

  /// Inserts the key and returns its index in the table.
  /// Throws [PublicKeyTableOverlapError] if the `key` is already in the table.
  int insertOrThrow(PublicKey key) => switch (_keys.indexOf(key)) {
    -1 => (_keys..add(key)).length - 1,
    _ => throw const FormatError.publicKeyTableOverlap(),
  };

  int get(PublicKey key) => _keys.indexOf(key);

  int currentOffset() => _keys.length;

  PublicKeys splitAt(int offset) => .new(_keys.sublist(offset));

  bool isDisjoint(PublicKeys other) => disjoint(_keys, other._keys);

  PublicKey? getKey(int index) => _keys.elementAtOrNull(index);

  List<PublicKey> toList() => _keys;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
