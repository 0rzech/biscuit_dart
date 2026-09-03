// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/parser/builder/expression/op.dart';
import 'package:biscuit_auth/parser/expression.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/expression.bp.dart';

@immutable
@boilerplate
final class const Expression(final List<Op> ops) {
  factory fromAst(Expr expr) => .new(expr.toOpcodes());

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
