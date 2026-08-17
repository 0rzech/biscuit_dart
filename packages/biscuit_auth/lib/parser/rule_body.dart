// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/parser/builder/expression/expression.dart';
import 'package:biscuit_auth/parser/builder/fact.dart';
import 'package:biscuit_auth/parser/builder/scope.dart';

typedef RuleBody = ({
  List<Predicate> predicates,
  List<Expression> expressions,
  List<Scope> scopes,
});
