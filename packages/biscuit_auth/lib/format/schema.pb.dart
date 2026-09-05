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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'schema.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'schema.pbenum.dart';

class Biscuit extends $pb.GeneratedMessage {
  factory Biscuit({
    $core.int? rootKeyId,
    SignedBlock? authority,
    $core.Iterable<SignedBlock>? blocks,
    Proof? proof,
  }) {
    final result = create();
    if (rootKeyId != null) result.rootKeyId = rootKeyId;
    if (authority != null) result.authority = authority;
    if (blocks != null) result.blocks.addAll(blocks);
    if (proof != null) result.proof = proof;
    return result;
  }

  Biscuit._();

  factory Biscuit.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Biscuit.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Biscuit',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'rootKeyId',
        protoName: 'rootKeyId', fieldType: $pb.PbFieldType.OU3)
    ..aQM<SignedBlock>(2, _omitFieldNames ? '' : 'authority',
        subBuilder: SignedBlock.create)
    ..pPM<SignedBlock>(3, _omitFieldNames ? '' : 'blocks',
        subBuilder: SignedBlock.create)
    ..aQM<Proof>(4, _omitFieldNames ? '' : 'proof', subBuilder: Proof.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Biscuit clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Biscuit copyWith(void Function(Biscuit) updates) =>
      super.copyWith((message) => updates(message as Biscuit)) as Biscuit;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Biscuit create() => Biscuit._();
  @$core.override
  Biscuit createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Biscuit getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Biscuit>(create);
  static Biscuit? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get rootKeyId => $_getIZ(0);
  @$pb.TagNumber(1)
  set rootKeyId($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRootKeyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRootKeyId() => $_clearField(1);

  @$pb.TagNumber(2)
  SignedBlock get authority => $_getN(1);
  @$pb.TagNumber(2)
  set authority(SignedBlock value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAuthority() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthority() => $_clearField(2);
  @$pb.TagNumber(2)
  SignedBlock ensureAuthority() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<SignedBlock> get blocks => $_getList(2);

  @$pb.TagNumber(4)
  Proof get proof => $_getN(3);
  @$pb.TagNumber(4)
  set proof(Proof value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasProof() => $_has(3);
  @$pb.TagNumber(4)
  void clearProof() => $_clearField(4);
  @$pb.TagNumber(4)
  Proof ensureProof() => $_ensure(3);
}

class SignedBlock extends $pb.GeneratedMessage {
  factory SignedBlock({
    $core.List<$core.int>? block,
    PublicKey? nextKey,
    $core.List<$core.int>? signature,
    ExternalSignature? externalSignature,
    $core.int? version,
  }) {
    final result = create();
    if (block != null) result.block = block;
    if (nextKey != null) result.nextKey = nextKey;
    if (signature != null) result.signature = signature;
    if (externalSignature != null) result.externalSignature = externalSignature;
    if (version != null) result.version = version;
    return result;
  }

  SignedBlock._();

  factory SignedBlock.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SignedBlock.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignedBlock',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'block', $pb.PbFieldType.QY)
    ..aQM<PublicKey>(2, _omitFieldNames ? '' : 'nextKey',
        protoName: 'nextKey', subBuilder: PublicKey.create)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.QY)
    ..aOM<ExternalSignature>(4, _omitFieldNames ? '' : 'externalSignature',
        protoName: 'externalSignature', subBuilder: ExternalSignature.create)
    ..aI(5, _omitFieldNames ? '' : 'version', fieldType: $pb.PbFieldType.OU3);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignedBlock clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignedBlock copyWith(void Function(SignedBlock) updates) =>
      super.copyWith((message) => updates(message as SignedBlock))
          as SignedBlock;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignedBlock create() => SignedBlock._();
  @$core.override
  SignedBlock createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SignedBlock getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignedBlock>(create);
  static SignedBlock? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get block => $_getN(0);
  @$pb.TagNumber(1)
  set block($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBlock() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlock() => $_clearField(1);

  @$pb.TagNumber(2)
  PublicKey get nextKey => $_getN(1);
  @$pb.TagNumber(2)
  set nextKey(PublicKey value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasNextKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextKey() => $_clearField(2);
  @$pb.TagNumber(2)
  PublicKey ensureNextKey() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<$core.int> get signature => $_getN(2);
  @$pb.TagNumber(3)
  set signature($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSignature() => $_has(2);
  @$pb.TagNumber(3)
  void clearSignature() => $_clearField(3);

  @$pb.TagNumber(4)
  ExternalSignature get externalSignature => $_getN(3);
  @$pb.TagNumber(4)
  set externalSignature(ExternalSignature value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasExternalSignature() => $_has(3);
  @$pb.TagNumber(4)
  void clearExternalSignature() => $_clearField(4);
  @$pb.TagNumber(4)
  ExternalSignature ensureExternalSignature() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.int get version => $_getIZ(4);
  @$pb.TagNumber(5)
  set version($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearVersion() => $_clearField(5);
}

class ExternalSignature extends $pb.GeneratedMessage {
  factory ExternalSignature({
    $core.List<$core.int>? signature,
    PublicKey? publicKey,
  }) {
    final result = create();
    if (signature != null) result.signature = signature;
    if (publicKey != null) result.publicKey = publicKey;
    return result;
  }

  ExternalSignature._();

  factory ExternalSignature.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExternalSignature.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExternalSignature',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.QY)
    ..aQM<PublicKey>(2, _omitFieldNames ? '' : 'publicKey',
        protoName: 'publicKey', subBuilder: PublicKey.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExternalSignature clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExternalSignature copyWith(void Function(ExternalSignature) updates) =>
      super.copyWith((message) => updates(message as ExternalSignature))
          as ExternalSignature;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExternalSignature create() => ExternalSignature._();
  @$core.override
  ExternalSignature createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ExternalSignature getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExternalSignature>(create);
  static ExternalSignature? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get signature => $_getN(0);
  @$pb.TagNumber(1)
  set signature($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignature() => $_clearField(1);

  @$pb.TagNumber(2)
  PublicKey get publicKey => $_getN(1);
  @$pb.TagNumber(2)
  set publicKey(PublicKey value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPublicKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearPublicKey() => $_clearField(2);
  @$pb.TagNumber(2)
  PublicKey ensurePublicKey() => $_ensure(1);
}

class PublicKey extends $pb.GeneratedMessage {
  factory PublicKey({
    PublicKey_Algorithm? algorithm,
    $core.List<$core.int>? key,
  }) {
    final result = create();
    if (algorithm != null) result.algorithm = algorithm;
    if (key != null) result.key = key;
    return result;
  }

  PublicKey._();

  factory PublicKey.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PublicKey.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PublicKey',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..aE<PublicKey_Algorithm>(1, _omitFieldNames ? '' : 'algorithm',
        fieldType: $pb.PbFieldType.QE, enumValues: PublicKey_Algorithm.values)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'key', $pb.PbFieldType.QY);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublicKey clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PublicKey copyWith(void Function(PublicKey) updates) =>
      super.copyWith((message) => updates(message as PublicKey)) as PublicKey;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PublicKey create() => PublicKey._();
  @$core.override
  PublicKey createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PublicKey getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PublicKey>(create);
  static PublicKey? _defaultInstance;

  @$pb.TagNumber(1)
  PublicKey_Algorithm get algorithm => $_getN(0);
  @$pb.TagNumber(1)
  set algorithm(PublicKey_Algorithm value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAlgorithm() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlgorithm() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get key => $_getN(1);
  @$pb.TagNumber(2)
  set key($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => $_clearField(2);
}

enum Proof_Content { nextSecret, finalSignature, notSet }

class Proof extends $pb.GeneratedMessage {
  factory Proof({
    $core.List<$core.int>? nextSecret,
    $core.List<$core.int>? finalSignature,
  }) {
    final result = create();
    if (nextSecret != null) result.nextSecret = nextSecret;
    if (finalSignature != null) result.finalSignature = finalSignature;
    return result;
  }

  Proof._();

  factory Proof.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Proof.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Proof_Content> _Proof_ContentByTag = {
    1: Proof_Content.nextSecret,
    2: Proof_Content.finalSignature,
    0: Proof_Content.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Proof',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'nextSecret', $pb.PbFieldType.OY,
        protoName: 'nextSecret')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'finalSignature', $pb.PbFieldType.OY,
        protoName: 'finalSignature')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Proof clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Proof copyWith(void Function(Proof) updates) =>
      super.copyWith((message) => updates(message as Proof)) as Proof;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Proof create() => Proof._();
  @$core.override
  Proof createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Proof getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Proof>(create);
  static Proof? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  Proof_Content whichContent() => _Proof_ContentByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearContent() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.List<$core.int> get nextSecret => $_getN(0);
  @$pb.TagNumber(1)
  set nextSecret($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNextSecret() => $_has(0);
  @$pb.TagNumber(1)
  void clearNextSecret() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get finalSignature => $_getN(1);
  @$pb.TagNumber(2)
  set finalSignature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFinalSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearFinalSignature() => $_clearField(2);
}

class Block extends $pb.GeneratedMessage {
  factory Block({
    $core.Iterable<$core.String>? symbols,
    $core.String? context,
    $core.int? version,
    $core.Iterable<Fact>? facts,
    $core.Iterable<Rule>? rules,
    $core.Iterable<Check>? checks,
    $core.Iterable<Scope>? scope,
    $core.Iterable<PublicKey>? publicKeys,
  }) {
    final result = create();
    if (symbols != null) result.symbols.addAll(symbols);
    if (context != null) result.context = context;
    if (version != null) result.version = version;
    if (facts != null) result.facts.addAll(facts);
    if (rules != null) result.rules.addAll(rules);
    if (checks != null) result.checks.addAll(checks);
    if (scope != null) result.scope.addAll(scope);
    if (publicKeys != null) result.publicKeys.addAll(publicKeys);
    return result;
  }

  Block._();

  factory Block.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Block.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Block',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'symbols')
    ..aOS(2, _omitFieldNames ? '' : 'context')
    ..aI(3, _omitFieldNames ? '' : 'version', fieldType: $pb.PbFieldType.OU3)
    ..pPM<Fact>(4, _omitFieldNames ? '' : 'facts', subBuilder: Fact.create)
    ..pPM<Rule>(5, _omitFieldNames ? '' : 'rules', subBuilder: Rule.create)
    ..pPM<Check>(6, _omitFieldNames ? '' : 'checks', subBuilder: Check.create)
    ..pPM<Scope>(7, _omitFieldNames ? '' : 'scope', subBuilder: Scope.create)
    ..pPM<PublicKey>(8, _omitFieldNames ? '' : 'publicKeys',
        protoName: 'publicKeys', subBuilder: PublicKey.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Block clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Block copyWith(void Function(Block) updates) =>
      super.copyWith((message) => updates(message as Block)) as Block;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Block create() => Block._();
  @$core.override
  Block createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Block getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Block>(create);
  static Block? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get symbols => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get context => $_getSZ(1);
  @$pb.TagNumber(2)
  set context($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContext() => $_has(1);
  @$pb.TagNumber(2)
  void clearContext() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get version => $_getIZ(2);
  @$pb.TagNumber(3)
  set version($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<Fact> get facts => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<Rule> get rules => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<Check> get checks => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<Scope> get scope => $_getList(6);

  @$pb.TagNumber(8)
  $pb.PbList<PublicKey> get publicKeys => $_getList(7);
}

enum Scope_Content { scopeType, publicKey, notSet }

class Scope extends $pb.GeneratedMessage {
  factory Scope({
    Scope_ScopeType? scopeType,
    $fixnum.Int64? publicKey,
  }) {
    final result = create();
    if (scopeType != null) result.scopeType = scopeType;
    if (publicKey != null) result.publicKey = publicKey;
    return result;
  }

  Scope._();

  factory Scope.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Scope.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Scope_Content> _Scope_ContentByTag = {
    1: Scope_Content.scopeType,
    2: Scope_Content.publicKey,
    0: Scope_Content.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Scope',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aE<Scope_ScopeType>(1, _omitFieldNames ? '' : 'scopeType',
        protoName: 'scopeType', enumValues: Scope_ScopeType.values)
    ..aInt64(2, _omitFieldNames ? '' : 'publicKey', protoName: 'publicKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Scope clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Scope copyWith(void Function(Scope) updates) =>
      super.copyWith((message) => updates(message as Scope)) as Scope;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Scope create() => Scope._();
  @$core.override
  Scope createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Scope getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Scope>(create);
  static Scope? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  Scope_Content whichContent() => _Scope_ContentByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearContent() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Scope_ScopeType get scopeType => $_getN(0);
  @$pb.TagNumber(1)
  set scopeType(Scope_ScopeType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasScopeType() => $_has(0);
  @$pb.TagNumber(1)
  void clearScopeType() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get publicKey => $_getI64(1);
  @$pb.TagNumber(2)
  set publicKey($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPublicKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearPublicKey() => $_clearField(2);
}

class Fact extends $pb.GeneratedMessage {
  factory Fact({
    Predicate? predicate,
  }) {
    final result = create();
    if (predicate != null) result.predicate = predicate;
    return result;
  }

  Fact._();

  factory Fact.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Fact.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Fact',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..aQM<Predicate>(1, _omitFieldNames ? '' : 'predicate',
        subBuilder: Predicate.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Fact clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Fact copyWith(void Function(Fact) updates) =>
      super.copyWith((message) => updates(message as Fact)) as Fact;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Fact create() => Fact._();
  @$core.override
  Fact createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Fact getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Fact>(create);
  static Fact? _defaultInstance;

  @$pb.TagNumber(1)
  Predicate get predicate => $_getN(0);
  @$pb.TagNumber(1)
  set predicate(Predicate value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPredicate() => $_has(0);
  @$pb.TagNumber(1)
  void clearPredicate() => $_clearField(1);
  @$pb.TagNumber(1)
  Predicate ensurePredicate() => $_ensure(0);
}

class Rule extends $pb.GeneratedMessage {
  factory Rule({
    Predicate? head,
    $core.Iterable<Predicate>? body,
    $core.Iterable<Expression>? expressions,
    $core.Iterable<Scope>? scope,
  }) {
    final result = create();
    if (head != null) result.head = head;
    if (body != null) result.body.addAll(body);
    if (expressions != null) result.expressions.addAll(expressions);
    if (scope != null) result.scope.addAll(scope);
    return result;
  }

  Rule._();

  factory Rule.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Rule.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Rule',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..aQM<Predicate>(1, _omitFieldNames ? '' : 'head',
        subBuilder: Predicate.create)
    ..pPM<Predicate>(2, _omitFieldNames ? '' : 'body',
        subBuilder: Predicate.create)
    ..pPM<Expression>(3, _omitFieldNames ? '' : 'expressions',
        subBuilder: Expression.create)
    ..pPM<Scope>(4, _omitFieldNames ? '' : 'scope', subBuilder: Scope.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Rule clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Rule copyWith(void Function(Rule) updates) =>
      super.copyWith((message) => updates(message as Rule)) as Rule;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Rule create() => Rule._();
  @$core.override
  Rule createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Rule getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Rule>(create);
  static Rule? _defaultInstance;

  @$pb.TagNumber(1)
  Predicate get head => $_getN(0);
  @$pb.TagNumber(1)
  set head(Predicate value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasHead() => $_has(0);
  @$pb.TagNumber(1)
  void clearHead() => $_clearField(1);
  @$pb.TagNumber(1)
  Predicate ensureHead() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<Predicate> get body => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<Expression> get expressions => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<Scope> get scope => $_getList(3);
}

class Check extends $pb.GeneratedMessage {
  factory Check({
    $core.Iterable<Rule>? queries,
    Check_Kind? kind,
  }) {
    final result = create();
    if (queries != null) result.queries.addAll(queries);
    if (kind != null) result.kind = kind;
    return result;
  }

  Check._();

  factory Check.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Check.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Check',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..pPM<Rule>(1, _omitFieldNames ? '' : 'queries', subBuilder: Rule.create)
    ..aE<Check_Kind>(2, _omitFieldNames ? '' : 'kind',
        enumValues: Check_Kind.values);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Check clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Check copyWith(void Function(Check) updates) =>
      super.copyWith((message) => updates(message as Check)) as Check;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Check create() => Check._();
  @$core.override
  Check createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Check getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Check>(create);
  static Check? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Rule> get queries => $_getList(0);

  @$pb.TagNumber(2)
  Check_Kind get kind => $_getN(1);
  @$pb.TagNumber(2)
  set kind(Check_Kind value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => $_clearField(2);
}

class Predicate extends $pb.GeneratedMessage {
  factory Predicate({
    $fixnum.Int64? name,
    $core.Iterable<Term>? terms,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (terms != null) result.terms.addAll(terms);
    return result;
  }

  Predicate._();

  factory Predicate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Predicate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Predicate',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'name', $pb.PbFieldType.QU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..pPM<Term>(2, _omitFieldNames ? '' : 'terms', subBuilder: Term.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Predicate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Predicate copyWith(void Function(Predicate) updates) =>
      super.copyWith((message) => updates(message as Predicate)) as Predicate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Predicate create() => Predicate._();
  @$core.override
  Predicate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Predicate getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Predicate>(create);
  static Predicate? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get name => $_getI64(0);
  @$pb.TagNumber(1)
  set name($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<Term> get terms => $_getList(1);
}

enum Term_Content {
  variable,
  integer,
  string,
  date,
  bytes,
  bool_6,
  set,
  null_8,
  array,
  map,
  notSet
}

class Term extends $pb.GeneratedMessage {
  factory Term({
    $core.int? variable,
    $fixnum.Int64? integer,
    $fixnum.Int64? string,
    $fixnum.Int64? date,
    $core.List<$core.int>? bytes,
    $core.bool? bool_6,
    TermSet? set,
    Empty? null_8,
    Array? array,
    Map_? map,
  }) {
    final result = create();
    if (variable != null) result.variable = variable;
    if (integer != null) result.integer = integer;
    if (string != null) result.string = string;
    if (date != null) result.date = date;
    if (bytes != null) result.bytes = bytes;
    if (bool_6 != null) result.bool_6 = bool_6;
    if (set != null) result.set = set;
    if (null_8 != null) result.null_8 = null_8;
    if (array != null) result.array = array;
    if (map != null) result.map = map;
    return result;
  }

  Term._();

  factory Term.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Term.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Term_Content> _Term_ContentByTag = {
    1: Term_Content.variable,
    2: Term_Content.integer,
    3: Term_Content.string,
    4: Term_Content.date,
    5: Term_Content.bytes,
    6: Term_Content.bool_6,
    7: Term_Content.set,
    8: Term_Content.null_8,
    9: Term_Content.array,
    10: Term_Content.map,
    0: Term_Content.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Term',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    ..aI(1, _omitFieldNames ? '' : 'variable', fieldType: $pb.PbFieldType.OU3)
    ..aInt64(2, _omitFieldNames ? '' : 'integer')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'string', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'date', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(
        5, _omitFieldNames ? '' : 'bytes', $pb.PbFieldType.OY)
    ..aOB(6, _omitFieldNames ? '' : 'bool')
    ..aOM<TermSet>(7, _omitFieldNames ? '' : 'set', subBuilder: TermSet.create)
    ..aOM<Empty>(8, _omitFieldNames ? '' : 'null', subBuilder: Empty.create)
    ..aOM<Array>(9, _omitFieldNames ? '' : 'array', subBuilder: Array.create)
    ..aOM<Map_>(10, _omitFieldNames ? '' : 'map', subBuilder: Map_.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Term clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Term copyWith(void Function(Term) updates) =>
      super.copyWith((message) => updates(message as Term)) as Term;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Term create() => Term._();
  @$core.override
  Term createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Term getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Term>(create);
  static Term? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  Term_Content whichContent() => _Term_ContentByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  void clearContent() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.int get variable => $_getIZ(0);
  @$pb.TagNumber(1)
  set variable($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVariable() => $_has(0);
  @$pb.TagNumber(1)
  void clearVariable() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get integer => $_getI64(1);
  @$pb.TagNumber(2)
  set integer($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInteger() => $_has(1);
  @$pb.TagNumber(2)
  void clearInteger() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get string => $_getI64(2);
  @$pb.TagNumber(3)
  set string($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasString() => $_has(2);
  @$pb.TagNumber(3)
  void clearString() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get date => $_getI64(3);
  @$pb.TagNumber(4)
  set date($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearDate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get bytes => $_getN(4);
  @$pb.TagNumber(5)
  set bytes($core.List<$core.int> value) => $_setBytes(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBytes() => $_has(4);
  @$pb.TagNumber(5)
  void clearBytes() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get bool_6 => $_getBF(5);
  @$pb.TagNumber(6)
  set bool_6($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBool_6() => $_has(5);
  @$pb.TagNumber(6)
  void clearBool_6() => $_clearField(6);

  @$pb.TagNumber(7)
  TermSet get set => $_getN(6);
  @$pb.TagNumber(7)
  set set(TermSet value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSet() => $_has(6);
  @$pb.TagNumber(7)
  void clearSet() => $_clearField(7);
  @$pb.TagNumber(7)
  TermSet ensureSet() => $_ensure(6);

  @$pb.TagNumber(8)
  Empty get null_8 => $_getN(7);
  @$pb.TagNumber(8)
  set null_8(Empty value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasNull_8() => $_has(7);
  @$pb.TagNumber(8)
  void clearNull_8() => $_clearField(8);
  @$pb.TagNumber(8)
  Empty ensureNull_8() => $_ensure(7);

  @$pb.TagNumber(9)
  Array get array => $_getN(8);
  @$pb.TagNumber(9)
  set array(Array value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasArray() => $_has(8);
  @$pb.TagNumber(9)
  void clearArray() => $_clearField(9);
  @$pb.TagNumber(9)
  Array ensureArray() => $_ensure(8);

  @$pb.TagNumber(10)
  Map_ get map => $_getN(9);
  @$pb.TagNumber(10)
  set map(Map_ value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasMap() => $_has(9);
  @$pb.TagNumber(10)
  void clearMap() => $_clearField(10);
  @$pb.TagNumber(10)
  Map_ ensureMap() => $_ensure(9);
}

class TermSet extends $pb.GeneratedMessage {
  factory TermSet({
    $core.Iterable<Term>? set,
  }) {
    final result = create();
    if (set != null) result.set.addAll(set);
    return result;
  }

  TermSet._();

  factory TermSet.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TermSet.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TermSet',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..pPM<Term>(1, _omitFieldNames ? '' : 'set', subBuilder: Term.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TermSet clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TermSet copyWith(void Function(TermSet) updates) =>
      super.copyWith((message) => updates(message as TermSet)) as TermSet;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TermSet create() => TermSet._();
  @$core.override
  TermSet createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TermSet getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TermSet>(create);
  static TermSet? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Term> get set => $_getList(0);
}

class Array extends $pb.GeneratedMessage {
  factory Array({
    $core.Iterable<Term>? array,
  }) {
    final result = create();
    if (array != null) result.array.addAll(array);
    return result;
  }

  Array._();

  factory Array.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Array.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Array',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..pPM<Term>(1, _omitFieldNames ? '' : 'array', subBuilder: Term.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Array clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Array copyWith(void Function(Array) updates) =>
      super.copyWith((message) => updates(message as Array)) as Array;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Array create() => Array._();
  @$core.override
  Array createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Array getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Array>(create);
  static Array? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Term> get array => $_getList(0);
}

class Map_ extends $pb.GeneratedMessage {
  factory Map_({
    $core.Iterable<MapEntry>? entries,
  }) {
    final result = create();
    if (entries != null) result.entries.addAll(entries);
    return result;
  }

  Map_._();

  factory Map_.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Map_.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Map',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..pPM<MapEntry>(1, _omitFieldNames ? '' : 'entries',
        subBuilder: MapEntry.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Map_ clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Map_ copyWith(void Function(Map_) updates) =>
      super.copyWith((message) => updates(message as Map_)) as Map_;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Map_ create() => Map_._();
  @$core.override
  Map_ createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Map_ getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Map_>(create);
  static Map_? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MapEntry> get entries => $_getList(0);
}

class MapEntry extends $pb.GeneratedMessage {
  factory MapEntry({
    MapKey? key,
    Term? value,
  }) {
    final result = create();
    if (key != null) result.key = key;
    if (value != null) result.value = value;
    return result;
  }

  MapEntry._();

  factory MapEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MapEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MapEntry',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..aQM<MapKey>(1, _omitFieldNames ? '' : 'key', subBuilder: MapKey.create)
    ..aQM<Term>(2, _omitFieldNames ? '' : 'value', subBuilder: Term.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MapEntry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MapEntry copyWith(void Function(MapEntry) updates) =>
      super.copyWith((message) => updates(message as MapEntry)) as MapEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MapEntry create() => MapEntry._();
  @$core.override
  MapEntry createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MapEntry getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MapEntry>(create);
  static MapEntry? _defaultInstance;

  @$pb.TagNumber(1)
  MapKey get key => $_getN(0);
  @$pb.TagNumber(1)
  set key(MapKey value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);
  @$pb.TagNumber(1)
  MapKey ensureKey() => $_ensure(0);

  @$pb.TagNumber(2)
  Term get value => $_getN(1);
  @$pb.TagNumber(2)
  set value(Term value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
  @$pb.TagNumber(2)
  Term ensureValue() => $_ensure(1);
}

enum MapKey_Content { integer, string, notSet }

class MapKey extends $pb.GeneratedMessage {
  factory MapKey({
    $fixnum.Int64? integer,
    $fixnum.Int64? string,
  }) {
    final result = create();
    if (integer != null) result.integer = integer;
    if (string != null) result.string = string;
    return result;
  }

  MapKey._();

  factory MapKey.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MapKey.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, MapKey_Content> _MapKey_ContentByTag = {
    1: MapKey_Content.integer,
    2: MapKey_Content.string,
    0: MapKey_Content.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MapKey',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aInt64(1, _omitFieldNames ? '' : 'integer')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'string', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MapKey clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MapKey copyWith(void Function(MapKey) updates) =>
      super.copyWith((message) => updates(message as MapKey)) as MapKey;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MapKey create() => MapKey._();
  @$core.override
  MapKey createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MapKey getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MapKey>(create);
  static MapKey? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  MapKey_Content whichContent() => _MapKey_ContentByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearContent() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $fixnum.Int64 get integer => $_getI64(0);
  @$pb.TagNumber(1)
  set integer($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInteger() => $_has(0);
  @$pb.TagNumber(1)
  void clearInteger() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get string => $_getI64(1);
  @$pb.TagNumber(2)
  set string($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasString() => $_has(1);
  @$pb.TagNumber(2)
  void clearString() => $_clearField(2);
}

class Expression extends $pb.GeneratedMessage {
  factory Expression({
    $core.Iterable<Op>? ops,
  }) {
    final result = create();
    if (ops != null) result.ops.addAll(ops);
    return result;
  }

  Expression._();

  factory Expression.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Expression.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Expression',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..pPM<Op>(1, _omitFieldNames ? '' : 'ops', subBuilder: Op.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Expression clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Expression copyWith(void Function(Expression) updates) =>
      super.copyWith((message) => updates(message as Expression)) as Expression;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Expression create() => Expression._();
  @$core.override
  Expression createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Expression getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Expression>(create);
  static Expression? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Op> get ops => $_getList(0);
}

enum Op_Content { value, unary, binary, closure, notSet }

class Op extends $pb.GeneratedMessage {
  factory Op({
    Term? value,
    OpUnary? unary,
    OpBinary? binary,
    OpClosure? closure,
  }) {
    final result = create();
    if (value != null) result.value = value;
    if (unary != null) result.unary = unary;
    if (binary != null) result.binary = binary;
    if (closure != null) result.closure = closure;
    return result;
  }

  Op._();

  factory Op.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Op.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Op_Content> _Op_ContentByTag = {
    1: Op_Content.value,
    2: Op_Content.unary,
    3: Op_Content.binary,
    4: Op_Content.closure,
    0: Op_Content.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Op',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4])
    ..aOM<Term>(1, _omitFieldNames ? '' : 'value', subBuilder: Term.create)
    ..aOM<OpUnary>(2, _omitFieldNames ? '' : 'unary',
        subBuilder: OpUnary.create)
    ..aOM<OpBinary>(3, _omitFieldNames ? '' : 'Binary',
        protoName: 'Binary', subBuilder: OpBinary.create)
    ..aOM<OpClosure>(4, _omitFieldNames ? '' : 'closure',
        subBuilder: OpClosure.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Op clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Op copyWith(void Function(Op) updates) =>
      super.copyWith((message) => updates(message as Op)) as Op;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Op create() => Op._();
  @$core.override
  Op createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Op getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Op>(create);
  static Op? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  Op_Content whichContent() => _Op_ContentByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  void clearContent() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Term get value => $_getN(0);
  @$pb.TagNumber(1)
  set value(Term value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => $_clearField(1);
  @$pb.TagNumber(1)
  Term ensureValue() => $_ensure(0);

  @$pb.TagNumber(2)
  OpUnary get unary => $_getN(1);
  @$pb.TagNumber(2)
  set unary(OpUnary value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUnary() => $_has(1);
  @$pb.TagNumber(2)
  void clearUnary() => $_clearField(2);
  @$pb.TagNumber(2)
  OpUnary ensureUnary() => $_ensure(1);

  @$pb.TagNumber(3)
  OpBinary get binary => $_getN(2);
  @$pb.TagNumber(3)
  set binary(OpBinary value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasBinary() => $_has(2);
  @$pb.TagNumber(3)
  void clearBinary() => $_clearField(3);
  @$pb.TagNumber(3)
  OpBinary ensureBinary() => $_ensure(2);

  @$pb.TagNumber(4)
  OpClosure get closure => $_getN(3);
  @$pb.TagNumber(4)
  set closure(OpClosure value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasClosure() => $_has(3);
  @$pb.TagNumber(4)
  void clearClosure() => $_clearField(4);
  @$pb.TagNumber(4)
  OpClosure ensureClosure() => $_ensure(3);
}

class OpUnary extends $pb.GeneratedMessage {
  factory OpUnary({
    OpUnary_Kind? kind,
    $fixnum.Int64? ffiName,
  }) {
    final result = create();
    if (kind != null) result.kind = kind;
    if (ffiName != null) result.ffiName = ffiName;
    return result;
  }

  OpUnary._();

  factory OpUnary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OpUnary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpUnary',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..aE<OpUnary_Kind>(1, _omitFieldNames ? '' : 'kind',
        fieldType: $pb.PbFieldType.QE, enumValues: OpUnary_Kind.values)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'ffiName', $pb.PbFieldType.OU6,
        protoName: 'ffiName', defaultOrMaker: $fixnum.Int64.ZERO);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpUnary clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpUnary copyWith(void Function(OpUnary) updates) =>
      super.copyWith((message) => updates(message as OpUnary)) as OpUnary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpUnary create() => OpUnary._();
  @$core.override
  OpUnary createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OpUnary getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpUnary>(create);
  static OpUnary? _defaultInstance;

  @$pb.TagNumber(1)
  OpUnary_Kind get kind => $_getN(0);
  @$pb.TagNumber(1)
  set kind(OpUnary_Kind value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get ffiName => $_getI64(1);
  @$pb.TagNumber(2)
  set ffiName($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFfiName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFfiName() => $_clearField(2);
}

class OpBinary extends $pb.GeneratedMessage {
  factory OpBinary({
    OpBinary_Kind? kind,
    $fixnum.Int64? ffiName,
  }) {
    final result = create();
    if (kind != null) result.kind = kind;
    if (ffiName != null) result.ffiName = ffiName;
    return result;
  }

  OpBinary._();

  factory OpBinary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OpBinary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpBinary',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..aE<OpBinary_Kind>(1, _omitFieldNames ? '' : 'kind',
        fieldType: $pb.PbFieldType.QE, enumValues: OpBinary_Kind.values)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'ffiName', $pb.PbFieldType.OU6,
        protoName: 'ffiName', defaultOrMaker: $fixnum.Int64.ZERO);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpBinary clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpBinary copyWith(void Function(OpBinary) updates) =>
      super.copyWith((message) => updates(message as OpBinary)) as OpBinary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpBinary create() => OpBinary._();
  @$core.override
  OpBinary createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OpBinary getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpBinary>(create);
  static OpBinary? _defaultInstance;

  @$pb.TagNumber(1)
  OpBinary_Kind get kind => $_getN(0);
  @$pb.TagNumber(1)
  set kind(OpBinary_Kind value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get ffiName => $_getI64(1);
  @$pb.TagNumber(2)
  set ffiName($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFfiName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFfiName() => $_clearField(2);
}

class OpClosure extends $pb.GeneratedMessage {
  factory OpClosure({
    $core.Iterable<$core.int>? params,
    $core.Iterable<Op>? ops,
  }) {
    final result = create();
    if (params != null) result.params.addAll(params);
    if (ops != null) result.ops.addAll(ops);
    return result;
  }

  OpClosure._();

  factory OpClosure.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OpClosure.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OpClosure',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..p<$core.int>(1, _omitFieldNames ? '' : 'params', $pb.PbFieldType.PU3)
    ..pPM<Op>(2, _omitFieldNames ? '' : 'ops', subBuilder: Op.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpClosure clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OpClosure copyWith(void Function(OpClosure) updates) =>
      super.copyWith((message) => updates(message as OpClosure)) as OpClosure;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpClosure create() => OpClosure._();
  @$core.override
  OpClosure createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static OpClosure getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpClosure>(create);
  static OpClosure? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.int> get params => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<Op> get ops => $_getList(1);
}

class Policy extends $pb.GeneratedMessage {
  factory Policy({
    $core.Iterable<Rule>? queries,
    Policy_Kind? kind,
  }) {
    final result = create();
    if (queries != null) result.queries.addAll(queries);
    if (kind != null) result.kind = kind;
    return result;
  }

  Policy._();

  factory Policy.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Policy.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Policy',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..pPM<Rule>(1, _omitFieldNames ? '' : 'queries', subBuilder: Rule.create)
    ..aE<Policy_Kind>(2, _omitFieldNames ? '' : 'kind',
        fieldType: $pb.PbFieldType.QE, enumValues: Policy_Kind.values);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Policy clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Policy copyWith(void Function(Policy) updates) =>
      super.copyWith((message) => updates(message as Policy)) as Policy;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Policy create() => Policy._();
  @$core.override
  Policy createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Policy getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Policy>(create);
  static Policy? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Rule> get queries => $_getList(0);

  @$pb.TagNumber(2)
  Policy_Kind get kind => $_getN(1);
  @$pb.TagNumber(2)
  set kind(Policy_Kind value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => $_clearField(2);
}

class AuthorizerPolicies extends $pb.GeneratedMessage {
  factory AuthorizerPolicies({
    $core.Iterable<$core.String>? symbols,
    $core.int? version,
    $core.Iterable<Fact>? facts,
    $core.Iterable<Rule>? rules,
    $core.Iterable<Check>? checks,
    $core.Iterable<Policy>? policies,
  }) {
    final result = create();
    if (symbols != null) result.symbols.addAll(symbols);
    if (version != null) result.version = version;
    if (facts != null) result.facts.addAll(facts);
    if (rules != null) result.rules.addAll(rules);
    if (checks != null) result.checks.addAll(checks);
    if (policies != null) result.policies.addAll(policies);
    return result;
  }

  AuthorizerPolicies._();

  factory AuthorizerPolicies.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuthorizerPolicies.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthorizerPolicies',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'symbols')
    ..aI(2, _omitFieldNames ? '' : 'version', fieldType: $pb.PbFieldType.OU3)
    ..pPM<Fact>(3, _omitFieldNames ? '' : 'facts', subBuilder: Fact.create)
    ..pPM<Rule>(4, _omitFieldNames ? '' : 'rules', subBuilder: Rule.create)
    ..pPM<Check>(5, _omitFieldNames ? '' : 'checks', subBuilder: Check.create)
    ..pPM<Policy>(6, _omitFieldNames ? '' : 'policies',
        subBuilder: Policy.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthorizerPolicies clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthorizerPolicies copyWith(void Function(AuthorizerPolicies) updates) =>
      super.copyWith((message) => updates(message as AuthorizerPolicies))
          as AuthorizerPolicies;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthorizerPolicies create() => AuthorizerPolicies._();
  @$core.override
  AuthorizerPolicies createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AuthorizerPolicies getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthorizerPolicies>(create);
  static AuthorizerPolicies? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get symbols => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get version => $_getIZ(1);
  @$pb.TagNumber(2)
  set version($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<Fact> get facts => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<Rule> get rules => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<Check> get checks => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<Policy> get policies => $_getList(5);
}

class ThirdPartyBlockRequest extends $pb.GeneratedMessage {
  factory ThirdPartyBlockRequest({
    PublicKey? legacyPreviousKey,
    $core.Iterable<PublicKey>? legacyPublicKeys,
    $core.List<$core.int>? previousSignature,
  }) {
    final result = create();
    if (legacyPreviousKey != null) result.legacyPreviousKey = legacyPreviousKey;
    if (legacyPublicKeys != null)
      result.legacyPublicKeys.addAll(legacyPublicKeys);
    if (previousSignature != null) result.previousSignature = previousSignature;
    return result;
  }

  ThirdPartyBlockRequest._();

  factory ThirdPartyBlockRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ThirdPartyBlockRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ThirdPartyBlockRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..aOM<PublicKey>(1, _omitFieldNames ? '' : 'legacyPreviousKey',
        protoName: 'legacyPreviousKey', subBuilder: PublicKey.create)
    ..pPM<PublicKey>(2, _omitFieldNames ? '' : 'legacyPublicKeys',
        protoName: 'legacyPublicKeys', subBuilder: PublicKey.create)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'previousSignature', $pb.PbFieldType.QY,
        protoName: 'previousSignature');

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ThirdPartyBlockRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ThirdPartyBlockRequest copyWith(
          void Function(ThirdPartyBlockRequest) updates) =>
      super.copyWith((message) => updates(message as ThirdPartyBlockRequest))
          as ThirdPartyBlockRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ThirdPartyBlockRequest create() => ThirdPartyBlockRequest._();
  @$core.override
  ThirdPartyBlockRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ThirdPartyBlockRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ThirdPartyBlockRequest>(create);
  static ThirdPartyBlockRequest? _defaultInstance;

  @$pb.TagNumber(1)
  PublicKey get legacyPreviousKey => $_getN(0);
  @$pb.TagNumber(1)
  set legacyPreviousKey(PublicKey value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLegacyPreviousKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearLegacyPreviousKey() => $_clearField(1);
  @$pb.TagNumber(1)
  PublicKey ensureLegacyPreviousKey() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<PublicKey> get legacyPublicKeys => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$core.int> get previousSignature => $_getN(2);
  @$pb.TagNumber(3)
  set previousSignature($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPreviousSignature() => $_has(2);
  @$pb.TagNumber(3)
  void clearPreviousSignature() => $_clearField(3);
}

class ThirdPartyBlockContents extends $pb.GeneratedMessage {
  factory ThirdPartyBlockContents({
    $core.List<$core.int>? payload,
    ExternalSignature? externalSignature,
  }) {
    final result = create();
    if (payload != null) result.payload = payload;
    if (externalSignature != null) result.externalSignature = externalSignature;
    return result;
  }

  ThirdPartyBlockContents._();

  factory ThirdPartyBlockContents.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ThirdPartyBlockContents.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ThirdPartyBlockContents',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.QY)
    ..aQM<ExternalSignature>(2, _omitFieldNames ? '' : 'externalSignature',
        protoName: 'externalSignature', subBuilder: ExternalSignature.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ThirdPartyBlockContents clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ThirdPartyBlockContents copyWith(
          void Function(ThirdPartyBlockContents) updates) =>
      super.copyWith((message) => updates(message as ThirdPartyBlockContents))
          as ThirdPartyBlockContents;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ThirdPartyBlockContents create() => ThirdPartyBlockContents._();
  @$core.override
  ThirdPartyBlockContents createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ThirdPartyBlockContents getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ThirdPartyBlockContents>(create);
  static ThirdPartyBlockContents? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get payload => $_getN(0);
  @$pb.TagNumber(1)
  set payload($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPayload() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayload() => $_clearField(1);

  @$pb.TagNumber(2)
  ExternalSignature get externalSignature => $_getN(1);
  @$pb.TagNumber(2)
  set externalSignature(ExternalSignature value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasExternalSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearExternalSignature() => $_clearField(2);
  @$pb.TagNumber(2)
  ExternalSignature ensureExternalSignature() => $_ensure(1);
}

class AuthorizerSnapshot extends $pb.GeneratedMessage {
  factory AuthorizerSnapshot({
    RunLimits? limits,
    $fixnum.Int64? executionTime,
    AuthorizerWorld? world,
  }) {
    final result = create();
    if (limits != null) result.limits = limits;
    if (executionTime != null) result.executionTime = executionTime;
    if (world != null) result.world = world;
    return result;
  }

  AuthorizerSnapshot._();

  factory AuthorizerSnapshot.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuthorizerSnapshot.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthorizerSnapshot',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..aQM<RunLimits>(1, _omitFieldNames ? '' : 'limits',
        subBuilder: RunLimits.create)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'executionTime', $pb.PbFieldType.QU6,
        protoName: 'executionTime', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aQM<AuthorizerWorld>(3, _omitFieldNames ? '' : 'world',
        subBuilder: AuthorizerWorld.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthorizerSnapshot clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthorizerSnapshot copyWith(void Function(AuthorizerSnapshot) updates) =>
      super.copyWith((message) => updates(message as AuthorizerSnapshot))
          as AuthorizerSnapshot;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthorizerSnapshot create() => AuthorizerSnapshot._();
  @$core.override
  AuthorizerSnapshot createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AuthorizerSnapshot getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthorizerSnapshot>(create);
  static AuthorizerSnapshot? _defaultInstance;

  @$pb.TagNumber(1)
  RunLimits get limits => $_getN(0);
  @$pb.TagNumber(1)
  set limits(RunLimits value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLimits() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimits() => $_clearField(1);
  @$pb.TagNumber(1)
  RunLimits ensureLimits() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get executionTime => $_getI64(1);
  @$pb.TagNumber(2)
  set executionTime($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExecutionTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearExecutionTime() => $_clearField(2);

  @$pb.TagNumber(3)
  AuthorizerWorld get world => $_getN(2);
  @$pb.TagNumber(3)
  set world(AuthorizerWorld value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasWorld() => $_has(2);
  @$pb.TagNumber(3)
  void clearWorld() => $_clearField(3);
  @$pb.TagNumber(3)
  AuthorizerWorld ensureWorld() => $_ensure(2);
}

class RunLimits extends $pb.GeneratedMessage {
  factory RunLimits({
    $fixnum.Int64? maxFacts,
    $fixnum.Int64? maxIterations,
    $fixnum.Int64? maxTime,
  }) {
    final result = create();
    if (maxFacts != null) result.maxFacts = maxFacts;
    if (maxIterations != null) result.maxIterations = maxIterations;
    if (maxTime != null) result.maxTime = maxTime;
    return result;
  }

  RunLimits._();

  factory RunLimits.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RunLimits.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RunLimits',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'maxFacts', $pb.PbFieldType.QU6,
        protoName: 'maxFacts', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'maxIterations', $pb.PbFieldType.QU6,
        protoName: 'maxIterations', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'maxTime', $pb.PbFieldType.QU6,
        protoName: 'maxTime', defaultOrMaker: $fixnum.Int64.ZERO);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RunLimits clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RunLimits copyWith(void Function(RunLimits) updates) =>
      super.copyWith((message) => updates(message as RunLimits)) as RunLimits;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RunLimits create() => RunLimits._();
  @$core.override
  RunLimits createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RunLimits getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RunLimits>(create);
  static RunLimits? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get maxFacts => $_getI64(0);
  @$pb.TagNumber(1)
  set maxFacts($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMaxFacts() => $_has(0);
  @$pb.TagNumber(1)
  void clearMaxFacts() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get maxIterations => $_getI64(1);
  @$pb.TagNumber(2)
  set maxIterations($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMaxIterations() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxIterations() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get maxTime => $_getI64(2);
  @$pb.TagNumber(3)
  set maxTime($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMaxTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaxTime() => $_clearField(3);
}

class AuthorizerWorld extends $pb.GeneratedMessage {
  factory AuthorizerWorld({
    $core.int? version,
    $core.Iterable<$core.String>? symbols,
    $core.Iterable<PublicKey>? publicKeys,
    $core.Iterable<SnapshotBlock>? blocks,
    SnapshotBlock? authorizerBlock,
    $core.Iterable<Policy>? authorizerPolicies,
    $core.Iterable<GeneratedFacts>? generatedFacts,
    $fixnum.Int64? iterations,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (symbols != null) result.symbols.addAll(symbols);
    if (publicKeys != null) result.publicKeys.addAll(publicKeys);
    if (blocks != null) result.blocks.addAll(blocks);
    if (authorizerBlock != null) result.authorizerBlock = authorizerBlock;
    if (authorizerPolicies != null)
      result.authorizerPolicies.addAll(authorizerPolicies);
    if (generatedFacts != null) result.generatedFacts.addAll(generatedFacts);
    if (iterations != null) result.iterations = iterations;
    return result;
  }

  AuthorizerWorld._();

  factory AuthorizerWorld.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuthorizerWorld.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthorizerWorld',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'version', fieldType: $pb.PbFieldType.OU3)
    ..pPS(2, _omitFieldNames ? '' : 'symbols')
    ..pPM<PublicKey>(3, _omitFieldNames ? '' : 'publicKeys',
        protoName: 'publicKeys', subBuilder: PublicKey.create)
    ..pPM<SnapshotBlock>(4, _omitFieldNames ? '' : 'blocks',
        subBuilder: SnapshotBlock.create)
    ..aQM<SnapshotBlock>(5, _omitFieldNames ? '' : 'authorizerBlock',
        protoName: 'authorizerBlock', subBuilder: SnapshotBlock.create)
    ..pPM<Policy>(6, _omitFieldNames ? '' : 'authorizerPolicies',
        protoName: 'authorizerPolicies', subBuilder: Policy.create)
    ..pPM<GeneratedFacts>(7, _omitFieldNames ? '' : 'generatedFacts',
        protoName: 'generatedFacts', subBuilder: GeneratedFacts.create)
    ..a<$fixnum.Int64>(
        8, _omitFieldNames ? '' : 'iterations', $pb.PbFieldType.QU6,
        defaultOrMaker: $fixnum.Int64.ZERO);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthorizerWorld clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthorizerWorld copyWith(void Function(AuthorizerWorld) updates) =>
      super.copyWith((message) => updates(message as AuthorizerWorld))
          as AuthorizerWorld;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthorizerWorld create() => AuthorizerWorld._();
  @$core.override
  AuthorizerWorld createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AuthorizerWorld getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthorizerWorld>(create);
  static AuthorizerWorld? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get version => $_getIZ(0);
  @$pb.TagNumber(1)
  set version($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get symbols => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<PublicKey> get publicKeys => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<SnapshotBlock> get blocks => $_getList(3);

  @$pb.TagNumber(5)
  SnapshotBlock get authorizerBlock => $_getN(4);
  @$pb.TagNumber(5)
  set authorizerBlock(SnapshotBlock value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasAuthorizerBlock() => $_has(4);
  @$pb.TagNumber(5)
  void clearAuthorizerBlock() => $_clearField(5);
  @$pb.TagNumber(5)
  SnapshotBlock ensureAuthorizerBlock() => $_ensure(4);

  @$pb.TagNumber(6)
  $pb.PbList<Policy> get authorizerPolicies => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<GeneratedFacts> get generatedFacts => $_getList(6);

  @$pb.TagNumber(8)
  $fixnum.Int64 get iterations => $_getI64(7);
  @$pb.TagNumber(8)
  set iterations($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasIterations() => $_has(7);
  @$pb.TagNumber(8)
  void clearIterations() => $_clearField(8);
}

enum Origin_Content { authorizer, origin, notSet }

class Origin extends $pb.GeneratedMessage {
  factory Origin({
    Empty? authorizer,
    $core.int? origin,
  }) {
    final result = create();
    if (authorizer != null) result.authorizer = authorizer;
    if (origin != null) result.origin = origin;
    return result;
  }

  Origin._();

  factory Origin.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Origin.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Origin_Content> _Origin_ContentByTag = {
    1: Origin_Content.authorizer,
    2: Origin_Content.origin,
    0: Origin_Content.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Origin',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<Empty>(1, _omitFieldNames ? '' : 'authorizer',
        subBuilder: Empty.create)
    ..aI(2, _omitFieldNames ? '' : 'origin', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Origin clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Origin copyWith(void Function(Origin) updates) =>
      super.copyWith((message) => updates(message as Origin)) as Origin;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Origin create() => Origin._();
  @$core.override
  Origin createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Origin getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Origin>(create);
  static Origin? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  Origin_Content whichContent() => _Origin_ContentByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearContent() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Empty get authorizer => $_getN(0);
  @$pb.TagNumber(1)
  set authorizer(Empty value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAuthorizer() => $_has(0);
  @$pb.TagNumber(1)
  void clearAuthorizer() => $_clearField(1);
  @$pb.TagNumber(1)
  Empty ensureAuthorizer() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get origin => $_getIZ(1);
  @$pb.TagNumber(2)
  set origin($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOrigin() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrigin() => $_clearField(2);
}

class Empty extends $pb.GeneratedMessage {
  factory Empty() => create();

  Empty._();

  factory Empty.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Empty.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Empty',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Empty clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Empty copyWith(void Function(Empty) updates) =>
      super.copyWith((message) => updates(message as Empty)) as Empty;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  @$core.override
  Empty createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty? _defaultInstance;
}

class GeneratedFacts extends $pb.GeneratedMessage {
  factory GeneratedFacts({
    $core.Iterable<Origin>? origins,
    $core.Iterable<Fact>? facts,
  }) {
    final result = create();
    if (origins != null) result.origins.addAll(origins);
    if (facts != null) result.facts.addAll(facts);
    return result;
  }

  GeneratedFacts._();

  factory GeneratedFacts.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GeneratedFacts.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GeneratedFacts',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..pPM<Origin>(1, _omitFieldNames ? '' : 'origins',
        subBuilder: Origin.create)
    ..pPM<Fact>(2, _omitFieldNames ? '' : 'facts', subBuilder: Fact.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GeneratedFacts clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GeneratedFacts copyWith(void Function(GeneratedFacts) updates) =>
      super.copyWith((message) => updates(message as GeneratedFacts))
          as GeneratedFacts;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GeneratedFacts create() => GeneratedFacts._();
  @$core.override
  GeneratedFacts createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GeneratedFacts getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GeneratedFacts>(create);
  static GeneratedFacts? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Origin> get origins => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<Fact> get facts => $_getList(1);
}

class SnapshotBlock extends $pb.GeneratedMessage {
  factory SnapshotBlock({
    $core.String? context,
    $core.int? version,
    $core.Iterable<Fact>? facts,
    $core.Iterable<Rule>? rules,
    $core.Iterable<Check>? checks,
    $core.Iterable<Scope>? scope,
    PublicKey? externalKey,
  }) {
    final result = create();
    if (context != null) result.context = context;
    if (version != null) result.version = version;
    if (facts != null) result.facts.addAll(facts);
    if (rules != null) result.rules.addAll(rules);
    if (checks != null) result.checks.addAll(checks);
    if (scope != null) result.scope.addAll(scope);
    if (externalKey != null) result.externalKey = externalKey;
    return result;
  }

  SnapshotBlock._();

  factory SnapshotBlock.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SnapshotBlock.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SnapshotBlock',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'biscuit.format.schema'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'context')
    ..aI(2, _omitFieldNames ? '' : 'version', fieldType: $pb.PbFieldType.OU3)
    ..pPM<Fact>(3, _omitFieldNames ? '' : 'facts', subBuilder: Fact.create)
    ..pPM<Rule>(4, _omitFieldNames ? '' : 'rules', subBuilder: Rule.create)
    ..pPM<Check>(5, _omitFieldNames ? '' : 'checks', subBuilder: Check.create)
    ..pPM<Scope>(6, _omitFieldNames ? '' : 'scope', subBuilder: Scope.create)
    ..aOM<PublicKey>(7, _omitFieldNames ? '' : 'externalKey',
        protoName: 'externalKey', subBuilder: PublicKey.create);

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SnapshotBlock clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SnapshotBlock copyWith(void Function(SnapshotBlock) updates) =>
      super.copyWith((message) => updates(message as SnapshotBlock))
          as SnapshotBlock;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SnapshotBlock create() => SnapshotBlock._();
  @$core.override
  SnapshotBlock createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SnapshotBlock getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SnapshotBlock>(create);
  static SnapshotBlock? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get context => $_getSZ(0);
  @$pb.TagNumber(1)
  set context($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContext() => $_has(0);
  @$pb.TagNumber(1)
  void clearContext() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get version => $_getIZ(1);
  @$pb.TagNumber(2)
  set version($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<Fact> get facts => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<Rule> get rules => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<Check> get checks => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<Scope> get scope => $_getList(5);

  @$pb.TagNumber(7)
  PublicKey get externalKey => $_getN(6);
  @$pb.TagNumber(7)
  set externalKey(PublicKey value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasExternalKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearExternalKey() => $_clearField(7);
  @$pb.TagNumber(7)
  PublicKey ensureExternalKey() => $_ensure(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
