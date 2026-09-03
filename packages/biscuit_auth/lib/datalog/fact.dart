// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/datalog/term.dart';
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
final class const Predicate(
  final SymbolId name, [
  final List<Term> terms = const [],
]) {
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
        [final _, final VariableTerm _] => false,
        [final VariableTerm _, final _] => true,
        [final IntTerm l, final IntTerm r] => l == r,
        [final StrTerm l, final StrTerm r] => l == r,
        [final DateTerm l, final DateTerm r] => l == r,
        [final BytesTerm l, final BytesTerm r] => l == r,
        [final BoolTerm l, final BoolTerm r] => l == r,
        [final NilTerm _, final NilTerm _] => true,
        [final SetTerm l, final SetTerm r] => l == r,
        [final ArrayTerm l, final ArrayTerm r] => l == r,
        [final MapTerm l, final MapTerm r] => l == r,
        _ => false,
      },
    );
