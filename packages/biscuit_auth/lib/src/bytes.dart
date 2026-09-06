// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:typed_data';

import 'package:meta/meta.dart';

@internal
Uint8List bytesStrToUint8List(String bytesStr) {
  final odd = bytesStr.length % 2 == 1;
  final bytes = Uint8List(bytesStr.length ~/ 2 + (odd ? 1 : 0));

  var byteIndex = 0;
  var unitIndex = 0;

  if (odd) {
    bytes[byteIndex++] = hexFromCodeUnit(bytesStr.codeUnitAt(unitIndex++));
  }

  for (; byteIndex < bytes.length; ++byteIndex, unitIndex += 2) {
    final high = hexFromCodeUnit(bytesStr.codeUnitAt(unitIndex));
    final low = hexFromCodeUnit(bytesStr.codeUnitAt(unitIndex + 1));
    bytes[byteIndex] = (high << 4) | low;
  }

  return bytes;
}

@internal
int hexFromCodeUnit(int codeUnit) => switch (codeUnit) {
  > 47 && < 58 => codeUnit - 48, // 0-9
  > 64 && < 71 => codeUnit - 55, // A-F
  > 96 && < 103 => codeUnit - 87, // a-f
  _ => throw FormatException(
    'Invalid hex character: ${String.fromCharCode(codeUnit)}',
  ),
};

@internal
String uint8ListToBytesStr(Uint8List bytes, {String prefix = ''}) {
  final sb = StringBuffer(prefix);

  for (final byte in bytes) {
    sb.writeCharCode(codeUnitFromHex(byte >> 4));
    sb.writeCharCode(codeUnitFromHex(byte & 0x0F));
  }

  return sb.toString();
}

@internal
int codeUnitFromHex(int nibble) => switch (nibble) {
  >= 0 && <= 9 => nibble + 48, // '0'-'9'
  >= 10 && <= 15 => nibble + 87, // 'a'-'f'
  _ => throw RangeError('Invalid nibble value: $nibble'),
};
