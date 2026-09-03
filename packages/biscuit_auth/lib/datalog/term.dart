// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:typed_data';

import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/parser/builder/bytes.dart';
import 'package:biscuit_auth/parser/builder/compare_to.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/term.bp.dart';

@immutable
sealed class const Term() implements Comparable<Term> {
  const factory variable(SymbolId id) = VariableTerm;
  const factory int(int value) = IntTerm;
  const factory str(SymbolId value) = StrTerm;
  factory date(DateTime value) = DateTerm;
  const factory bytes(Uint8List value) = BytesTerm;
  const factory bool(bool value) = BoolTerm;
  const factory set(SplayTreeSet<Term> value) = SetTerm;
  const factory nil() = NilTerm;
  const factory array(List<Term> value) = ArrayTerm;
  const factory map(SplayTreeMap<MapKey, Term> value) = MapTerm;

  String stringify(SymbolTable symbols);

  @override
  int compareTo(Term other) {
    if (runtimeType == other.runtimeType) {
      return switch (this) {
        VariableTerm(:final id) => id.value.compareTo(
          (other as VariableTerm).id.value,
        ),
        IntTerm(:final value) => value.compareTo((other as IntTerm).value),
        StrTerm(:final id) => id.value.compareTo((other as StrTerm).id.value),
        DateTerm(:final value) => value.compareTo((other as DateTerm).value),
        BytesTerm(:final value) => value.compareTo((other as BytesTerm).value),
        BoolTerm(:final value) => value.compareTo((other as BoolTerm).value),
        SetTerm(:final value) => value.compareTo((other as SetTerm).value),
        NilTerm _ => 0,
        ArrayTerm(:final value) => value.compareTo((other as ArrayTerm).value),
        MapTerm(:final value) => value.compareTo((other as MapTerm).value),
      };
    }

    return _typeOrder(this).compareTo(_typeOrder(other));
  }

  int _typeOrder(Term term) => switch (term) {
    VariableTerm _ => 0,
    IntTerm _ => 1,
    StrTerm _ => 2,
    DateTerm _ => 3,
    BytesTerm _ => 4,
    BoolTerm _ => 5,
    SetTerm _ => 6,
    NilTerm _ => 7,
    ArrayTerm _ => 8,
    MapTerm _ => 9,
  };
}

@boilerplate
final class const VariableTerm(final SymbolId id) extends Term {
  @override
  String stringify(SymbolTable symbols) => '\$${symbols.getOrDefault(id)}';

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

sealed class const MapKey() extends Term {
  const factory int(int value) = IntTerm;
  const factory str(SymbolId id) = StrTerm;
}

@boilerplate
final class const IntTerm(final int value) extends MapKey {
  this
    : assert(
        value >= minValue && value <= maxValue,
        'Value must be >= $minValue and <= $maxValue, but was: $value',
      );

  static const minValue = bool.fromEnvironment('dart.library.js_interop')
      ? -maxValue // Web
      : -maxValue - 1; // Native

  static const maxValue = bool.fromEnvironment('dart.library.js_interop')
      ? 0x1fffffffffffff // Web
      : 0x7fffffffffffffff; // Native

  @override
  String stringify(SymbolTable _) => value.toString();

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const StrTerm(final SymbolId id) extends MapKey {
  @override
  String stringify(SymbolTable symbols) => symbols.getOrDefault(id);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class DateTerm extends Term {
  final int value;

  new(DateTime date) : value = date.toUtc().millisecondsSinceEpoch ~/ 1000;

  @override
  String stringify(SymbolTable _) =>
      DateTime.fromMillisecondsSinceEpoch(value * 1000).toIso8601String();

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const BytesTerm(final Uint8List value) extends Term {
  @override
  String stringify(SymbolTable _) => uint8ListToBytesStr(value, prefix: 'hex:');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const BoolTerm(final bool value) extends Term {
  BoolTerm get negate => .new(!value);

  @override
  String stringify(SymbolTable _) => value.toString();

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const SetTerm(final SplayTreeSet<Term> value) extends Term {
  @override
  String stringify(SymbolTable symbols) => value.isEmpty
      ? '{,}'
      : '{${value.map((term) => term.stringify(symbols)).join(', ')}}';

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const NilTerm() extends Term {
  @override
  String stringify(SymbolTable _) => 'null';

  @override
  String toString() => _toString();
}

@boilerplate
final class const ArrayTerm(final List<Term> value) extends Term {
  @override
  String stringify(SymbolTable symbols) =>
      '{${value.map((term) => term.stringify(symbols)).join(', ')}}';

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const MapTerm(final SplayTreeMap<MapKey, Term> value) extends Term {
  @override
  String stringify(SymbolTable symbols) =>
      '{${value.entries.map((entry) => switch (entry.key) {
        IntTerm(:final value) => '$value: ${entry.value.stringify(symbols)}',
        StrTerm(:final id) => '"${symbols.getOrDefault(id)}": '
            '${entry.value.stringify(symbols)}',
      }).join(', ')}}';

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
