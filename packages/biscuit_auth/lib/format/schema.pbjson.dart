// This is a generated file - do not edit.
//
// Generated from schema.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use biscuitDescriptor instead')
const Biscuit$json = {
  '1': 'Biscuit',
  '2': [
    {'1': 'rootKeyId', '3': 1, '4': 1, '5': 13, '10': 'rootKeyId'},
    {
      '1': 'authority',
      '3': 2,
      '4': 2,
      '5': 11,
      '6': '.biscuit.format.schema.SignedBlock',
      '10': 'authority'
    },
    {
      '1': 'blocks',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.SignedBlock',
      '10': 'blocks'
    },
    {
      '1': 'proof',
      '3': 4,
      '4': 2,
      '5': 11,
      '6': '.biscuit.format.schema.Proof',
      '10': 'proof'
    },
  ],
};

/// Descriptor for `Biscuit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List biscuitDescriptor = $convert.base64Decode(
    'CgdCaXNjdWl0EhwKCXJvb3RLZXlJZBgBIAEoDVIJcm9vdEtleUlkEkAKCWF1dGhvcml0eRgCIA'
    'IoCzIiLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5TaWduZWRCbG9ja1IJYXV0aG9yaXR5EjoKBmJs'
    'b2NrcxgDIAMoCzIiLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5TaWduZWRCbG9ja1IGYmxvY2tzEj'
    'IKBXByb29mGAQgAigLMhwuYmlzY3VpdC5mb3JtYXQuc2NoZW1hLlByb29mUgVwcm9vZg==');

@$core.Deprecated('Use signedBlockDescriptor instead')
const SignedBlock$json = {
  '1': 'SignedBlock',
  '2': [
    {'1': 'block', '3': 1, '4': 2, '5': 12, '10': 'block'},
    {
      '1': 'nextKey',
      '3': 2,
      '4': 2,
      '5': 11,
      '6': '.biscuit.format.schema.PublicKey',
      '10': 'nextKey'
    },
    {'1': 'signature', '3': 3, '4': 2, '5': 12, '10': 'signature'},
    {
      '1': 'externalSignature',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.biscuit.format.schema.ExternalSignature',
      '10': 'externalSignature'
    },
    {'1': 'version', '3': 5, '4': 1, '5': 13, '10': 'version'},
  ],
};

/// Descriptor for `SignedBlock`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signedBlockDescriptor = $convert.base64Decode(
    'CgtTaWduZWRCbG9jaxIUCgVibG9jaxgBIAIoDFIFYmxvY2sSOgoHbmV4dEtleRgCIAIoCzIgLm'
    'Jpc2N1aXQuZm9ybWF0LnNjaGVtYS5QdWJsaWNLZXlSB25leHRLZXkSHAoJc2lnbmF0dXJlGAMg'
    'AigMUglzaWduYXR1cmUSVgoRZXh0ZXJuYWxTaWduYXR1cmUYBCABKAsyKC5iaXNjdWl0LmZvcm'
    '1hdC5zY2hlbWEuRXh0ZXJuYWxTaWduYXR1cmVSEWV4dGVybmFsU2lnbmF0dXJlEhgKB3ZlcnNp'
    'b24YBSABKA1SB3ZlcnNpb24=');

@$core.Deprecated('Use externalSignatureDescriptor instead')
const ExternalSignature$json = {
  '1': 'ExternalSignature',
  '2': [
    {'1': 'signature', '3': 1, '4': 2, '5': 12, '10': 'signature'},
    {
      '1': 'publicKey',
      '3': 2,
      '4': 2,
      '5': 11,
      '6': '.biscuit.format.schema.PublicKey',
      '10': 'publicKey'
    },
  ],
};

/// Descriptor for `ExternalSignature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List externalSignatureDescriptor = $convert.base64Decode(
    'ChFFeHRlcm5hbFNpZ25hdHVyZRIcCglzaWduYXR1cmUYASACKAxSCXNpZ25hdHVyZRI+CglwdW'
    'JsaWNLZXkYAiACKAsyIC5iaXNjdWl0LmZvcm1hdC5zY2hlbWEuUHVibGljS2V5UglwdWJsaWNL'
    'ZXk=');

@$core.Deprecated('Use publicKeyDescriptor instead')
const PublicKey$json = {
  '1': 'PublicKey',
  '2': [
    {
      '1': 'algorithm',
      '3': 1,
      '4': 2,
      '5': 14,
      '6': '.biscuit.format.schema.PublicKey.Algorithm',
      '10': 'algorithm'
    },
    {'1': 'key', '3': 2, '4': 2, '5': 12, '10': 'key'},
  ],
  '4': [PublicKey_Algorithm$json],
};

@$core.Deprecated('Use publicKeyDescriptor instead')
const PublicKey_Algorithm$json = {
  '1': 'Algorithm',
  '2': [
    {'1': 'Ed25519', '2': 0},
    {'1': 'SECP256R1', '2': 1},
  ],
};

/// Descriptor for `PublicKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicKeyDescriptor = $convert.base64Decode(
    'CglQdWJsaWNLZXkSSAoJYWxnb3JpdGhtGAEgAigOMiouYmlzY3VpdC5mb3JtYXQuc2NoZW1hLl'
    'B1YmxpY0tleS5BbGdvcml0aG1SCWFsZ29yaXRobRIQCgNrZXkYAiACKAxSA2tleSInCglBbGdv'
    'cml0aG0SCwoHRWQyNTUxORAAEg0KCVNFQ1AyNTZSMRAB');

@$core.Deprecated('Use proofDescriptor instead')
const Proof$json = {
  '1': 'Proof',
  '2': [
    {'1': 'nextSecret', '3': 1, '4': 1, '5': 12, '9': 0, '10': 'nextSecret'},
    {
      '1': 'finalSignature',
      '3': 2,
      '4': 1,
      '5': 12,
      '9': 0,
      '10': 'finalSignature'
    },
  ],
  '8': [
    {'1': 'Content'},
  ],
};

/// Descriptor for `Proof`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List proofDescriptor = $convert.base64Decode(
    'CgVQcm9vZhIgCgpuZXh0U2VjcmV0GAEgASgMSABSCm5leHRTZWNyZXQSKAoOZmluYWxTaWduYX'
    'R1cmUYAiABKAxIAFIOZmluYWxTaWduYXR1cmVCCQoHQ29udGVudA==');

@$core.Deprecated('Use blockDescriptor instead')
const Block$json = {
  '1': 'Block',
  '2': [
    {'1': 'symbols', '3': 1, '4': 3, '5': 9, '10': 'symbols'},
    {'1': 'context', '3': 2, '4': 1, '5': 9, '10': 'context'},
    {'1': 'version', '3': 3, '4': 1, '5': 13, '10': 'version'},
    {
      '1': 'facts',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Fact',
      '10': 'facts'
    },
    {
      '1': 'rules',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Rule',
      '10': 'rules'
    },
    {
      '1': 'checks',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Check',
      '10': 'checks'
    },
    {
      '1': 'scope',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Scope',
      '10': 'scope'
    },
    {
      '1': 'publicKeys',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.PublicKey',
      '10': 'publicKeys'
    },
  ],
};

/// Descriptor for `Block`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockDescriptor = $convert.base64Decode(
    'CgVCbG9jaxIYCgdzeW1ib2xzGAEgAygJUgdzeW1ib2xzEhgKB2NvbnRleHQYAiABKAlSB2Nvbn'
    'RleHQSGAoHdmVyc2lvbhgDIAEoDVIHdmVyc2lvbhIxCgVmYWN0cxgEIAMoCzIbLmJpc2N1aXQu'
    'Zm9ybWF0LnNjaGVtYS5GYWN0UgVmYWN0cxIxCgVydWxlcxgFIAMoCzIbLmJpc2N1aXQuZm9ybW'
    'F0LnNjaGVtYS5SdWxlUgVydWxlcxI0CgZjaGVja3MYBiADKAsyHC5iaXNjdWl0LmZvcm1hdC5z'
    'Y2hlbWEuQ2hlY2tSBmNoZWNrcxIyCgVzY29wZRgHIAMoCzIcLmJpc2N1aXQuZm9ybWF0LnNjaG'
    'VtYS5TY29wZVIFc2NvcGUSQAoKcHVibGljS2V5cxgIIAMoCzIgLmJpc2N1aXQuZm9ybWF0LnNj'
    'aGVtYS5QdWJsaWNLZXlSCnB1YmxpY0tleXM=');

@$core.Deprecated('Use scopeDescriptor instead')
const Scope$json = {
  '1': 'Scope',
  '2': [
    {
      '1': 'scopeType',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.biscuit.format.schema.Scope.ScopeType',
      '9': 0,
      '10': 'scopeType'
    },
    {'1': 'publicKey', '3': 2, '4': 1, '5': 3, '9': 0, '10': 'publicKey'},
  ],
  '4': [Scope_ScopeType$json],
  '8': [
    {'1': 'Content'},
  ],
};

@$core.Deprecated('Use scopeDescriptor instead')
const Scope_ScopeType$json = {
  '1': 'ScopeType',
  '2': [
    {'1': 'Authority', '2': 0},
    {'1': 'Previous', '2': 1},
  ],
};

/// Descriptor for `Scope`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scopeDescriptor = $convert.base64Decode(
    'CgVTY29wZRJGCglzY29wZVR5cGUYASABKA4yJi5iaXNjdWl0LmZvcm1hdC5zY2hlbWEuU2NvcG'
    'UuU2NvcGVUeXBlSABSCXNjb3BlVHlwZRIeCglwdWJsaWNLZXkYAiABKANIAFIJcHVibGljS2V5'
    'IigKCVNjb3BlVHlwZRINCglBdXRob3JpdHkQABIMCghQcmV2aW91cxABQgkKB0NvbnRlbnQ=');

@$core.Deprecated('Use factDescriptor instead')
const Fact$json = {
  '1': 'Fact',
  '2': [
    {
      '1': 'predicate',
      '3': 1,
      '4': 2,
      '5': 11,
      '6': '.biscuit.format.schema.Predicate',
      '10': 'predicate'
    },
  ],
};

/// Descriptor for `Fact`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List factDescriptor = $convert.base64Decode(
    'CgRGYWN0Ej4KCXByZWRpY2F0ZRgBIAIoCzIgLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5QcmVkaW'
    'NhdGVSCXByZWRpY2F0ZQ==');

@$core.Deprecated('Use ruleDescriptor instead')
const Rule$json = {
  '1': 'Rule',
  '2': [
    {
      '1': 'head',
      '3': 1,
      '4': 2,
      '5': 11,
      '6': '.biscuit.format.schema.Predicate',
      '10': 'head'
    },
    {
      '1': 'body',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Predicate',
      '10': 'body'
    },
    {
      '1': 'expressions',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Expression',
      '10': 'expressions'
    },
    {
      '1': 'scope',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Scope',
      '10': 'scope'
    },
  ],
};

/// Descriptor for `Rule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ruleDescriptor = $convert.base64Decode(
    'CgRSdWxlEjQKBGhlYWQYASACKAsyIC5iaXNjdWl0LmZvcm1hdC5zY2hlbWEuUHJlZGljYXRlUg'
    'RoZWFkEjQKBGJvZHkYAiADKAsyIC5iaXNjdWl0LmZvcm1hdC5zY2hlbWEuUHJlZGljYXRlUgRi'
    'b2R5EkMKC2V4cHJlc3Npb25zGAMgAygLMiEuYmlzY3VpdC5mb3JtYXQuc2NoZW1hLkV4cHJlc3'
    'Npb25SC2V4cHJlc3Npb25zEjIKBXNjb3BlGAQgAygLMhwuYmlzY3VpdC5mb3JtYXQuc2NoZW1h'
    'LlNjb3BlUgVzY29wZQ==');

@$core.Deprecated('Use checkDescriptor instead')
const Check$json = {
  '1': 'Check',
  '2': [
    {
      '1': 'queries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Rule',
      '10': 'queries'
    },
    {
      '1': 'kind',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.biscuit.format.schema.Check.Kind',
      '10': 'kind'
    },
  ],
  '4': [Check_Kind$json],
};

@$core.Deprecated('Use checkDescriptor instead')
const Check_Kind$json = {
  '1': 'Kind',
  '2': [
    {'1': 'One', '2': 0},
    {'1': 'All', '2': 1},
    {'1': 'Reject', '2': 2},
  ],
};

/// Descriptor for `Check`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkDescriptor = $convert.base64Decode(
    'CgVDaGVjaxI1CgdxdWVyaWVzGAEgAygLMhsuYmlzY3VpdC5mb3JtYXQuc2NoZW1hLlJ1bGVSB3'
    'F1ZXJpZXMSNQoEa2luZBgCIAEoDjIhLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5DaGVjay5LaW5k'
    'UgRraW5kIiQKBEtpbmQSBwoDT25lEAASBwoDQWxsEAESCgoGUmVqZWN0EAI=');

@$core.Deprecated('Use predicateDescriptor instead')
const Predicate$json = {
  '1': 'Predicate',
  '2': [
    {'1': 'name', '3': 1, '4': 2, '5': 4, '10': 'name'},
    {
      '1': 'terms',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Term',
      '10': 'terms'
    },
  ],
};

/// Descriptor for `Predicate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List predicateDescriptor = $convert.base64Decode(
    'CglQcmVkaWNhdGUSEgoEbmFtZRgBIAIoBFIEbmFtZRIxCgV0ZXJtcxgCIAMoCzIbLmJpc2N1aX'
    'QuZm9ybWF0LnNjaGVtYS5UZXJtUgV0ZXJtcw==');

@$core.Deprecated('Use termDescriptor instead')
const Term$json = {
  '1': 'Term',
  '2': [
    {'1': 'variable', '3': 1, '4': 1, '5': 13, '9': 0, '10': 'variable'},
    {'1': 'integer', '3': 2, '4': 1, '5': 3, '9': 0, '10': 'integer'},
    {'1': 'string', '3': 3, '4': 1, '5': 4, '9': 0, '10': 'string'},
    {'1': 'date', '3': 4, '4': 1, '5': 4, '9': 0, '10': 'date'},
    {'1': 'bytes', '3': 5, '4': 1, '5': 12, '9': 0, '10': 'bytes'},
    {'1': 'bool', '3': 6, '4': 1, '5': 8, '9': 0, '10': 'bool'},
    {
      '1': 'set',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.biscuit.format.schema.TermSet',
      '9': 0,
      '10': 'set'
    },
    {
      '1': 'null',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.biscuit.format.schema.Empty',
      '9': 0,
      '10': 'null'
    },
    {
      '1': 'array',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.biscuit.format.schema.Array',
      '9': 0,
      '10': 'array'
    },
    {
      '1': 'map',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.biscuit.format.schema.Map',
      '9': 0,
      '10': 'map'
    },
  ],
  '8': [
    {'1': 'Content'},
  ],
};

/// Descriptor for `Term`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List termDescriptor = $convert.base64Decode(
    'CgRUZXJtEhwKCHZhcmlhYmxlGAEgASgNSABSCHZhcmlhYmxlEhoKB2ludGVnZXIYAiABKANIAF'
    'IHaW50ZWdlchIYCgZzdHJpbmcYAyABKARIAFIGc3RyaW5nEhQKBGRhdGUYBCABKARIAFIEZGF0'
    'ZRIWCgVieXRlcxgFIAEoDEgAUgVieXRlcxIUCgRib29sGAYgASgISABSBGJvb2wSMgoDc2V0GA'
    'cgASgLMh4uYmlzY3VpdC5mb3JtYXQuc2NoZW1hLlRlcm1TZXRIAFIDc2V0EjIKBG51bGwYCCAB'
    'KAsyHC5iaXNjdWl0LmZvcm1hdC5zY2hlbWEuRW1wdHlIAFIEbnVsbBI0CgVhcnJheRgJIAEoCz'
    'IcLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5BcnJheUgAUgVhcnJheRIuCgNtYXAYCiABKAsyGi5i'
    'aXNjdWl0LmZvcm1hdC5zY2hlbWEuTWFwSABSA21hcEIJCgdDb250ZW50');

@$core.Deprecated('Use termSetDescriptor instead')
const TermSet$json = {
  '1': 'TermSet',
  '2': [
    {
      '1': 'set',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Term',
      '10': 'set'
    },
  ],
};

/// Descriptor for `TermSet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List termSetDescriptor = $convert.base64Decode(
    'CgdUZXJtU2V0Ei0KA3NldBgBIAMoCzIbLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5UZXJtUgNzZX'
    'Q=');

@$core.Deprecated('Use arrayDescriptor instead')
const Array$json = {
  '1': 'Array',
  '2': [
    {
      '1': 'array',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Term',
      '10': 'array'
    },
  ],
};

/// Descriptor for `Array`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List arrayDescriptor = $convert.base64Decode(
    'CgVBcnJheRIxCgVhcnJheRgBIAMoCzIbLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5UZXJtUgVhcn'
    'JheQ==');

@$core.Deprecated('Use map_Descriptor instead')
const Map_$json = {
  '1': 'Map',
  '2': [
    {
      '1': 'entries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.MapEntry',
      '10': 'entries'
    },
  ],
};

/// Descriptor for `Map`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List map_Descriptor = $convert.base64Decode(
    'CgNNYXASOQoHZW50cmllcxgBIAMoCzIfLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5NYXBFbnRyeV'
    'IHZW50cmllcw==');

@$core.Deprecated('Use mapEntryDescriptor instead')
const MapEntry$json = {
  '1': 'MapEntry',
  '2': [
    {
      '1': 'key',
      '3': 1,
      '4': 2,
      '5': 11,
      '6': '.biscuit.format.schema.MapKey',
      '10': 'key'
    },
    {
      '1': 'value',
      '3': 2,
      '4': 2,
      '5': 11,
      '6': '.biscuit.format.schema.Term',
      '10': 'value'
    },
  ],
};

/// Descriptor for `MapEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mapEntryDescriptor = $convert.base64Decode(
    'CghNYXBFbnRyeRIvCgNrZXkYASACKAsyHS5iaXNjdWl0LmZvcm1hdC5zY2hlbWEuTWFwS2V5Ug'
    'NrZXkSMQoFdmFsdWUYAiACKAsyGy5iaXNjdWl0LmZvcm1hdC5zY2hlbWEuVGVybVIFdmFsdWU=');

@$core.Deprecated('Use mapKeyDescriptor instead')
const MapKey$json = {
  '1': 'MapKey',
  '2': [
    {'1': 'integer', '3': 1, '4': 1, '5': 3, '9': 0, '10': 'integer'},
    {'1': 'string', '3': 2, '4': 1, '5': 4, '9': 0, '10': 'string'},
  ],
  '8': [
    {'1': 'Content'},
  ],
};

/// Descriptor for `MapKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mapKeyDescriptor = $convert.base64Decode(
    'CgZNYXBLZXkSGgoHaW50ZWdlchgBIAEoA0gAUgdpbnRlZ2VyEhgKBnN0cmluZxgCIAEoBEgAUg'
    'ZzdHJpbmdCCQoHQ29udGVudA==');

@$core.Deprecated('Use expressionDescriptor instead')
const Expression$json = {
  '1': 'Expression',
  '2': [
    {
      '1': 'ops',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Op',
      '10': 'ops'
    },
  ],
};

/// Descriptor for `Expression`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List expressionDescriptor = $convert.base64Decode(
    'CgpFeHByZXNzaW9uEisKA29wcxgBIAMoCzIZLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5PcFIDb3'
    'Bz');

@$core.Deprecated('Use opDescriptor instead')
const Op$json = {
  '1': 'Op',
  '2': [
    {
      '1': 'value',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.biscuit.format.schema.Term',
      '9': 0,
      '10': 'value'
    },
    {
      '1': 'unary',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.biscuit.format.schema.OpUnary',
      '9': 0,
      '10': 'unary'
    },
    {
      '1': 'Binary',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.biscuit.format.schema.OpBinary',
      '9': 0,
      '10': 'Binary'
    },
    {
      '1': 'closure',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.biscuit.format.schema.OpClosure',
      '9': 0,
      '10': 'closure'
    },
  ],
  '8': [
    {'1': 'Content'},
  ],
};

/// Descriptor for `Op`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List opDescriptor = $convert.base64Decode(
    'CgJPcBIzCgV2YWx1ZRgBIAEoCzIbLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5UZXJtSABSBXZhbH'
    'VlEjYKBXVuYXJ5GAIgASgLMh4uYmlzY3VpdC5mb3JtYXQuc2NoZW1hLk9wVW5hcnlIAFIFdW5h'
    'cnkSOQoGQmluYXJ5GAMgASgLMh8uYmlzY3VpdC5mb3JtYXQuc2NoZW1hLk9wQmluYXJ5SABSBk'
    'JpbmFyeRI8CgdjbG9zdXJlGAQgASgLMiAuYmlzY3VpdC5mb3JtYXQuc2NoZW1hLk9wQ2xvc3Vy'
    'ZUgAUgdjbG9zdXJlQgkKB0NvbnRlbnQ=');

@$core.Deprecated('Use opUnaryDescriptor instead')
const OpUnary$json = {
  '1': 'OpUnary',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 2,
      '5': 14,
      '6': '.biscuit.format.schema.OpUnary.Kind',
      '10': 'kind'
    },
    {'1': 'ffiName', '3': 2, '4': 1, '5': 4, '10': 'ffiName'},
  ],
  '4': [OpUnary_Kind$json],
};

@$core.Deprecated('Use opUnaryDescriptor instead')
const OpUnary_Kind$json = {
  '1': 'Kind',
  '2': [
    {'1': 'Negate', '2': 0},
    {'1': 'Parens', '2': 1},
    {'1': 'Length', '2': 2},
    {'1': 'TypeOf', '2': 3},
    {'1': 'Ffi', '2': 4},
  ],
};

/// Descriptor for `OpUnary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List opUnaryDescriptor = $convert.base64Decode(
    'CgdPcFVuYXJ5EjcKBGtpbmQYASACKA4yIy5iaXNjdWl0LmZvcm1hdC5zY2hlbWEuT3BVbmFyeS'
    '5LaW5kUgRraW5kEhgKB2ZmaU5hbWUYAiABKARSB2ZmaU5hbWUiPwoES2luZBIKCgZOZWdhdGUQ'
    'ABIKCgZQYXJlbnMQARIKCgZMZW5ndGgQAhIKCgZUeXBlT2YQAxIHCgNGZmkQBA==');

@$core.Deprecated('Use opBinaryDescriptor instead')
const OpBinary$json = {
  '1': 'OpBinary',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 2,
      '5': 14,
      '6': '.biscuit.format.schema.OpBinary.Kind',
      '10': 'kind'
    },
    {'1': 'ffiName', '3': 2, '4': 1, '5': 4, '10': 'ffiName'},
  ],
  '4': [OpBinary_Kind$json],
};

@$core.Deprecated('Use opBinaryDescriptor instead')
const OpBinary_Kind$json = {
  '1': 'Kind',
  '2': [
    {'1': 'LessThan', '2': 0},
    {'1': 'GreaterThan', '2': 1},
    {'1': 'LessOrEqual', '2': 2},
    {'1': 'GreaterOrEqual', '2': 3},
    {'1': 'Equal', '2': 4},
    {'1': 'Contains', '2': 5},
    {'1': 'Prefix', '2': 6},
    {'1': 'Suffix', '2': 7},
    {'1': 'Regex', '2': 8},
    {'1': 'Add', '2': 9},
    {'1': 'Sub', '2': 10},
    {'1': 'Mul', '2': 11},
    {'1': 'Div', '2': 12},
    {'1': 'And', '2': 13},
    {'1': 'Or', '2': 14},
    {'1': 'Intersection', '2': 15},
    {'1': 'Union', '2': 16},
    {'1': 'BitwiseAnd', '2': 17},
    {'1': 'BitwiseOr', '2': 18},
    {'1': 'BitwiseXor', '2': 19},
    {'1': 'NotEqual', '2': 20},
    {'1': 'HeterogeneousEqual', '2': 21},
    {'1': 'HeterogeneousNotEqual', '2': 22},
    {'1': 'LazyAnd', '2': 23},
    {'1': 'LazyOr', '2': 24},
    {'1': 'All', '2': 25},
    {'1': 'Any', '2': 26},
    {'1': 'Get', '2': 27},
    {'1': 'Ffi', '2': 28},
    {'1': 'TryOr', '2': 29},
  ],
};

/// Descriptor for `OpBinary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List opBinaryDescriptor = $convert.base64Decode(
    'CghPcEJpbmFyeRI4CgRraW5kGAEgAigOMiQuYmlzY3VpdC5mb3JtYXQuc2NoZW1hLk9wQmluYX'
    'J5LktpbmRSBGtpbmQSGAoHZmZpTmFtZRgCIAEoBFIHZmZpTmFtZSKQAwoES2luZBIMCghMZXNz'
    'VGhhbhAAEg8KC0dyZWF0ZXJUaGFuEAESDwoLTGVzc09yRXF1YWwQAhISCg5HcmVhdGVyT3JFcX'
    'VhbBADEgkKBUVxdWFsEAQSDAoIQ29udGFpbnMQBRIKCgZQcmVmaXgQBhIKCgZTdWZmaXgQBxIJ'
    'CgVSZWdleBAIEgcKA0FkZBAJEgcKA1N1YhAKEgcKA011bBALEgcKA0RpdhAMEgcKA0FuZBANEg'
    'YKAk9yEA4SEAoMSW50ZXJzZWN0aW9uEA8SCQoFVW5pb24QEBIOCgpCaXR3aXNlQW5kEBESDQoJ'
    'Qml0d2lzZU9yEBISDgoKQml0d2lzZVhvchATEgwKCE5vdEVxdWFsEBQSFgoSSGV0ZXJvZ2VuZW'
    '91c0VxdWFsEBUSGQoVSGV0ZXJvZ2VuZW91c05vdEVxdWFsEBYSCwoHTGF6eUFuZBAXEgoKBkxh'
    'enlPchAYEgcKA0FsbBAZEgcKA0FueRAaEgcKA0dldBAbEgcKA0ZmaRAcEgkKBVRyeU9yEB0=');

@$core.Deprecated('Use opClosureDescriptor instead')
const OpClosure$json = {
  '1': 'OpClosure',
  '2': [
    {'1': 'params', '3': 1, '4': 3, '5': 13, '10': 'params'},
    {
      '1': 'ops',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Op',
      '10': 'ops'
    },
  ],
};

/// Descriptor for `OpClosure`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List opClosureDescriptor = $convert.base64Decode(
    'CglPcENsb3N1cmUSFgoGcGFyYW1zGAEgAygNUgZwYXJhbXMSKwoDb3BzGAIgAygLMhkuYmlzY3'
    'VpdC5mb3JtYXQuc2NoZW1hLk9wUgNvcHM=');

@$core.Deprecated('Use policyDescriptor instead')
const Policy$json = {
  '1': 'Policy',
  '2': [
    {
      '1': 'queries',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Rule',
      '10': 'queries'
    },
    {
      '1': 'kind',
      '3': 2,
      '4': 2,
      '5': 14,
      '6': '.biscuit.format.schema.Policy.Kind',
      '10': 'kind'
    },
  ],
  '4': [Policy_Kind$json],
};

@$core.Deprecated('Use policyDescriptor instead')
const Policy_Kind$json = {
  '1': 'Kind',
  '2': [
    {'1': 'Allow', '2': 0},
    {'1': 'Deny', '2': 1},
  ],
};

/// Descriptor for `Policy`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List policyDescriptor = $convert.base64Decode(
    'CgZQb2xpY3kSNQoHcXVlcmllcxgBIAMoCzIbLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5SdWxlUg'
    'dxdWVyaWVzEjYKBGtpbmQYAiACKA4yIi5iaXNjdWl0LmZvcm1hdC5zY2hlbWEuUG9saWN5Lktp'
    'bmRSBGtpbmQiGwoES2luZBIJCgVBbGxvdxAAEggKBERlbnkQAQ==');

@$core.Deprecated('Use authorizerPoliciesDescriptor instead')
const AuthorizerPolicies$json = {
  '1': 'AuthorizerPolicies',
  '2': [
    {'1': 'symbols', '3': 1, '4': 3, '5': 9, '10': 'symbols'},
    {'1': 'version', '3': 2, '4': 1, '5': 13, '10': 'version'},
    {
      '1': 'facts',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Fact',
      '10': 'facts'
    },
    {
      '1': 'rules',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Rule',
      '10': 'rules'
    },
    {
      '1': 'checks',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Check',
      '10': 'checks'
    },
    {
      '1': 'policies',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Policy',
      '10': 'policies'
    },
  ],
};

/// Descriptor for `AuthorizerPolicies`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authorizerPoliciesDescriptor = $convert.base64Decode(
    'ChJBdXRob3JpemVyUG9saWNpZXMSGAoHc3ltYm9scxgBIAMoCVIHc3ltYm9scxIYCgd2ZXJzaW'
    '9uGAIgASgNUgd2ZXJzaW9uEjEKBWZhY3RzGAMgAygLMhsuYmlzY3VpdC5mb3JtYXQuc2NoZW1h'
    'LkZhY3RSBWZhY3RzEjEKBXJ1bGVzGAQgAygLMhsuYmlzY3VpdC5mb3JtYXQuc2NoZW1hLlJ1bG'
    'VSBXJ1bGVzEjQKBmNoZWNrcxgFIAMoCzIcLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5DaGVja1IG'
    'Y2hlY2tzEjkKCHBvbGljaWVzGAYgAygLMh0uYmlzY3VpdC5mb3JtYXQuc2NoZW1hLlBvbGljeV'
    'IIcG9saWNpZXM=');

@$core.Deprecated('Use thirdPartyBlockRequestDescriptor instead')
const ThirdPartyBlockRequest$json = {
  '1': 'ThirdPartyBlockRequest',
  '2': [
    {
      '1': 'legacyPreviousKey',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.biscuit.format.schema.PublicKey',
      '10': 'legacyPreviousKey'
    },
    {
      '1': 'legacyPublicKeys',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.PublicKey',
      '10': 'legacyPublicKeys'
    },
    {
      '1': 'previousSignature',
      '3': 3,
      '4': 2,
      '5': 12,
      '10': 'previousSignature'
    },
  ],
};

/// Descriptor for `ThirdPartyBlockRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List thirdPartyBlockRequestDescriptor = $convert.base64Decode(
    'ChZUaGlyZFBhcnR5QmxvY2tSZXF1ZXN0Ek4KEWxlZ2FjeVByZXZpb3VzS2V5GAEgASgLMiAuYm'
    'lzY3VpdC5mb3JtYXQuc2NoZW1hLlB1YmxpY0tleVIRbGVnYWN5UHJldmlvdXNLZXkSTAoQbGVn'
    'YWN5UHVibGljS2V5cxgCIAMoCzIgLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5QdWJsaWNLZXlSEG'
    'xlZ2FjeVB1YmxpY0tleXMSLAoRcHJldmlvdXNTaWduYXR1cmUYAyACKAxSEXByZXZpb3VzU2ln'
    'bmF0dXJl');

@$core.Deprecated('Use thirdPartyBlockContentsDescriptor instead')
const ThirdPartyBlockContents$json = {
  '1': 'ThirdPartyBlockContents',
  '2': [
    {'1': 'payload', '3': 1, '4': 2, '5': 12, '10': 'payload'},
    {
      '1': 'externalSignature',
      '3': 2,
      '4': 2,
      '5': 11,
      '6': '.biscuit.format.schema.ExternalSignature',
      '10': 'externalSignature'
    },
  ],
};

/// Descriptor for `ThirdPartyBlockContents`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List thirdPartyBlockContentsDescriptor = $convert.base64Decode(
    'ChdUaGlyZFBhcnR5QmxvY2tDb250ZW50cxIYCgdwYXlsb2FkGAEgAigMUgdwYXlsb2FkElYKEW'
    'V4dGVybmFsU2lnbmF0dXJlGAIgAigLMiguYmlzY3VpdC5mb3JtYXQuc2NoZW1hLkV4dGVybmFs'
    'U2lnbmF0dXJlUhFleHRlcm5hbFNpZ25hdHVyZQ==');

@$core.Deprecated('Use authorizerSnapshotDescriptor instead')
const AuthorizerSnapshot$json = {
  '1': 'AuthorizerSnapshot',
  '2': [
    {
      '1': 'limits',
      '3': 1,
      '4': 2,
      '5': 11,
      '6': '.biscuit.format.schema.RunLimits',
      '10': 'limits'
    },
    {'1': 'executionTime', '3': 2, '4': 2, '5': 4, '10': 'executionTime'},
    {
      '1': 'world',
      '3': 3,
      '4': 2,
      '5': 11,
      '6': '.biscuit.format.schema.AuthorizerWorld',
      '10': 'world'
    },
  ],
};

/// Descriptor for `AuthorizerSnapshot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authorizerSnapshotDescriptor = $convert.base64Decode(
    'ChJBdXRob3JpemVyU25hcHNob3QSOAoGbGltaXRzGAEgAigLMiAuYmlzY3VpdC5mb3JtYXQuc2'
    'NoZW1hLlJ1bkxpbWl0c1IGbGltaXRzEiQKDWV4ZWN1dGlvblRpbWUYAiACKARSDWV4ZWN1dGlv'
    'blRpbWUSPAoFd29ybGQYAyACKAsyJi5iaXNjdWl0LmZvcm1hdC5zY2hlbWEuQXV0aG9yaXplcl'
    'dvcmxkUgV3b3JsZA==');

@$core.Deprecated('Use runLimitsDescriptor instead')
const RunLimits$json = {
  '1': 'RunLimits',
  '2': [
    {'1': 'maxFacts', '3': 1, '4': 2, '5': 4, '10': 'maxFacts'},
    {'1': 'maxIterations', '3': 2, '4': 2, '5': 4, '10': 'maxIterations'},
    {'1': 'maxTime', '3': 3, '4': 2, '5': 4, '10': 'maxTime'},
  ],
};

/// Descriptor for `RunLimits`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List runLimitsDescriptor = $convert.base64Decode(
    'CglSdW5MaW1pdHMSGgoIbWF4RmFjdHMYASACKARSCG1heEZhY3RzEiQKDW1heEl0ZXJhdGlvbn'
    'MYAiACKARSDW1heEl0ZXJhdGlvbnMSGAoHbWF4VGltZRgDIAIoBFIHbWF4VGltZQ==');

@$core.Deprecated('Use authorizerWorldDescriptor instead')
const AuthorizerWorld$json = {
  '1': 'AuthorizerWorld',
  '2': [
    {'1': 'version', '3': 1, '4': 1, '5': 13, '10': 'version'},
    {'1': 'symbols', '3': 2, '4': 3, '5': 9, '10': 'symbols'},
    {
      '1': 'publicKeys',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.PublicKey',
      '10': 'publicKeys'
    },
    {
      '1': 'blocks',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.SnapshotBlock',
      '10': 'blocks'
    },
    {
      '1': 'authorizerBlock',
      '3': 5,
      '4': 2,
      '5': 11,
      '6': '.biscuit.format.schema.SnapshotBlock',
      '10': 'authorizerBlock'
    },
    {
      '1': 'authorizerPolicies',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Policy',
      '10': 'authorizerPolicies'
    },
    {
      '1': 'generatedFacts',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.GeneratedFacts',
      '10': 'generatedFacts'
    },
    {'1': 'iterations', '3': 8, '4': 2, '5': 4, '10': 'iterations'},
  ],
};

/// Descriptor for `AuthorizerWorld`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authorizerWorldDescriptor = $convert.base64Decode(
    'Cg9BdXRob3JpemVyV29ybGQSGAoHdmVyc2lvbhgBIAEoDVIHdmVyc2lvbhIYCgdzeW1ib2xzGA'
    'IgAygJUgdzeW1ib2xzEkAKCnB1YmxpY0tleXMYAyADKAsyIC5iaXNjdWl0LmZvcm1hdC5zY2hl'
    'bWEuUHVibGljS2V5UgpwdWJsaWNLZXlzEjwKBmJsb2NrcxgEIAMoCzIkLmJpc2N1aXQuZm9ybW'
    'F0LnNjaGVtYS5TbmFwc2hvdEJsb2NrUgZibG9ja3MSTgoPYXV0aG9yaXplckJsb2NrGAUgAigL'
    'MiQuYmlzY3VpdC5mb3JtYXQuc2NoZW1hLlNuYXBzaG90QmxvY2tSD2F1dGhvcml6ZXJCbG9jax'
    'JNChJhdXRob3JpemVyUG9saWNpZXMYBiADKAsyHS5iaXNjdWl0LmZvcm1hdC5zY2hlbWEuUG9s'
    'aWN5UhJhdXRob3JpemVyUG9saWNpZXMSTQoOZ2VuZXJhdGVkRmFjdHMYByADKAsyJS5iaXNjdW'
    'l0LmZvcm1hdC5zY2hlbWEuR2VuZXJhdGVkRmFjdHNSDmdlbmVyYXRlZEZhY3RzEh4KCml0ZXJh'
    'dGlvbnMYCCACKARSCml0ZXJhdGlvbnM=');

@$core.Deprecated('Use originDescriptor instead')
const Origin$json = {
  '1': 'Origin',
  '2': [
    {
      '1': 'authorizer',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.biscuit.format.schema.Empty',
      '9': 0,
      '10': 'authorizer'
    },
    {'1': 'origin', '3': 2, '4': 1, '5': 13, '9': 0, '10': 'origin'},
  ],
  '8': [
    {'1': 'Content'},
  ],
};

/// Descriptor for `Origin`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List originDescriptor = $convert.base64Decode(
    'CgZPcmlnaW4SPgoKYXV0aG9yaXplchgBIAEoCzIcLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5FbX'
    'B0eUgAUgphdXRob3JpemVyEhgKBm9yaWdpbhgCIAEoDUgAUgZvcmlnaW5CCQoHQ29udGVudA==');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor =
    $convert.base64Decode('CgVFbXB0eQ==');

@$core.Deprecated('Use generatedFactsDescriptor instead')
const GeneratedFacts$json = {
  '1': 'GeneratedFacts',
  '2': [
    {
      '1': 'origins',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Origin',
      '10': 'origins'
    },
    {
      '1': 'facts',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Fact',
      '10': 'facts'
    },
  ],
};

/// Descriptor for `GeneratedFacts`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generatedFactsDescriptor = $convert.base64Decode(
    'Cg5HZW5lcmF0ZWRGYWN0cxI3CgdvcmlnaW5zGAEgAygLMh0uYmlzY3VpdC5mb3JtYXQuc2NoZW'
    '1hLk9yaWdpblIHb3JpZ2lucxIxCgVmYWN0cxgCIAMoCzIbLmJpc2N1aXQuZm9ybWF0LnNjaGVt'
    'YS5GYWN0UgVmYWN0cw==');

@$core.Deprecated('Use snapshotBlockDescriptor instead')
const SnapshotBlock$json = {
  '1': 'SnapshotBlock',
  '2': [
    {'1': 'context', '3': 1, '4': 1, '5': 9, '10': 'context'},
    {'1': 'version', '3': 2, '4': 1, '5': 13, '10': 'version'},
    {
      '1': 'facts',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Fact',
      '10': 'facts'
    },
    {
      '1': 'rules',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Rule',
      '10': 'rules'
    },
    {
      '1': 'checks',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Check',
      '10': 'checks'
    },
    {
      '1': 'scope',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.biscuit.format.schema.Scope',
      '10': 'scope'
    },
    {
      '1': 'externalKey',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.biscuit.format.schema.PublicKey',
      '10': 'externalKey'
    },
  ],
};

/// Descriptor for `SnapshotBlock`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List snapshotBlockDescriptor = $convert.base64Decode(
    'Cg1TbmFwc2hvdEJsb2NrEhgKB2NvbnRleHQYASABKAlSB2NvbnRleHQSGAoHdmVyc2lvbhgCIA'
    'EoDVIHdmVyc2lvbhIxCgVmYWN0cxgDIAMoCzIbLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5GYWN0'
    'UgVmYWN0cxIxCgVydWxlcxgEIAMoCzIbLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5SdWxlUgVydW'
    'xlcxI0CgZjaGVja3MYBSADKAsyHC5iaXNjdWl0LmZvcm1hdC5zY2hlbWEuQ2hlY2tSBmNoZWNr'
    'cxIyCgVzY29wZRgGIAMoCzIcLmJpc2N1aXQuZm9ybWF0LnNjaGVtYS5TY29wZVIFc2NvcGUSQg'
    'oLZXh0ZXJuYWxLZXkYByABKAsyIC5iaXNjdWl0LmZvcm1hdC5zY2hlbWEuUHVibGljS2V5Ugtl'
    'eHRlcm5hbEtleQ==');
