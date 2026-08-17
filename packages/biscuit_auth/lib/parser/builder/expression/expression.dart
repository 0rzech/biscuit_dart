// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/parser/builder/expression/op.dart';
import 'package:biscuit_auth/parser/expression.dart';
import 'package:collection/collection.dart';

final class const Expression(final List<Op> ops) {
  factory fromAst(Expr expr) => .new(expr.toOpcodes());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Expression && const ListEquality().equals(ops, other.ops);

  @override
  int get hashCode => Object.hash('Expression', const ListEquality().hash(ops));

  @override
  String toString() => 'Expression($ops)';
}
