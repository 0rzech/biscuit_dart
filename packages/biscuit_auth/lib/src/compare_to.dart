// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';

import 'package:meta/meta.dart';

@internal
extension BoolCompareTo on bool {
  int compareTo(bool other) {
    final self = this ? 1 : 0, another = other ? 1 : 0;
    return self.compareTo(another);
  }
}

@internal
extension ListCompareTo<T extends Comparable<T>> on List<T> {
  int compareTo(List<T> other) {
    final minLength = min(length, other.length);

    for (var i = 0; i < minLength; ++i) {
      final diff = this[i].compareTo(other[i]);
      if (diff != 0) {
        return diff;
      }
    }

    return length.compareTo(other.length);
  }
}

@internal
extension Uint8ListCompareTo on Uint8List {
  int compareTo(Uint8List other) {
    final minLength = min(length, other.length);

    for (var i = 0; i < minLength; ++i) {
      final diff = this[i].compareTo(other[i]);
      if (diff != 0) {
        return diff;
      }
    }

    return length.compareTo(other.length);
  }
}

@internal
extension SplayTreeSetCompareTo<T extends Comparable<T>> on SplayTreeSet<T> {
  int compareTo(SplayTreeSet<T> other) {
    final left = iterator;
    final right = other.iterator;

    while (true) {
      final hasLeft = left.moveNext();
      final hasRight = right.moveNext();

      if (!(hasLeft && hasRight)) return 0;
      if (!hasLeft) return -1;
      if (!hasRight) return 1;

      final diff = left.current.compareTo(right.current);
      if (diff != 0) {
        return diff;
      }
    }
  }
}

@internal
extension SplayTreeMapCompareTo<
  K extends Comparable<K>,
  V extends Comparable<V>
>
    on SplayTreeMap<K, V> {
  int compareTo(SplayTreeMap<K, V> other) {
    final left = entries.iterator;
    final right = other.entries.iterator;

    while (true) {
      final hasLeft = left.moveNext();
      final hasRight = right.moveNext();

      if (!(hasLeft && hasRight)) return 0;
      if (!hasLeft) return -1;
      if (!hasRight) return 1;

      final diff = left.current.compareTo(right.current);
      if (diff != 0) {
        return diff;
      }
    }
  }
}

@internal
extension MapEntryCompareTo<K extends Comparable<K>, V extends Comparable<V>>
    on MapEntry<K, V> {
  int compareTo(MapEntry<K, V> other) {
    final diff = key.compareTo(other.key);
    if (diff != 0) return diff;

    return value.compareTo(other.value);
  }
}
