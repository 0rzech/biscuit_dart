// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/datalog/expression/expression.dart';
import 'package:biscuit_auth/datalog/expression/op.dart';
import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/datalog/term.dart';
import 'package:biscuit_auth/error.dart';
import 'package:biscuit_auth/parser/builder/term.dart' as b;
import 'package:test/test.dart';

void main() {
  group(Expression, () {
    test('negate', () {
      final symbols = SymbolTable()
        ..insert('test1')
        ..insert('test2')
        ..insert('var1');
      final tmpSymbols = TemporarySymbolTable(symbols);
      final ops = const <Op>[
        .value(.int(1)),
        .value(.variable(.new(2))),
        .lessThan(),
        .parens(),
        .negate(),
      ];

      printOnFailure('\nops: $ops');

      final values = HashMap.of(const <SymbolId, Term>{.new(2): .int(0)});
      final expr = Expression(ops);

      printOnFailure('expression: ${expr.stringify(symbols)}');

      final res = expr.eval(values, tmpSymbols, .identity());

      expect(res, const Term.bool(true));
    });

    test('bitwise', () {
      final symbols = SymbolTable();
      final tmpSymbols = TemporarySymbolTable(symbols);

      for (final (op, val1, val2, expected)
          in const <(BinaryOp, int, int, int)>[
            (.bitwiseAnd(), 9, 10, 8),
            (.bitwiseAnd(), 9, 1, 1),
            (.bitwiseAnd(), 9, 0, 0),
            (.bitwiseOr(), 1, 2, 3),
            (.bitwiseOr(), 2, 2, 2),
            (.bitwiseOr(), 2, 0, 2),
            (.bitwiseXor(), 1, 0, 1),
            (.bitwiseXor(), 1, 1, 0),
          ]) {
        final ops = <Op>[.value(.int(val1)), .value(.int(val2)), op];

        printOnFailure('\nops: $ops');

        final expr = Expression(ops);

        printOnFailure('expression: ${expr.stringify(symbols)}');

        final res = expr.eval(.identity(), tmpSymbols, .identity());

        expect(res, Term.int(expected));
      }
    });

    test('checked', () {
      final symbols = SymbolTable();
      final tmpSymbols = TemporarySymbolTable(symbols);

      var expr = const Expression(<Op>[
        .value(.int(1)),
        .value(.int(0)),
        .div(),
      ]);

      expect(
        () => expr.eval(.identity(), tmpSymbols, .identity()),
        throwsA(const ExecutionError.divisionByZero()),
      );

      expr = const Expression(<Op>[
        .value(.int(1)),
        .value(.int(SymbolId.max)),
        .add(),
      ]);

      expect(
        () => expr.eval(.identity(), tmpSymbols, .identity()),
        throwsA(const ExecutionError.overflow()),
      );

      expr = const Expression(<Op>[
        .value(.int(-10)),
        .value(.int(SymbolId.max)),
        .sub(),
      ]);

      expect(
        () => expr.eval(.identity(), tmpSymbols, .identity()),
        throwsA(const ExecutionError.overflow()),
      );

      expr = const Expression(<Op>[
        .value(.int(2)),
        .value(.int(SymbolId.max)),
        .mul(),
      ]);

      expect(
        () => expr.eval(.identity(), tmpSymbols, .identity()),
        throwsA(const ExecutionError.overflow()),
      );
    });

    test('printer', () {
      final symbols = SymbolTable()
        ..insert('test1')
        ..insert('test2')
        ..insert('var1');

      var expr = const Expression(<Op>[
        .value(.int(-1)),
        .value(.variable(.new(1026))),
        .lessThan(),
      ]);

      expect(expr.stringify(symbols), '-1 < \$var1');

      expr = const Expression(<Op>[
        .value(.int(1)),
        .value(.int(2)),
        .value(.int(3)),
        .add(),
        .lessThan(),
      ]);

      expect(expr.stringify(symbols), '1 < 2 + 3');

      expr = const Expression(<Op>[
        .value(.int(1)),
        .value(.int(2)),
        .add(),
        .value(.int(3)),
        .lessThan(),
      ]);

      expect(expr.stringify(symbols), '1 + 2 < 3');
    });

    test('null equal', () {
      final symbols = SymbolTable();
      final tmpSymbols = TemporarySymbolTable(symbols);

      const operands = <Op>[.value(Term.nil()), .value(Term.nil())];
      const operators = <Op>[.equal(), .heterogeneousEqual()];

      for (final op in operators) {
        final expr = Expression([...operands, op]);

        printOnFailure('ops: ${expr.ops}');
        printOnFailure('expression: ${expr.stringify(symbols)}');

        final res = expr.eval(.identity(), tmpSymbols, .identity());

        expect(res, const Term.bool(true));
      }
    });

    test('null not equal', () {
      final symbols = SymbolTable();
      final tmpSymbols = TemporarySymbolTable(symbols);

      const operands = <Op>[.value(Term.nil()), .value(Term.nil())];
      const operators = <Op>[.notEqual(), .heterogeneousNotEqual()];

      for (final op in operators) {
        final expr = Expression([...operands, op]);

        printOnFailure('ops: ${expr.ops}');
        printOnFailure('expression: ${expr.stringify(symbols)}');

        final res = expr.eval(.identity(), tmpSymbols, .identity());

        expect(res, const Term.bool(false));
      }
    });

    test('null heterogeneous', () {
      final symbols = SymbolTable();
      final tmpSymbols = TemporarySymbolTable(symbols);

      const operands = <Op>[.value(Term.nil()), .value(.int(1))];
      const operators = <(Op, bool)>[
        (.heterogeneousNotEqual(), true),
        (.heterogeneousEqual(), false),
      ];

      for (final (op, result) in operators) {
        final expr = Expression([...operands, op]);

        printOnFailure('ops: ${expr.ops}');
        printOnFailure('expression: ${expr.stringify(symbols)}');

        final res = expr.eval(.identity(), tmpSymbols, .identity());

        expect(res, Term.bool(result));
      }
    });

    test('equal heterogeneous', () {
      final symbols = SymbolTable();
      final tmpSymbols = TemporarySymbolTable(symbols);

      final operandsSamples = <List<Op>>[
        const [.value(.bool(true)), .value(.int(1))],
        const [.value(.bool(true)), .value(.str(.new(1)))],
        const [.value(.int(1)), .value(.str(.new(1)))],
        [
          .value(.set(.of({const .int(1)}))),
          .value(.set(.of({const .str(.new(1))}))),
        ],
        [.value(.bytes(.new(0))), const .value(.int(1))],
        [.value(.bytes(.new(0))), const .value(.str(.new(1025)))],
        [.value(.date(.fromMillisecondsSinceEpoch(12))), const .value(.int(1))],
      ];

      const operators = <(Op, bool)>[
        (.heterogeneousNotEqual(), true),
        (.heterogeneousEqual(), false),
      ];

      for (final operands in operandsSamples) {
        for (final operand in [operands, operands.reversed]) {
          for (final (op, result) in operators) {
            final expr = Expression([...operand, op]);

            printOnFailure('ops: ${expr.ops}');
            printOnFailure('expression: ${expr.stringify(symbols)}');

            final res = expr.eval(.identity(), tmpSymbols, .identity());

            expect(res, Term.bool(result));
          }
        }
      }
    });

    test('strict equal heterogeneous', () {
      final symbols = SymbolTable();
      final tmpSymbols = TemporarySymbolTable(symbols);

      final operandsSamples = <List<Op>>[
        const [.value(Term.bool(true)), .value(.int(1))],
        const [.value(Term.bool(true)), .value(.str(.new(1)))],
        const [.value(.int(1)), .value(.str(.new(1)))],
        [.value(.bytes(.new(0))), const .value(.int(1))],
        [.value(.bytes(.new(0))), const .value(.str(.new(1025)))],
        [.value(.date(.fromMillisecondsSinceEpoch(12))), const .value(.int(1))],
      ];

      const operators = <Op>[.notEqual(), .equal()];

      for (final operands in operandsSamples) {
        for (final operand in [operands, operands.reversed]) {
          for (final op in operators) {
            final expr = Expression([...operand, op]);

            printOnFailure('ops: ${expr.ops}');
            printOnFailure('expression: ${expr.stringify(symbols)}');

            expect(
              () => expr.eval(.identity(), tmpSymbols, .identity()),
              throwsA(const ExecutionError.invalidType()),
            );
          }
        }
      }
    });

    test('laziness', () {
      final symbols = SymbolTable();
      final tmpSymbols = TemporarySymbolTable(symbols);

      const expr = Expression([
        .value(.bool(false)),
        .closure(
          params: [],
          ops: [
            .value(.bool(true)),
            .closure(params: [], ops: [.value(.bool(true))]),
            .lazyAnd(),
          ],
        ),
        .lazyOr(),
      ]);

      final res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));
    });

    test('any', () {
      final symbols = SymbolTable();
      final p = symbols.insert('param');
      final tmpSymbols = TemporarySymbolTable(symbols);

      var expr = Expression([
        .value(.set(.of({const .bool(false), const .bool(true)}))),
        .closure(params: [p], ops: [.value(.variable(p))]),
        const .any(),
      ]);

      printOnFailure('expression1: ${expr.stringify(symbols)}');

      var res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression([
        .value(.set(.of({const .int(1), const .int(2)}))),
        .closure(
          params: [p],
          ops: [.value(.variable(p)), const .value(.int(0)), const .lessThan()],
        ),
        const .any(),
      ]);

      printOnFailure('expression2: ${expr.stringify(symbols)}');

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = Expression([
        .value(.set(.of({const .int(1), const .int(2)}))),
        .closure(params: [p], ops: const [.value(.int(0))]),
        const .any(),
      ]);

      printOnFailure('expression3: ${expr.stringify(symbols)}');

      expect(
        () => expr.eval(.identity(), tmpSymbols, .identity()),
        throwsA(const ExecutionError.invalidType()),
      );
    });

    test('all', () {
      final symbols = SymbolTable();
      final p = symbols.insert('param');
      final tmpSymbols = TemporarySymbolTable(symbols);

      var expr = Expression([
        .value(.set(.of({const .int(1), const .int(2)}))),
        .closure(
          params: [p],
          ops: [
            .value(.variable(p)),
            const .value(.int(0)),
            const .greaterThan(),
          ],
        ),
        const .all(),
      ]);

      printOnFailure('expression1: ${expr.stringify(symbols)}');

      var res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression([
        .value(.set(.of({const .int(1), const .int(2)}))),
        .closure(
          params: [p],
          ops: [.value(.variable(p)), const .value(.int(0)), const .lessThan()],
        ),
        const .all(),
      ]);

      printOnFailure('expression2: ${expr.stringify(symbols)}');

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = Expression([
        .value(.set(.of({const .int(1), const .int(2)}))),
        .closure(params: [p], ops: const [.value(.int(0))]),
        const .all(),
      ]);

      printOnFailure('expression3: ${expr.stringify(symbols)}');

      expect(
        () => expr.eval(.identity(), tmpSymbols, .identity()),
        throwsA(const ExecutionError.invalidType()),
      );
    });

    test('nested closures', () {
      final symbols = SymbolTable();
      final p = symbols.insert('p');
      final q = symbols.insert('q');
      final tmpSymbols = TemporarySymbolTable(symbols);

      final expr = Expression([
        .value(.set(.of({const .int(1), const .int(2), const .int(3)}))),
        .closure(
          params: [p],
          ops: [
            .value(.variable(p)),
            const .value(.int(1)),
            const .greaterThan(),
            .closure(
              params: [],
              ops: [
                .value(
                  .set(.of({const .int(3), const .int(4), const .int(5)})),
                ),
                .closure(
                  params: [q],
                  ops: [
                    .value(.variable(p)),
                    .value(.variable(q)),
                    const .equal(),
                  ],
                ),
                const .any(),
              ],
            ),
            const .lazyAnd(),
          ],
        ),
        const .any(),
      ]);

      printOnFailure('expression: ${expr.stringify(symbols)}');

      final res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));
    });

    test('variable shadowing', () {
      var symbols = SymbolTable();
      var p = symbols.insert('param');
      var tmpSymbols = TemporarySymbolTable(symbols);
      final values = HashMap.of({p: const Term.nil()});

      var expr = Expression([
        .value(.set(.of({const .int(1), const .int(2)}))),
        .closure(
          params: [p],
          ops: [
            .value(.variable(p)),
            const .value(.int(0)),
            const .greaterThan(),
          ],
        ),
        const .all(),
      ]);

      printOnFailure('expression1: ${expr.stringify(symbols)}');

      expect(
        () => expr.eval(values, tmpSymbols, .identity()),
        throwsA(const ExecutionError.shadowedVariable()),
      );

      symbols = SymbolTable();
      p = symbols.insert('p');
      tmpSymbols = TemporarySymbolTable(symbols);

      expr = Expression([
        .value(.set(.of({const .int(1), const .int(2), const .int(3)}))),
        .closure(
          params: [p],
          ops: [
            .value(.variable(p)),
            const .value(.int(1)),
            const .greaterThan(),
            .closure(
              params: [],
              ops: [
                .value(
                  .set(.of({const .int(3), const .int(4), const .int(5)})),
                ),
                .closure(
                  params: [p],
                  ops: [
                    .value(.variable(p)),
                    .value(.variable(p)),
                    const .equal(),
                  ],
                ),
                const .any(),
              ],
            ),
            const .lazyAnd(),
          ],
        ),
        const .any(),
      ]);

      printOnFailure('expression2: ${expr.stringify(symbols)}');

      expect(
        () => expr.eval(.identity(), tmpSymbols, .identity()),
        throwsA(const ExecutionError.shadowedVariable()),
      );
    });

    test('array', () {
      final symbols = SymbolTable();
      final tmpSymbols = TemporarySymbolTable(symbols);

      var expr = const Expression([
        .value(.array([.int(0), .int(1)])),
        .value(.array([.int(0), .int(1)])),
        .equal(),
      ]);

      var res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = const Expression([
        .value(.array([.int(0), .int(1)])),
        .value(.array([.int(0)])),
        .equal(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = const Expression([
        .value(.array([.int(0), .int(1)])),
        .value(.int(1)),
        .contains(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = const Expression([
        .value(.array([.int(0), .int(1)])),
        .value(.int(2)),
        .contains(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = const Expression([
        .value(.array([.int(0), .int(1), .int(2)])),
        .value(.array([.int(0), .int(1)])),
        .prefix(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = const Expression([
        .value(.array([.int(0), .int(1), .int(2)])),
        .value(.array([.int(2), .int(1)])),
        .prefix(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = const Expression([
        .value(.array([.int(0), .int(1), .int(2)])),
        .value(.array([.int(1), .int(2)])),
        .suffix(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = const Expression([
        .value(.array([.int(0), .int(1), .int(2)])),
        .value(.array([.int(0), .int(2)])),
        .suffix(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = const Expression([
        .value(.array([.int(0), .int(1), .int(2)])),
        .value(.int(1)),
        .get(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.int(1));

      expr = const Expression([
        .value(.array([.int(0), .int(1), .int(2)])),
        .value(.int(3)),
        .get(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.nil());

      final p = symbols.insert('param');

      expr = Expression([
        const .value(.array([.int(1), .int(2)])),
        .closure(
          params: [p],
          ops: [
            .value(.variable(p)),
            const .value(.int(0)),
            const .greaterThan(),
          ],
        ),
        const .all(),
      ]);

      printOnFailure('expression all: ${expr.stringify(symbols)}');

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression([
        const .value(.array([.int(1), .int(2)])),
        .closure(
          params: [p],
          ops: [.value(.variable(p)), const .value(.int(0)), const .equal()],
        ),
        const .any(),
      ]);

      printOnFailure('expression any: ${expr.stringify(symbols)}');

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));
    });

    test('map', () {
      final symbols = SymbolTable();
      final p = symbols.insert('param');
      final tmpSymbols = TemporarySymbolTable(symbols);

      var expr = Expression([
        .value(
          .map(
            .of({
              const .str(.new(1)): const .int(0),
              const .str(.new(2)): const .int(1),
            }),
          ),
        ),
        .value(
          .map(
            .of({
              const .str(.new(2)): const .int(1),
              const .str(.new(1)): const .int(0),
            }),
          ),
        ),
        const .equal(),
      ]);

      var res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression([
        .value(
          .map(
            .of({
              const .str(.new(1)): const .int(0),
              const .str(.new(2)): const .int(1),
            }),
          ),
        ),
        .value(.map(.of({const .str(.new(1)): const .int(0)}))),
        const .equal(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = Expression([
        .value(
          .map(
            .of({
              const .str(.new(1)): const .int(0),
              const .str(.new(2)): const .int(1),
            }),
          ),
        ),
        const .value(.str(.new(1))),
        const .contains(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression([
        .value(
          .map(
            .of({
              const .str(.new(1)): const .int(0),
              const .str(.new(2)): const .int(1),
            }),
          ),
        ),
        const .value(.int(0)),
        const .contains(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = Expression([
        .value(
          .map(
            .of({
              const .str(.new(1)): const .int(0),
              const .int(2): const .int(1),
            }),
          ),
        ),
        const .value(.str(.new(1))),
        const .get(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.int(0));

      expr = Expression([
        .value(
          .map(
            .of({
              const .str(.new(1)): const .int(0),
              const .int(2): const .int(1),
            }),
          ),
        ),
        const .value(.int(2)),
        const .get(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.int(1));

      expr = Expression([
        .value(
          .map(
            .of({
              const .str(.new(1)): const .int(0),
              const .str(.new(2)): const .int(1),
            }),
          ),
        ),
        const .value(.int(0)),
        const .get(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.nil());

      expr = Expression([
        .value(
          .map(
            .of({
              const .str(.new(1)): const .int(0),
              const .str(.new(2)): const .int(1),
            }),
          ),
        ),
        const .value(.str(.new(3))),
        const .get(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.nil());

      expr = Expression([
        .value(
          .map(
            .of({
              const .str(.new(1)): const .int(0),
              const .str(.new(2)): const .int(1),
            }),
          ),
        ),
        .closure(
          params: [p],
          ops: [
            .value(.variable(p)),
            const .value(.int(1)),
            const .get(),
            const .value(.int(2)),
            const .lessThan(),
          ],
        ),
        const .all(),
      ]);

      printOnFailure('expression all: ${expr.stringify(symbols)}');

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression([
        .value(
          .map(
            .of({
              const .str(.new(1)): const .int(0),
              const .str(.new(2)): const .int(1),
            }),
          ),
        ),
        .closure(
          params: [p],
          ops: [
            .value(.variable(p)),
            const .value(.int(0)),
            const .get(),
            const .value(.str(.new(1))),
            const .equal(),
          ],
        ),
        const .any(),
      ]);

      printOnFailure('expression any: ${expr.stringify(symbols)}');

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));
    });

    test('ffi', () {
      final symbols = SymbolTable();
      final i = symbols.insert('test');
      final j = symbols.insert('TeSt');

      final testBin = symbols.insert('test_bin');
      final testUn = symbols.insert('test_un');

      final testClosure = symbols.insert('test_closure');
      final testFn = symbols.insert('test_fn');
      final idFn = symbols.insert('id');

      final tmpSymbols = TemporarySymbolTable(symbols);

      final ops = <Op>[
        const .value(.int(60)),
        const .value(.int(0)),
        .binFfi(testBin),
        .value(.str(i)),
        .value(.str(j)),
        .binFfi(testBin),
        const .and(),
        const .value(.int(42)),
        .unFfi(testUn),
        const .and(),
        const .value(.int(42)),
        .unFfi(testClosure),
        const .and(),
        .value(.str(i)),
        .unFfi(testClosure),
        const .and(),
        const .value(.int(42)),
        .unFfi(testFn),
        const .and(),
        const .value(.int(42)),
        .unFfi(idFn),
        const .value(.int(42)),
        const .heterogeneousEqual(),
        const .and(),
        .value(.str(i)),
        .unFfi(idFn),
        .value(.str(i)),
        const .heterogeneousEqual(),
        const .and(),
        const .value(.bool(true)),
        .unFfi(idFn),
        const .value(.bool(true)),
        const .heterogeneousEqual(),
        const .and(),
        .value(.date(.fromMillisecondsSinceEpoch(0))),
        .unFfi(idFn),
        .value(.date(.fromMillisecondsSinceEpoch(0))),
        const .heterogeneousEqual(),
        const .and(),
        .value(.bytes(.fromList([42]))),
        .unFfi(idFn),
        .value(.bytes(.fromList([42]))),
        const .heterogeneousEqual(),
        const .and(),
        const .value(.nil()),
        .unFfi(idFn),
        const .value(.nil()),
        const .heterogeneousEqual(),
        const .and(),
        const .value(.array([.nil()])),
        .unFfi(idFn),
        const .value(.array([.nil()])),
        const .heterogeneousEqual(),
        const .and(),
        .value(.set(.of(const {.nil()}))),
        .unFfi(idFn),
        .value(.set(.of(const {.nil()}))),
        const .heterogeneousEqual(),
        const .and(),
        .value(
          .map(.of({const .int(42): const .nil(), .str(i): const .nil()})),
        ),
        .unFfi(idFn),
        .value(
          .map(.of({const .int(42): const .nil(), .str(i): const .nil()})),
        ),
        const .heterogeneousEqual(),
        const .and(),
      ];

      final values = HashMap<SymbolId, Term>();
      final expr = Expression(ops);
      final externFunctions = HashMap<String, ExternFn>();

      externFunctions['test_bin'] = ExternFn(({required left, right}) {
        switch ((left, right)) {
          case (b.IntTerm(value: final l), b.IntTerm(value: final r)):
            printOnFailure('$l $r');
            return .bool((l % 60) == (r % 60));

          case (b.StrTerm(value: final l), b.StrTerm(value: final r)):
            printOnFailure('$l $r');
            return .bool(l.toLowerCase() == r.toLowerCase());

          default:
            throw 'Expected two strings or two integers';
        }
      });

      externFunctions['test_un'] = ExternFn(({required left, right}) {
        switch ((left, right)) {
          case (b.IntTerm(:final value), null):
            return .bool(value == 42);

          default:
            throw 'expected a single integer';
        }
      });

      externFunctions['id'] = ExternFn(({required left, right}) {
        if (right == null) return left;
        throw 'expected a single value';
      });

      externFunctions['test_closure'] = ExternFn(({required left, right}) {
        switch ((left, right)) {
          case (b.IntTerm(:final value), null):
            return .bool(value == 42);

          case (b.StrTerm(:final value), null):
            return .bool(value == 'test');

          default:
            throw 'expected a single integer';
        }
      });

      externFunctions['test_fn'] = ExternFn(
        ({required left, right}) => const .bool(true),
      );

      final res = expr.eval(values, tmpSymbols, externFunctions);

      expect(res, const Term.bool(true));
    });

    test('try_or', () {
      final symbols = SymbolTable();
      final tmpSymbols = TemporarySymbolTable(symbols);

      var expr = const Expression([
        .closure(
          params: [],
          ops: [
            .value(.bool(true)),
            .value(.int(0)),
            .greaterThan(),
            .parens(),
          ],
        ),
        .value(.bool(false)),
        .tryOr(),
      ]);

      printOnFailure('expression1: ${expr.stringify(symbols)}');

      var res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = const Expression([
        .closure(
          params: [],
          ops: [.value(.int(0)), .value(.int(0)), .equal(), .parens()],
        ),
        .value(.bool(false)),
        .tryOr(),
      ]);

      printOnFailure('expression2: ${expr.stringify(symbols)}');

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));
    });
  });
}
