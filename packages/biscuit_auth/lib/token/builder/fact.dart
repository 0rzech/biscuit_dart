// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/error.dart';
import 'package:biscuit_auth/parser/builder/fact.dart';
import 'package:biscuit_auth/token/builder/term.dart';

export 'package:biscuit_auth/parser/builder/fact.dart';

extension FactToken on Fact {
  LanguageError? validate() {
    final invalidParameters =
        parameters?.entries
            .where((element) => element.value == null)
            .map((element) => element.key)
            .toList(growable: false) ??
        const [];

    return invalidParameters.isEmpty
        ? null
        : .parameters(missing: invalidParameters, unused: const []);
  }

  LanguageError? set(String name, Term term) {
    switch (parameters?[name]) {
      case null:
        return .parameters(missing: const [], unused: [name]);
      case final _:
        parameters?[name] = term;
        return null;
    }
  }

  LanguageError? setLenient(String name, Term term) {
    if (parameters == null) {
      return .parameters(missing: const [], unused: [name]);
    }

    switch (parameters?[name]) {
      case null:
        return null;
      case final _:
        parameters?[name] = term;
        return null;
    }
  }

  void applyParameters() {
    if (parameters case final params?) {
      predicate.terms = predicate.terms
          .map((t) => t.applyParameters(params))
          .toList();
    }
  }
}
