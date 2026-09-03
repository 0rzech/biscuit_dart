// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/datalog/expression/eval.dart';
import 'package:biscuit_auth/datalog/expression/op.dart';
import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/error.dart';
import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';
import 'package:biscuit_auth/token/builder/term.dart' as b;
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'gen/expression.bp.dart';

@immutable
@Boilerplate(string: false)
final class const ExternFn(
  final b.Term Function({required b.Term left, b.Term? right}) callback,
) {
  Term call(TemporarySymbolTable symbols, String name, Term left, Term? right) {
    try {
      final term = callback(
        left: b.fromDatalog(left, symbols),
        right: right == null ? null : b.fromDatalog(right, symbols),
      );
      return b.toDatalog(term, symbols);
    } on ExecutionError {
      rethrow;
    } on Exception catch (e) {
      throw ExecutionError.externVal(name: name, error: e.toString());
    }
  }

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => '<function>';
}

@immutable
@boilerplate
final class const Expression(final List<Op> ops) {
  Term eval(
    HashMap<SymbolId, Term> values,
    TemporarySymbolTable symbols,
    HashMap<String, ExternFn> externFunctions,
  ) {
    final stack = <Object>[];

    for (final op in ops) {
      switch (op) {
        // value

        case final Term term:
          if (term case VariableTerm(:final id)) {
            if (values[id] case final value?) {
              stack.add(value);
            } else {
              throw ExecutionError.unknownVariable(id);
            }
          } else {
            stack.add(term);
          }

        // unary

        case final UnaryOp _:
          if (stack.isEmpty) throw const ExecutionError.invalidStack();

          if (stack.removeLast() case final Term t) {
            stack.add(op.eval(t, symbols, externFunctions));
          } else {
            throw const ExecutionError.invalidStack();
          }

        // binary

        case final BinaryOp _:
          if (stack.length < 2) throw const ExecutionError.invalidStack();

          switch ((stack.removeLast(), stack.removeLast())) {
            case (final Term r, final Term l):
              stack.add(op.eval(l, r, symbols, externFunctions));

            case (ClosureOp(:final params, :final ops), final Term t):
            case (final Term t, ClosureOp(:final params, :final ops)):
              if (params.any(values.containsKey)) {
                throw const ExecutionError.shadowedVariable();
              }

              stack.add(
                op.evalWithClosure(
                  t,
                  ops,
                  params,
                  values,
                  symbols,
                  externFunctions,
                ),
              );

            default:
              throw const ExecutionError.invalidStack();
          }

        // closure

        case final ClosureOp c:
          stack.add(c);
      }
    }

    if (stack.length == 1) {
      if (stack.removeLast() case final Term t) {
        return t;
      }
      throw const ExecutionError.invalidStack();
    }

    throw const ExecutionError.invalidStack();
  }

  String? stringify(SymbolTable symbols) {
    final stack = <String>[];

    for (final op in ops) {
      switch (op) {
        case final Term term:
          stack.add(term.stringify(symbols));

        case UnaryOp _:
          if (stack.isEmpty) return null;

          stack.add(op.stringify(stack.removeLast(), symbols));

        case BinaryOp _:
          if (stack.length < 2) return null;

          final (right, left) = (stack.removeLast(), stack.removeLast());
          stack.add(op.stringify(left, right, symbols));

        case ClosureOp(:final params, :final ops):
          final body = Expression(ops).stringify(symbols);
          if (body == null) return null;

          if (params.isEmpty) {
            stack.add(body);
          } else {
            final group = params
                .map((id) => Term.variable(id).stringify(symbols))
                .join(', ');
            stack.add('$group -> $body');
          }
      }
    }

    return stack.length == 1 ? stack.first : null;
  }

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
