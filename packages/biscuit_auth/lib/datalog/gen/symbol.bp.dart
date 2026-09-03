// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../symbol.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $SymbolTableExtension on SymbolTable {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is SymbolTable &&
          const ListEquality<String>().equals(_symbols, other._symbols) &&
          _keys == other._keys;

  int get _hashCode => Object.hash(
    'SymbolTable',
    const ListEquality<String>().hash(_symbols),
    _keys,
  );

  String _toString() => 'SymbolTable(_symbols: $_symbols, _keys: $_keys)';
}

extension $TemporarySymbolTableExtension on TemporarySymbolTable {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is TemporarySymbolTable &&
          _base == other._base &&
          _offset == other._offset &&
          const ListEquality<String>().equals(_symbols, other._symbols);

  int get _hashCode => Object.hash(
    'TemporarySymbolTable',
    _base,
    _offset,
    const ListEquality<String>().hash(_symbols),
  );

  String _toString() =>
      'TemporarySymbolTable(_base: $_base, _offset: $_offset, _symbols: $_symbols)';
}
