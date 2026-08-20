// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:meta/meta.dart';

@internal
const boilerplate = Boilerplate();
@internal
const runtimeBoilerplate = Boilerplate(runtimeTypeEquality: true);

@internal
final class const Boilerplate({
  final bool equality = true,
  final bool runtimeTypeEquality = false,
  final bool string = true,
});
