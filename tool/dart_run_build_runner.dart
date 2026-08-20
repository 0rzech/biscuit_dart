#!/usr/bin/env dart

// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:io';

Future<void> main() async {
  exitCode = await Process.start('dart', const [
    'run',
    'build_runner',
    'build',
    '--workspace',
  ], mode: .inheritStdio).then((process) => process.exitCode);
}
