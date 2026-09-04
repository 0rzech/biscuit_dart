// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/datalog/expression/op.dart';
import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/src//boilerplate_gen_annotations.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/fact.bp.dart';

@immutable
@boilerplate
final class const Fact(final Predicate predicate) {
  factory fromTerms(SymbolId name, List<Term> terms) => .new(.new(name, terms));

  String stringify(SymbolTable symbols) => predicate.stringify(symbols);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@immutable
@boilerplate
final class Predicate {
  final SymbolId name;
  final List<Term> terms;

  new(this.name, [List<Term>? terms]) : terms = terms ?? [];

  Predicate copyWith({SymbolId? name, List<Term>? terms}) =>
      .new(name ?? this.name, terms ?? this.terms);

  String stringify(SymbolTable symbols) =>
      '${symbols.getOrNull(name) ?? '<?>'}'
      '(${terms.map((term) => term.stringify(symbols))})';

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

bool areMatching({required Predicate rule, required Predicate fact}) =>
    rule.name == fact.name &&
    rule.terms.length == fact.terms.length &&
    IterableZip([rule.terms, fact.terms]).every(
      (pair) => switch (pair) {
        // the fact should not contain variables
        [final _, final Variable _] => false,
        [final Variable _, final _] => true,
        [final Int l, final Int r] => l == r,
        [final Str l, final Str r] => l == r,
        [final Date l, final Date r] => l == r,
        [final Bytes l, final Bytes r] => l == r,
        [final Bool l, final Bool r] => l == r,
        [final Nil _, final Nil _] => true,
        [final Set l, final Set r] => l == r,
        [final Array l, final Array r] => l == r,
        [final Map l, final Map r] => l == r,
        _ => false,
      },
    );
