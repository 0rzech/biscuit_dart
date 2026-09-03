// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';

part 'gen/error.bp.dart';

sealed class const TokenError(final String message) implements Exception {
  const factory internal() = InternalError;

  const factory invalidSignatureFormat() = FormatError.invalidSignatureFormat;
  const factory invalidSignature(String error) = FormatError.invalidSignature;
  const factory invalidSignatureGeneration(String error) =
      FormatError.invalidSignatureGeneration;
  const factory sealedSignature() = FormatError.sealedSignature;
  const factory emptyKeys() = FormatError.emptyKeys;
  const factory unknownPublicKey() = FormatError.unknownPublicKey;
  const factory deserialization(String error) = FormatError.deserialization;
  const factory serialization(String error) = FormatError.serialization;
  const factory blockDeserialization(String error) =
      FormatError.blockDeserialization;
  const factory blockSerialization(String error) =
      FormatError.blockSerialization;
  const factory version(int minimum, int maximum, int actual) =
      FormatError.version;
  const factory invalidKeySize(int size) = FormatError.invalidKeySize;
  const factory invalidSignatureSize(int size) =
      FormatError.invalidSignatureSize;
  const factory invalidKey(String key) = FormatError.invalidKey;
  const factory signatureDeserialization(String error) =
      FormatError.signatureDeserialization;
  const factory blockSignatureDeserialization(String error) =
      FormatError.blockSignatureDeserialization;
  const factory invalidBlockId(int id) = FormatError.invalidBlockId;
  const factory existingPublicKey(String key) = FormatError.existingPublicKey;
  const factory symbolTableOverlap() = FormatError.symbolTableOverlap;
  const factory publicKeyTableOverlap() = FormatError.publicKeyTableOverlap;
  const factory unknownExternalKey() = FormatError.unknownExternalKey;
  const factory unknownSymbolFormat(SymbolId id) = FormatError.unknownSymbol;
  const factory pkcs8(String error) = FormatError.pkcs8;

  const factory appendOnSealed() = AppendOnSealedError;
  const factory alreadySealed() = AlreadySealedError;

  const factory invalidBlockRule(int id, String rule) =
      LogicError.invalidBlockRule;
  factory unauthorized(
    FailedPolicyError policy,
    List<FailedCheckError> checks,
  ) = LogicError.unauthorized;
  const factory authorizerNotEmpty() = LogicError.authorizerNotEmpty;
  factory noMatchingPolicy(List<FailedCheckError> checks) =
      LogicError.noMatchingPolicy;

  factory parseErrors(List<ParseError> errors) = LanguageError.parseErrors;
  factory parameters({
    required List<String> missing,
    required List<String> unused,
  }) = LanguageError.parameters;

  const factory conversion(String term) = ConversionError;

  const factory invalidBase64Byte({required int index, required int byte}) =
      Base64Error.invalidBase64Byte;
  const factory invalidBase64Length() = Base64Error.invalidBase64Length;
  const factory invalidLastBase64Symbol({
    required int index,
    required int byte,
  }) = Base64Error.invalidLastBase64Symbol;

  const factory unknownExpressionSymbol(SymbolId id) =
      ExecutionError.unknownSymbol;
  const factory unknownVariable(SymbolId id) = ExecutionError.unknownVariable;
  const factory invalidType() = ExecutionError.invalidType;
  const factory expressionOverflow() = ExecutionError.overflow;
  const factory divisionByZero() = ExecutionError.divisionByZero;
  const factory invalidStack() = ExecutionError.invalidStack;
  const factory shadowedVariable() = ExecutionError.shadowedVariable;
  const factory undefinedExtern(String name) = ExecutionError.undefinedExtern;
  const factory externVal({required String name, required String error}) =
      ExecutionError.externVal;
  const factory tooManyFacts() = ExecutionError.tooManyFacts;
  const factory tooManyIterations() = ExecutionError.tooManyIterations;
  const factory timeout() = ExecutionError.timeout;
  const factory unexpectedQueryResult({
    required int expected,
    required int actual,
  }) = ExecutionError.unexpectedQueryResult;

  @override
  String toString() => message;
}

@Boilerplate(string: false)
final class const InternalError() extends TokenError {
  this : super('Internal error');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

const baseFormatMessage = 'Error deserializing or verifying the token';

sealed class const FormatError(super.message) extends TokenError {
  const factory invalidSignatureFormat() = SignatureError.invalidFormat;
  const factory invalidSignature(String error) =
      SignatureError.invalidSignature;
  const factory invalidSignatureGeneration(String error) =
      SignatureError.invalidSignatureGeneration;
  const factory sealedSignature() = SignatureError.sealedSignature;
  const factory emptyKeys() = EmptyKeysError;
  const factory unknownPublicKey() = UnknownPublicKeyError;
  const factory deserialization(String error) = DeserializationError;
  const factory serialization(String error) = SerializationError;
  const factory blockDeserialization(String error) = BlockDeserializationError;
  const factory blockSerialization(String error) = BlockSerializationError;
  const factory version(int minimum, int maximum, int actual) = VersionError;
  const factory invalidKeySize(int size) = InvalidKeySizeError;
  const factory invalidSignatureSize(int size) = InvalidSignatureSizeError;
  const factory invalidKey(String key) = InvalidKeyError;
  const factory signatureDeserialization(String error) =
      SignatureDeserializationError;
  const factory blockSignatureDeserialization(String error) =
      BlockSignatureDeserializationError;
  const factory invalidBlockId(int id) = InvalidBlockIdError;
  const factory existingPublicKey(String key) = ExistingPublicKeyError;
  const factory symbolTableOverlap() = SymbolTableOverlapError;
  const factory publicKeyTableOverlap() = PublicKeyTableOverlapError;
  const factory unknownExternalKey() = UnknownExternalKeyError;
  const factory unknownSymbol(SymbolId id) = UnknownFormatSymbolError;
  const factory pkcs8(String error) = PKCS8Error;
}

const baseSignatureMessage =
    '$baseFormatMessage: Failed verifying the signature';

sealed class const SignatureError(super.message) extends FormatError {
  const factory invalidFormat() = InvalidSignatureFormatError;
  const factory invalidSignature(String error) = InvalidSignatureError;
  const factory invalidSignatureGeneration(String error) =
      InvalidSignatureGenerationError;
  const factory sealedSignature() = SealedSignatureError;
}

@Boilerplate(string: false)
final class const InvalidSignatureFormatError() extends SignatureError {
  this : super('$baseSignatureMessage: Could not parse the signature elements');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class InvalidSignatureError extends SignatureError {
  const new(String error)
    : super('$baseSignatureMessage: The signature did not match: $error');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class InvalidSignatureGenerationError extends SignatureError {
  const new(String error)
    : super('$baseSignatureMessage: Could not sign: $error');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const SealedSignatureError() extends SignatureError {
  this : super('Failed verifying the signature of a sealed token');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const EmptyKeysError() extends FormatError {
  this : super('The token does not provide intermediate public keys');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const UnknownPublicKeyError() extends FormatError {
  this : super('The root public key was not recognized');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class DeserializationError extends FormatError {
  const new(String error)
    : super(
        '$baseFormatMessage: Could not deserialize the wrapper object: $error',
      );

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class SerializationError extends FormatError {
  const new(String error)
    : super(
        '$baseFormatMessage: Could not serialize the wrapper object: $error',
      );

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class BlockDeserializationError extends FormatError {
  const new(String error)
    : super('$baseFormatMessage: Could not deserialize the block: $error');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class BlockSerializationError extends FormatError {
  const new(String error)
    : super('$baseFormatMessage: Could not serialize the block: $error');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class VersionError extends FormatError {
  const new(int maximum, int minimum, int actual)
    : super(
        'Block format version is higher than supported '
        '(min: $minimum, max: $maximum, actual: $actual)',
      );

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class InvalidKeySizeError extends FormatError {
  const new(int size) : super('Invalid key size: $size');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class InvalidSignatureSizeError extends FormatError {
  const new(int size) : super('Invalid signature size: $size');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class InvalidKeyError extends FormatError {
  const new(String key) : super('$baseFormatMessage: Invalid key: $key');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class SignatureDeserializationError extends FormatError {
  const new(String error)
    : super('$baseFormatMessage: Could not deserialize signature: $error');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class BlockSignatureDeserializationError extends FormatError {
  const new(String error)
    : super(
        '$baseFormatMessage: Could not deserialize the block signature: $error',
      );

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class InvalidBlockIdError extends FormatError {
  const new(int id) : super('$baseFormatMessage: Invalid block id: $id');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class ExistingPublicKeyError extends FormatError {
  const new(String key)
    : super(
        '$baseFormatMessage: The public key is already present '
        'in previous blocks: $key',
      );

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const SymbolTableOverlapError() extends FormatError {
  this : super('$baseFormatMessage: Multiple blocks declare the same symbols');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const PublicKeyTableOverlapError() extends FormatError {
  this
    : super('$baseFormatMessage: Multiple blocks declare the same public keys');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const UnknownExternalKeyError() extends FormatError {
  this
    : super('$baseFormatMessage: The external public key was not recognized');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class UnknownFormatSymbolError extends FormatError {
  const new(SymbolId id)
    : super('$baseFormatMessage: The symbol id was not in the table: $id');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class PKCS8Error extends FormatError {
  const new(String error)
    : super('$baseFormatMessage: PKCS8 serialization error: $error');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const AppendOnSealedError() extends TokenError {
  this : super('Tried to append a block to a sealed token');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const AlreadySealedError() extends TokenError {
  this : super('Tried to seal an already sealed token');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

const baseFailedLogicMessage = 'Authorization failed';

sealed class const LogicError(super.message) extends TokenError {
  const factory invalidBlockRule(int id, String rule) = InvalidBlockRuleError;
  factory unauthorized(
    FailedPolicyError policy,
    List<FailedCheckError> checks,
  ) = UnauthorizedError;
  const factory authorizerNotEmpty() = AuthorizerNotEmptyError;
  factory noMatchingPolicy(List<FailedCheckError> checks) =
      NoMatchingPolicyError;
}

@Boilerplate(string: false)
final class InvalidBlockRuleError extends LogicError {
  const new(int id, String rule)
    : super(
        '$baseFailedLogicMessage: A rule provided by a block is producing '
        'a fact with unbound variables: $id: $rule',
      );

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class UnauthorizedError extends LogicError {
  new(FailedPolicyError policy, List<FailedCheckError> checks)
    : super(
        '$baseFailedLogicMessage: $policy, '
        'and the following checks failed: ${checks.join('; ')}',
      );

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const AuthorizerNotEmptyError() extends LogicError {
  this
    : super('$baseFailedLogicMessage: The authorizer already contains a token');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class NoMatchingPolicyError extends LogicError {
  new(List<FailedCheckError> checks)
    : super(
        '$baseFailedLogicMessage: No matching policy was found, '
        'and the following checks failed: ${checks.join('; ')}',
      );

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

sealed class const FailedPolicyError(final int index) {
  const factory failedAllowPolicy(int index) = FailedAllowPolicyError;
  const factory failedDenyPolicy(int index) = FailedDenyPolicyError;
}

@Boilerplate(string: false)
final class const FailedAllowPolicyError(super.index)
    extends FailedPolicyError {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => 'an allow policy matched (policy index: $index)';
}

@Boilerplate(string: false)
final class const FailedDenyPolicyError(super.index) extends FailedPolicyError {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => 'a deny policy matched (policy index: $index)';
}

sealed class const FailedCheckError() {
  const factory block({
    required int blockId,
    required int checkId,
    required String rule,
  }) = FailedBlockCheckError;

  const factory authorizer(int checkId, String rule) =
      FailedAuthorizerCheckError;
}

@Boilerplate(string: false)
final class const FailedBlockCheckError({
  required final int blockId,
  required final int checkId,
  required final String rule,
}) extends FailedCheckError {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => 'Check no. $checkId in block no. $blockId: $rule';
}

@Boilerplate(string: false)
final class const FailedAuthorizerCheckError(
  final int checkId,
  final String rule,
) extends FailedCheckError {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => 'Check no. $checkId in authorizer: $rule';
}

const baseLanguageErrorMessage = 'Error generating Datalog';

sealed class const LanguageError(super.message) extends TokenError {
  factory parseErrors(List<ParseError> errors) = ParseErrors;

  factory parameters({
    required List<String> missing,
    required List<String> unused,
  }) = ParametersError;
}

@Boilerplate(string: false)
final class ParseErrors extends LanguageError {
  new(List<ParseError> errors)
    : super(
        '$baseLanguageErrorMessage: Datalog parsing error: '
        '[${errors.join('; ')}]',
      );

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const ParseError(final String input, {final String? message}) {
  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => 'Input: "$input", message: $message';
}

@Boilerplate(string: false)
final class ParametersError extends LanguageError {
  new({required List<String> missing, required List<String> unused})
    : super(
        '$baseLanguageErrorMessage: Datalog parameters must all be bound, '
        'provided values must all be used.\n'
        'Missing parameters: ${missing.join(', ')}.\n'
        'Unused parameters: ${unused.join(', ')}.',
      );

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class ConversionError extends TokenError {
  const new(String term) : super('Cannot convert from Term: $term');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

const baseBase64ErrorMessage = 'Cannot decode base64 token';

sealed class const Base64Error(super.message) extends TokenError {
  const factory invalidBase64Byte({required int index, required int byte}) =
      InvalidBase64ByteError;
  const factory invalidBase64Length() = InvalidBase64LengthError;
  const factory invalidLastBase64Symbol({
    required int index,
    required int byte,
  }) = InvalidLastBase64SymbolError;
}

@Boilerplate(string: false)
final class InvalidBase64ByteError extends Base64Error {
  const new({required int index, required int byte})
    : super('$baseBase64ErrorMessage: "Invalid byte $byte, offset $index');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const InvalidBase64LengthError() extends Base64Error {
  this
    : super(
        '$baseBase64ErrorMessage: Encoded text cannot have a 6-bit remainder',
      );

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class InvalidLastBase64SymbolError extends Base64Error {
  const new({required int index, required int byte})
    : super(
        '$baseBase64ErrorMessage: "Invalid last symbol $byte, offset $index',
      );

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

const baseExecutionErrorMessage = 'Datalog  execution failure';

sealed class const ExecutionError(super.message) extends TokenError {
  const factory unknownSymbol(SymbolId id) = UnknownExpressionSymbolError;
  const factory unknownVariable(SymbolId id) = UnknownVariableError;
  const factory invalidType() = InvalidTypeError;
  const factory overflow() = ExpressionOverflowError;
  const factory divisionByZero() = DivisionByZeroError;
  const factory invalidStack() = InvalidStackError;
  const factory shadowedVariable() = ShadowedVariableError;
  const factory undefinedExtern(String name) = UndefinedExternError;
  const factory externVal({required String name, required String error}) =
      ExternValError;
  const factory tooManyFacts() = RunLimitError.tooManyFacts;
  const factory tooManyIterations() = RunLimitError.tooManyIterations;
  const factory timeout() = RunLimitError.timeout;
  const factory unexpectedQueryResult({
    required int expected,
    required int actual,
  }) = RunLimitError.unexpectedQueryResult;
}

@Boilerplate(string: false)
final class UnknownExpressionSymbolError extends ExecutionError {
  const new(SymbolId id)
    : super('$baseExecutionErrorMessage: Unknown symbol: $id');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class UnknownVariableError extends ExecutionError {
  const new(SymbolId id)
    : super('$baseExecutionErrorMessage: Unknown variable: $id');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const InvalidTypeError() extends ExecutionError {
  this : super('$baseExecutionErrorMessage: Invalid type');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const ExpressionOverflowError() extends ExecutionError {
  this : super('$baseExecutionErrorMessage: Overflow');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const DivisionByZeroError() extends ExecutionError {
  this : super('$baseExecutionErrorMessage: Division by zero');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const InvalidStackError() extends ExecutionError {
  this : super('$baseExecutionErrorMessage: Wrong number of elements on stack');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const ShadowedVariableError() extends ExecutionError {
  this : super('$baseExecutionErrorMessage: Shadowed variable');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class UndefinedExternError extends ExecutionError {
  const new(String name)
    : super('$baseExecutionErrorMessage: Undefined extern func: $name');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class ExternValError extends ExecutionError {
  const new({required String name, required String error})
    : super(
        '$baseExecutionErrorMessage: '
        'Error while evaluating extern func $name: $error',
      );

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

const baseRunLimitErrorMessage = 'Reached Datalog execution limits';

sealed class const RunLimitError(super.message) extends ExecutionError {
  const factory tooManyFacts() = TooManyFactsError;
  const factory tooManyIterations() = TooManyIterationsError;
  const factory timeout() = TimeoutError;
  const factory unexpectedQueryResult({
    required int expected,
    required int actual,
  }) = UnexpectedQueryResultError;
}

@Boilerplate(string: false)
final class const TooManyFactsError() extends RunLimitError {
  this : super('$baseRunLimitErrorMessage: Too many facts generated');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const TooManyIterationsError() extends RunLimitError {
  this : super('$baseRunLimitErrorMessage: Too many engine iterations');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class const TimeoutError() extends RunLimitError {
  this : super('$baseRunLimitErrorMessage: Spent too much time verifying');

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

@Boilerplate(string: false)
final class UnexpectedQueryResultError extends RunLimitError {
  const new({required int expected, required int actual})
    : super(
        '$baseRunLimitErrorMessage: Unexpected query results, '
        'expected $expected got $actual',
      );

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
