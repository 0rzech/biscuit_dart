// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:meta/meta.dart';

part 'gen/run_limits.bp.dart';

/// runtime limits for the Datalog engine
@immutable
@Boilerplate(equality: false)
final class const RunLimits({
  /// maximum number of Datalog facts (memory usage)
  final int maxFacts = 1000,

  /// maximum number of iterations of the rules applications
  /// (prevents degenerate rules)
  final int maxIterations = 100,

  /// maximum execution time
  final Duration maxTime = const Duration(milliseconds: 1),
}) {
  this
    : assert(maxFacts > 0, 'maxFacts must be > 0, but was $maxFacts'),
      assert(
        maxIterations > 0,
        'maxIterations must be > 0, but was $maxIterations',
      ),
      assert(
        maxTime >= minDuration,
        'maxTime must be >= $minDuration, but was $maxTime',
      );

  static final defaults = RunLimits();

  @override
  String toString() => _toString();
}

const minDuration = Duration(milliseconds: 1);
