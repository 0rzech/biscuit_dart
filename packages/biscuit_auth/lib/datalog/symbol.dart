// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/crypto/crypto.dart';
import 'package:biscuit_auth/datalog/expression.dart';
import 'package:biscuit_auth/error.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:biscuit_auth/src/collection.dart';
import 'package:biscuit_auth/token/public_keys.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/symbol.bp.dart';

const minId = SymbolId(SymbolId.min);
const maxId = SymbolId(SymbolId.max);

extension type const SymbolId(int value) {
  this
    : assert(
        value >= min && value <= max,
        'SymbolId must be >= $min && <= $max, but was: $value',
      );

  static const min = 0;
  static const max = bool.fromEnvironment('dart.library.js_interop')
      ? 0x1fffffffffffff // Web
      : 0x7fffffffffffffff; // Native
}

Term variable(SymbolTable symbols, String name) =>
    .variable(symbols.insert(name));

@immutable
@boilerplate
final class const SymbolTable._(
  final List<String> _symbols,
  final PublicKeys _keys,
) {
  factory() => ._([], .new());

  factory of(List<String> symbols, [List<PublicKey>? publicKeys]) =>
      disjoint(defaultSymbols, symbols)
      ? ._(symbols, .new(publicKeys ?? []))
      : throw const FormatError.symbolTableOverlap();

  Term add(String symbol) => .str(insert(symbol));

  SymbolId insert(String symbol) {
    var pos = defaultSymbols.indexOf(symbol);
    if (pos > -1) return .new(pos);

    pos = _symbols.indexOf(symbol);
    if (pos > -1) return .new(symbolOffset + pos);

    pos = _symbols.length;
    _symbols.add(symbol);

    return .new(symbolOffset + pos);
  }

  void extend(SymbolTable other) {
    if (isDisjoint(other)) {
      _symbols.addAll(other._symbols);
      _keys.extend(other._keys);
    } else {
      throw const FormatError.symbolTableOverlap();
    }
  }

  SymbolId? id(String symbol) {
    var pos = defaultSymbols.indexOf(symbol);
    if (pos > -1) return .new(pos);

    pos = _symbols.indexOf(symbol);
    return (pos > -1) ? .new(symbolOffset + pos) : null;
  }

  List<String> strings() => .of(_symbols);

  int get currentOffset => _symbols.length;

  SymbolTable splitAt(int offset) {
    assert(offset >= 0, 'offset must be >= 0');
    assert(offset <= _symbols.length, 'offset must be <= symbol count');
    return .of(_symbols.take(offset).toList());
  }

  bool isDisjoint(SymbolTable other) => disjoint(_symbols, other._symbols);

  String get(SymbolId id) {
    if (getOrNull(id) case final symbol?) {
      return symbol;
    }
    throw FormatError.unknownSymbol(id);
  }

  String? getOrNull(SymbolId id) => id.value >= symbolOffset
      ? _symbols.elementAtOrNull(id.value - symbolOffset)
      : defaultSymbols[id.value];

  String getOrDefault(SymbolId id) => switch (getOrNull(id)) {
    null => '<$id?>',
    final symbol => symbol,
  };

  PublicKeys get publicKeys => _keys;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}

const defaultSymbols = [
  'read',
  'write',
  'resource',
  'operation',
  'right',
  'time',
  'role',
  'owner',
  'tenant',
  'namespace',
  'user',
  'team',
  'service',
  'admin',
  'email',
  'group',
  'member',
  'ip_address',
  'client',
  'client_ip',
  'domain',
  'path',
  'version',
  'cluster',
  'node',
  'hostname',
  'nonce',
  'query',
];

const symbolOffset = 1024;

@immutable
@boilerplate
final class const TemporarySymbolTable._(
  final SymbolTable _base,
  final int _offset,
  final List<String> _symbols,
) {
  factory(SymbolTable base) => ._(base, symbolOffset + base.currentOffset, []);

  String? getOrNull(SymbolId id) => switch (id.value - _offset) {
    < 0 => _base.getOrNull(id),
    final i => _symbols.elementAtOrNull(i),
  };

  SymbolId insert(String symbol) {
    if (_base.id(symbol) case final id?) return id;

    switch (_symbols.indexWhere((s) => s == symbol)) {
      case -1:
        final id = _offset + _symbols.length;
        _symbols.add(symbol);
        return .new(id);
      case final id:
        return .new(id);
    }
  }

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
