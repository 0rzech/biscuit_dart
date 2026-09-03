// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/datalog/term.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/matched_variables.bp.dart';

@immutable
@boilerplate
final class const MatchedVariables._(
  final HashMap<SymbolId, Term?> _variables,
) {
  factory(HashSet<SymbolId> import) =>
      ._(.fromIterable(import, key: (key) => key, value: (_) => null));

  bool insert(SymbolId key, Term variable) {
    if (_variables.containsKey(key)) {
      if (_variables[key] case final existing?) return existing == variable;

      _variables[key] = variable;
      return true;
    }

    return false;
  }

  bool isComplete() => _variables.values.every((v) => v != null);

  HashMap<SymbolId, Term>? complete() {
    final result = HashMap<SymbolId, Term>();

    for (final MapEntry(:key, :value) in _variables.entries) {
      if (value == null) return null;

      result[key] = value;
    }

    return result;
  }

  MatchedVariables clone() => ._(.of(_variables));

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
