// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:typed_data';

import 'package:biscuit_auth/parser/builder/compare_to.dart';
import 'package:collection/collection.dart';

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

abstract class const MapKey() extends Term {
  const factory parameter(String parameter) = ParameterTerm;
  const factory integer(int integer) = IntegerTerm;
  const factory str(String string) = StrTerm;
}

final class const VariableTerm(final String variable) extends Term {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VariableTerm && variable == other.variable;

  @override
  int get hashCode => Object.hash('VariableTerm', variable);

  @override
  int compareTo(covariant VariableTerm other) =>
      variable.compareTo(other.variable);

  @override
  String toString() => 'VariableTerm($variable)';
}

final class const IntegerTerm(final int integer) extends MapKey {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntegerTerm && integer == other.integer;

  @override
  int get hashCode => Object.hash('IntegerTerm', integer);

  @override
  int compareTo(covariant IntegerTerm other) =>
      integer.compareTo(other.integer);

  @override
  String toString() => 'IntegerTerm($integer)';
}

final class const StrTerm(final String string) extends MapKey {
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is StrTerm && string == other.string;

  @override
  int get hashCode => Object.hash('StrTerm', string);

  @override
  int compareTo(covariant StrTerm other) => string.compareTo(other.string);

  @override
  String toString() => 'StrTerm($string)';
}

final class DateTerm extends Term {
  final int date;

  new(DateTime date) : date = date.millisecondsSinceEpoch ~/ 1_000;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DateTerm && date == other.date;

  @override
  int get hashCode => Object.hash('DateTerm', date);

  @override
  int compareTo(covariant DateTerm other) => date.compareTo(other.date);

  @override
  String toString() => 'DateTerm($date)';
}

final class const BytesTerm(final Uint8List bytes) extends Term {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BytesTerm && const ListEquality().equals(bytes, other.bytes);

  @override
  int get hashCode =>
      Object.hash('BytesTerm', const ListEquality().hash(bytes));

  @override
  int compareTo(covariant BytesTerm other) => bytes.compareTo(other.bytes);

  @override
  String toString() => 'BytesTerm($bytes)';
}

final class const BoolTerm(final bool boolean) extends Term {
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BoolTerm && boolean == other.boolean;

  @override
  int get hashCode => Object.hash('BoolTerm', boolean);

  @override
  int compareTo(covariant BoolTerm other) => boolean.compareTo(other.boolean);

  @override
  String toString() => 'BoolTerm($boolean)';
}

final class const SetTerm(final SplayTreeSet<Term> set) extends Term {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetTerm && const SetEquality().equals(set, other.set);

  @override
  int get hashCode => Object.hash('SetTerm', const SetEquality().hash(set));

  @override
  int compareTo(covariant SetTerm other) => set.compareTo(other.set);

  @override
  String toString() => 'SetTerm($set)';
}

final class const ParameterTerm(final String parameter) extends MapKey {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParameterTerm && parameter == other.parameter;

  @override
  int get hashCode => Object.hash('ParameterTerm', parameter);

  @override
  int compareTo(covariant ParameterTerm other) =>
      parameter.compareTo(other.parameter);

  @override
  String toString() => 'ParameterTerm($parameter)';
}

final class const NilTerm() extends Term {
  @override
  int compareTo(covariant NilTerm other) => 0;

  @override
  String toString() => 'NilTerm';
}

final class const ArrayTerm(final List<Term> array) extends Term {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArrayTerm && const ListEquality().equals(array, other.array);

  @override
  int get hashCode =>
      Object.hash('ArrayTerm', const ListEquality().hash(array));

  @override
  int compareTo(covariant ArrayTerm other) => array.compareTo(other.array);

  @override
  String toString() => 'ArrayTerm($array)';
}

final class const MapTerm(final SplayTreeMap<MapKey, Term> map) extends Term {
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapTerm && const MapEquality().equals(map, other.map);

  @override
  int get hashCode => Object.hash('MapTerm', const MapEquality().hash(map));

  @override
  int compareTo(covariant MapTerm other) => map.compareTo(other.map);

  @override
  String toString() => 'MapTerm($map)';
}
