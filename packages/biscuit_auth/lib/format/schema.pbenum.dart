// This is a generated file - do not edit.
//
// Generated from schema.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class PublicKey_Algorithm extends $pb.ProtobufEnum {
  static const PublicKey_Algorithm Ed25519 =
      PublicKey_Algorithm._(0, _omitEnumNames ? '' : 'Ed25519');
  static const PublicKey_Algorithm SECP256R1 =
      PublicKey_Algorithm._(1, _omitEnumNames ? '' : 'SECP256R1');

  static const $core.List<PublicKey_Algorithm> values = <PublicKey_Algorithm>[
    Ed25519,
    SECP256R1,
  ];

  static final $core.List<PublicKey_Algorithm?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static PublicKey_Algorithm? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PublicKey_Algorithm._(super.value, super.name);
}

class Scope_ScopeType extends $pb.ProtobufEnum {
  static const Scope_ScopeType Authority =
      Scope_ScopeType._(0, _omitEnumNames ? '' : 'Authority');
  static const Scope_ScopeType Previous =
      Scope_ScopeType._(1, _omitEnumNames ? '' : 'Previous');

  static const $core.List<Scope_ScopeType> values = <Scope_ScopeType>[
    Authority,
    Previous,
  ];

  static final $core.List<Scope_ScopeType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static Scope_ScopeType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Scope_ScopeType._(super.value, super.name);
}

class Check_Kind extends $pb.ProtobufEnum {
  static const Check_Kind One = Check_Kind._(0, _omitEnumNames ? '' : 'One');
  static const Check_Kind All = Check_Kind._(1, _omitEnumNames ? '' : 'All');
  static const Check_Kind Reject =
      Check_Kind._(2, _omitEnumNames ? '' : 'Reject');

  static const $core.List<Check_Kind> values = <Check_Kind>[
    One,
    All,
    Reject,
  ];

  static final $core.List<Check_Kind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static Check_Kind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Check_Kind._(super.value, super.name);
}

class OpUnary_Kind extends $pb.ProtobufEnum {
  static const OpUnary_Kind Negate =
      OpUnary_Kind._(0, _omitEnumNames ? '' : 'Negate');
  static const OpUnary_Kind Parens =
      OpUnary_Kind._(1, _omitEnumNames ? '' : 'Parens');
  static const OpUnary_Kind Length =
      OpUnary_Kind._(2, _omitEnumNames ? '' : 'Length');
  static const OpUnary_Kind TypeOf =
      OpUnary_Kind._(3, _omitEnumNames ? '' : 'TypeOf');
  static const OpUnary_Kind Ffi =
      OpUnary_Kind._(4, _omitEnumNames ? '' : 'Ffi');

  static const $core.List<OpUnary_Kind> values = <OpUnary_Kind>[
    Negate,
    Parens,
    Length,
    TypeOf,
    Ffi,
  ];

  static final $core.List<OpUnary_Kind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static OpUnary_Kind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OpUnary_Kind._(super.value, super.name);
}

class OpBinary_Kind extends $pb.ProtobufEnum {
  static const OpBinary_Kind LessThan =
      OpBinary_Kind._(0, _omitEnumNames ? '' : 'LessThan');
  static const OpBinary_Kind GreaterThan =
      OpBinary_Kind._(1, _omitEnumNames ? '' : 'GreaterThan');
  static const OpBinary_Kind LessOrEqual =
      OpBinary_Kind._(2, _omitEnumNames ? '' : 'LessOrEqual');
  static const OpBinary_Kind GreaterOrEqual =
      OpBinary_Kind._(3, _omitEnumNames ? '' : 'GreaterOrEqual');
  static const OpBinary_Kind Equal =
      OpBinary_Kind._(4, _omitEnumNames ? '' : 'Equal');
  static const OpBinary_Kind Contains =
      OpBinary_Kind._(5, _omitEnumNames ? '' : 'Contains');
  static const OpBinary_Kind Prefix =
      OpBinary_Kind._(6, _omitEnumNames ? '' : 'Prefix');
  static const OpBinary_Kind Suffix =
      OpBinary_Kind._(7, _omitEnumNames ? '' : 'Suffix');
  static const OpBinary_Kind Regex =
      OpBinary_Kind._(8, _omitEnumNames ? '' : 'Regex');
  static const OpBinary_Kind Add =
      OpBinary_Kind._(9, _omitEnumNames ? '' : 'Add');
  static const OpBinary_Kind Sub =
      OpBinary_Kind._(10, _omitEnumNames ? '' : 'Sub');
  static const OpBinary_Kind Mul =
      OpBinary_Kind._(11, _omitEnumNames ? '' : 'Mul');
  static const OpBinary_Kind Div =
      OpBinary_Kind._(12, _omitEnumNames ? '' : 'Div');
  static const OpBinary_Kind And =
      OpBinary_Kind._(13, _omitEnumNames ? '' : 'And');
  static const OpBinary_Kind Or =
      OpBinary_Kind._(14, _omitEnumNames ? '' : 'Or');
  static const OpBinary_Kind Intersection =
      OpBinary_Kind._(15, _omitEnumNames ? '' : 'Intersection');
  static const OpBinary_Kind Union =
      OpBinary_Kind._(16, _omitEnumNames ? '' : 'Union');
  static const OpBinary_Kind BitwiseAnd =
      OpBinary_Kind._(17, _omitEnumNames ? '' : 'BitwiseAnd');
  static const OpBinary_Kind BitwiseOr =
      OpBinary_Kind._(18, _omitEnumNames ? '' : 'BitwiseOr');
  static const OpBinary_Kind BitwiseXor =
      OpBinary_Kind._(19, _omitEnumNames ? '' : 'BitwiseXor');
  static const OpBinary_Kind NotEqual =
      OpBinary_Kind._(20, _omitEnumNames ? '' : 'NotEqual');
  static const OpBinary_Kind HeterogeneousEqual =
      OpBinary_Kind._(21, _omitEnumNames ? '' : 'HeterogeneousEqual');
  static const OpBinary_Kind HeterogeneousNotEqual =
      OpBinary_Kind._(22, _omitEnumNames ? '' : 'HeterogeneousNotEqual');
  static const OpBinary_Kind LazyAnd =
      OpBinary_Kind._(23, _omitEnumNames ? '' : 'LazyAnd');
  static const OpBinary_Kind LazyOr =
      OpBinary_Kind._(24, _omitEnumNames ? '' : 'LazyOr');
  static const OpBinary_Kind All =
      OpBinary_Kind._(25, _omitEnumNames ? '' : 'All');
  static const OpBinary_Kind Any =
      OpBinary_Kind._(26, _omitEnumNames ? '' : 'Any');
  static const OpBinary_Kind Get =
      OpBinary_Kind._(27, _omitEnumNames ? '' : 'Get');
  static const OpBinary_Kind Ffi =
      OpBinary_Kind._(28, _omitEnumNames ? '' : 'Ffi');
  static const OpBinary_Kind TryOr =
      OpBinary_Kind._(29, _omitEnumNames ? '' : 'TryOr');

  static const $core.List<OpBinary_Kind> values = <OpBinary_Kind>[
    LessThan,
    GreaterThan,
    LessOrEqual,
    GreaterOrEqual,
    Equal,
    Contains,
    Prefix,
    Suffix,
    Regex,
    Add,
    Sub,
    Mul,
    Div,
    And,
    Or,
    Intersection,
    Union,
    BitwiseAnd,
    BitwiseOr,
    BitwiseXor,
    NotEqual,
    HeterogeneousEqual,
    HeterogeneousNotEqual,
    LazyAnd,
    LazyOr,
    All,
    Any,
    Get,
    Ffi,
    TryOr,
  ];

  static final $core.List<OpBinary_Kind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 29);
  static OpBinary_Kind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const OpBinary_Kind._(super.value, super.name);
}

class Policy_Kind extends $pb.ProtobufEnum {
  static const Policy_Kind Allow =
      Policy_Kind._(0, _omitEnumNames ? '' : 'Allow');
  static const Policy_Kind Deny =
      Policy_Kind._(1, _omitEnumNames ? '' : 'Deny');

  static const $core.List<Policy_Kind> values = <Policy_Kind>[
    Allow,
    Deny,
  ];

  static final $core.List<Policy_Kind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static Policy_Kind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Policy_Kind._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
