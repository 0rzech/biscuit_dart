// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/datalog/check.dart';
import 'package:biscuit_auth/datalog/expression/expression.dart';
import 'package:biscuit_auth/datalog/expression/op.dart';
import 'package:biscuit_auth/datalog/fact.dart';
import 'package:biscuit_auth/datalog/rule.dart';
import 'package:biscuit_auth/datalog/scope.dart';
import 'package:biscuit_auth/error.dart';
import 'package:meta/meta.dart';

/// minimum supported version of the serialization format
const minSchemaVersion = 3;

/// maximum supported version of the serialization format
const maxSchemaVersion = 6;

/// starting version for datalog 3.1 features (check all, bitwise operators, !=, …)
const datalog31 = 4;

/// starting version for 3rd party blocks (datalog 3.2)
const datalog32 = 5;

/// starting version for datalog 3.3 features (reject if, closures, array/map, null, external functions, …)
const datalog33 = 6;

@immutable
final class const SchemaVersion({
  required final bool containsScopes,
  required final bool containsV31,
  required final bool containsCheckAll,
  required final bool containsV33,
}) {
  factory of({
    List<Fact> facts = const [],
    List<Rule> rules = const [],
    List<Check> checks = const [],
    List<Scope> scopes = const [],
  }) {
    var containsScopes =
        scopes.isNotEmpty || rules.any((r) => r.scopes.isNotEmpty);
    var containsCheckAll = false;
    var containsV33 = false;

    for (final check in checks) {
      if (check.queries.isNotEmpty) containsScopes = true;
      if (check is AllCheck) containsCheckAll = true;
      if (check is RejectCheck) containsV33 = true;
      if (containsScopes && containsCheckAll && containsV33) break;
    }

    final containsV31 =
        rules.any((r) => containsV31Op(r.expressions)) ||
        checks.any((c) => c.queries.any((q) => containsV31Op(q.expressions)));

    if (!containsV33) {
      containsV33 =
          rules.any((r) {
            return isV33Predicate(r.head) ||
                r.body.any(isV33Predicate) ||
                containsV33Op(r.expressions);
          }) ||
          checks.any((c) {
            return c.queries.any((q) {
              return q.body.any(isV33Predicate) || containsV31Op(q.expressions);
            });
          }) ||
          facts.any((f) => isV33Predicate(f.predicate));
    }

    return .new(
      containsScopes: containsScopes,
      containsV31: containsV31,
      containsCheckAll: containsCheckAll,
      containsV33: containsV33,
    );
  }

  int get version {
    if (containsV33) return datalog33;
    if (containsScopes || containsV31 || containsCheckAll) return datalog31;
    return minSchemaVersion;
  }

  void checkCompatibility() {
    if (version < datalog31) {
      if (containsScopes) {
        throw const FormatError.deserialization(
          'Scopes are only supported in datalog v3.1+',
        );
      }

      if (containsV31) {
        throw const FormatError.deserialization(
          'Bitwise operators and != are only supported in datalog v3.1+',
        );
      }

      if (containsCheckAll) {
        throw const FormatError.deserialization(
          'Check all is only supported in datalog v3.1+',
        );
      }

      return;
    }

    if (version < datalog33 && containsV33) {
      throw const FormatError.deserialization(
        'Maps, arrays, null, closures are only supported in datalog v3.3+',
      );
    }
  }
}

bool containsV31Op(Iterable<Expression> expressions) => expressions.any(
  (expression) => expression.ops.any(
    (op) => switch (op) {
      BitwiseAnd _ || BitwiseOr _ || BitwiseXor _ || NotEqual _ => true,
      _ => false,
    },
  ),
);

bool containsV33Op(Iterable<Expression> expressions) => expressions.any(
  (expression) => expression.ops.any(
    (op) => switch (op) {
      final Term term => isV33Term(term),
      Closure _ ||
      Type _ ||
      UnFfi _ ||
      HeterogeneousEqual _ ||
      HeterogeneousNotEqual _ ||
      LazyAnd _ ||
      LazyOr _ ||
      All _ ||
      Any _ ||
      BinFfi _ => true,
      _ => false,
    },
  ),
);

bool isV33Predicate(Predicate predicate) => predicate.terms.any(isV33Term);

bool isV33Term(Term term) => switch (term) {
  Nil _ => true,
  final Set s => s.value.contains(const Term.nil()),
  _ => false,
};
