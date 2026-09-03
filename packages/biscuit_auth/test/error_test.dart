// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/error.dart';
import 'package:test/test.dart';

void main() {
  test('error format strings', () {
    expect(
      const TokenError.conversion('test'),
      isA<ConversionError>().having(
        (e) => e.message,
        'message',
        'Cannot convert from Term: test',
      ),
    );

    expect(
      const TokenError.invalidBase64Length(),
      isA<InvalidBase64LengthError>().having(
        (e) => e.message,
        'message',
        'Cannot decode base64 token: '
            'Encoded text cannot have a 6-bit remainder',
      ),
    );

    expect(
      TokenError.unauthorized(const .failedAllowPolicy(0), const [
        .authorizer(0, 'check if false'),
        .block(blockId: 0, checkId: 0, rule: 'check if false'),
      ]),
      isA<UnauthorizedError>().having(
        (e) => e.message,
        'message',
        'Authorization failed: an allow policy matched (policy index: 0), '
            'and the following checks failed: Check no. 0 in authorizer: '
            'check if false; Check no. 0 in block no. 0: check if false',
      ),
    );
  });
}
