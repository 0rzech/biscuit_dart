// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../origin.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $OriginExtension on Origin {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is Origin && const SetEquality<SymbolId>().equals(_ids, other._ids);

  int get _hashCode =>
      Object.hash('Origin', const SetEquality<SymbolId>().hash(_ids));
}

extension $TrustedOriginsExtension on TrustedOrigins {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is TrustedOrigins && origin == other.origin;

  int get _hashCode => Object.hash('TrustedOrigins', origin);

  String _toString() => 'TrustedOrigins(origin: $origin)';
}
