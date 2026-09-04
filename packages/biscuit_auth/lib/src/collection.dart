// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:meta/meta.dart';

@internal
bool disjoint<T>(Iterable<T> i1, Iterable<T> i2) =>
    HashSet.from(i1).intersection(HashSet.from(i2)).isEmpty;

@internal
extension type const UnmodifiableList<T>(final List<T> value)
    implements Iterable<T>;
