// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:typed_data';

import 'package:biscuit_auth/parser/builder/compare_to.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:collection/collection.dart';

part 'gen/term.bp.dart';

sealed class const Term() implements Comparable<Term> {
  const factory variable(String variable) = VariableTerm;
  const factory integer(int integer) = IntegerTerm;
  const factory str(String string) = StrTerm;
  factory date(DateTime date) = DateTerm;
  const factory bytes(Uint8List bytes) = BytesTerm;
  const factory bool(bool boolean) = BoolTerm;
  const factory set(SplayTreeSet<Term> set) = SetTerm;
  const factory parameter(String parameter) = ParameterTerm;
  const factory nil() = NilTerm;
  const factory array(List<Term> array) = ArrayTerm;
  const factory map(SplayTreeMap<MapKey, Term> map) = MapTerm;

  void extractParameters(HashMap<String, Term?> parameters) {
    switch (this) {
      case ParameterTerm(:final parameter):
        parameters[parameter] = null;
      case SetTerm(:final set):
        for (final item in set) {
          item.extractParameters(parameters);
        }
      case ArrayTerm(:final array):
        for (final item in array) {
          item.extractParameters(parameters);
        }
      case MapTerm(:final map):
        for (final MapEntry(:key, value: term) in map.entries) {
          if (key case ParameterTerm(:final parameter)) {
            parameters[parameter] = null;
          }
          term.extractParameters(parameters);
        }
      default:
        {}
    }
  }
}

sealed class const MapKey() extends Term {
  const factory parameter(String parameter) = ParameterTerm;
  const factory integer(int value) = IntegerTerm;
  const factory str(String string) = StrTerm;
}

@boilerplate
final class const VariableTerm(final String variable) extends Term {
  @override
  int compareTo(covariant VariableTerm other) =>
      variable.compareTo(other.variable);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const IntegerTerm(final int value) extends MapKey {
  @override
  int compareTo(covariant IntegerTerm other) => value.compareTo(other.value);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const StrTerm(final String string) extends MapKey {
  @override
  int compareTo(covariant StrTerm other) => string.compareTo(other.string);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class DateTerm extends Term {
  final int date;

  new(DateTime date) : date = date.millisecondsSinceEpoch ~/ 1_000;

  @override
  int compareTo(covariant DateTerm other) => date.compareTo(other.date);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const BytesTerm(final Uint8List bytes) extends Term {
  @override
  int compareTo(covariant BytesTerm other) => bytes.compareTo(other.bytes);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const BoolTerm(final bool boolean) extends Term {
  @override
  int compareTo(covariant BoolTerm other) => boolean.compareTo(other.boolean);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const SetTerm(final SplayTreeSet<Term> set) extends Term {
  @override
  int compareTo(covariant SetTerm other) => set.compareTo(other.set);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const ParameterTerm(final String parameter) extends MapKey {
  @override
  int compareTo(covariant ParameterTerm other) =>
      parameter.compareTo(other.parameter);

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
  int compareTo(covariant NilTerm other) => 0;

  @override
  String toString() => _toString();
}

@boilerplate
final class const ArrayTerm(final List<Term> array) extends Term {
  @override
  int compareTo(covariant ArrayTerm other) => array.compareTo(other.array);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

@boilerplate
final class const MapTerm(final SplayTreeMap<MapKey, Term> map) extends Term {
  @override
  int compareTo(covariant MapTerm other) => map.compareTo(other.map);

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
