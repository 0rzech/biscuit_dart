// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of '../policy.dart';

// **************************************************************************
// BoilerplateGenerator
// **************************************************************************

extension $AllowPolicyExtension on AllowPolicy {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is AllowPolicy &&
          const ListEquality<Rule>().equals(rules, other.rules);

  int get _hashCode =>
      Object.hash('AllowPolicy', const ListEquality<Rule>().hash(rules));

  String _toString() => 'AllowPolicy(rules: $rules)';
}

extension $DenyPolicyExtension on DenyPolicy {
  bool _equals(Object other) =>
      identical(this, other) ||
      other is DenyPolicy &&
          const ListEquality<Rule>().equals(rules, other.rules);

  int get _hashCode =>
      Object.hash('DenyPolicy', const ListEquality<Rule>().hash(rules));

  String _toString() => 'DenyPolicy(rules: $rules)';
}
