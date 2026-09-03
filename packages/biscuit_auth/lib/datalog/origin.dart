// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/datalog/scope.dart';
import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/origin.bp.dart';

@immutable
@Boilerplate(string: false)
final class const Origin._(final Set<SymbolId> _ids) {
  factory([SplayTreeSet<SymbolId>? ids]) => ._(ids ?? SplayTreeSet());

  factory of(Iterable<SymbolId> elements) => ._(SplayTreeSet.of(elements));

  void add(SymbolId id) => _ids.add(id);

  Origin union(Origin other) => ._(switch (_ids.length > other._ids.length) {
    true => _ids.union(other._ids),
    false => other._ids.union(_ids),
  });

  bool isSuperset(Origin other) => _ids.containsAll(other._ids);

  void addAll(Iterable<SymbolId> elements) => _ids.addAll(elements);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() {
    if (_ids.isEmpty) return '';

    final sb = StringBuffer();
    final iter = _ids.iterator;

    if (iter.moveNext()) {
      final current = iter.current;
      if (current == maxId) {
        sb.write('authorizer');
      } else {
        sb.write(current);
      }
    }

    while (iter.moveNext()) {
      final current = iter.current;
      if (current == maxId) {
        sb.write(', authorizer');
      } else {
        sb.write(', ');
        sb.write(current);
      }
    }

    return sb.toString();
  }
}

@immutable
@boilerplate
final class const TrustedOrigins._(final Origin origin) {
  factory() =>
      ._(.new(.of(const [SymbolId(SymbolId.max), SymbolId(SymbolId.min)])));

  factory of(Iterable<SymbolId> ids) => ._(.of(ids));

  factory from({
    required List<Scope> ruleScopes,
    required TrustedOrigins defaultOrigins,
    required SymbolId currentBlock,
    required HashMap<SymbolId, List<SymbolId>> pubKeyToBlockId,
  }) {
    if (ruleScopes.isEmpty) {
      final origin = Origin(.of(defaultOrigins.origin._ids));
      origin._ids.add(currentBlock);
      origin._ids.add(maxId);
      return ._(origin);
    }

    final origin = Origin();
    origin._ids.add(maxId);
    origin._ids.add(currentBlock);

    for (final scope in ruleScopes) {
      switch (scope) {
        case final AuthorityScope _:
          origin.add(minId);

        case final PreviousScope _:
          if (currentBlock != minId) {
            origin.addAll(List.generate(currentBlock.value + 1, SymbolId.new));
          }

        case PublicKeyScope(:final keyId):
          if (pubKeyToBlockId[keyId] case final ids?) {
            origin.addAll(ids);
          }
      }
    }

    return ._(origin);
  }

  bool contains(Origin factOrigin) => origin.isSuperset(factOrigin);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
