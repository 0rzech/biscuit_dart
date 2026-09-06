// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/parser/grammar/grammar.dart';
import 'package:meta/meta.dart';

final sourceParser = grammar.buildFrom(grammar.source());
final blockSourceParser = grammar.buildFrom(grammar.blockSource());
final policyParser = grammar.buildFrom(grammar.policy());
final ruleParser = grammar.buildFrom(grammar.rule());
final factParser = grammar.buildFrom(grammar.fact());

@visibleForTesting
const grammar = DatalogGrammar();
