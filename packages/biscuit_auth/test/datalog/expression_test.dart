// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/datalog/expression/expression.dart';
import 'package:biscuit_auth/datalog/expression/op.dart';
import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/error.dart';
import 'package:biscuit_auth/parser/builder/expression/op.dart' as b;
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
        .int(1),
        .variable(.new(2)),
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

      for (final (op, val1, val2, expected) in const <(Binary, int, int, int)>[
        (.bitwiseAnd(), 9, 10, 8),
        (.bitwiseAnd(), 9, 1, 1),
        (.bitwiseAnd(), 9, 0, 0),
        (.bitwiseOr(), 1, 2, 3),
        (.bitwiseOr(), 2, 2, 2),
        (.bitwiseOr(), 2, 0, 2),
        (.bitwiseXor(), 1, 0, 1),
        (.bitwiseXor(), 1, 1, 0),
      ]) {
        final ops = <Op>[.int(val1), .int(val2), op];

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

      var expr = Expression(const [.int(1), .int(0), .div()]);

      expect(
        () => expr.eval(.identity(), tmpSymbols, .identity()),
        throwsA(const ExecutionError.divisionByZero()),
      );

      expr = Expression(const [.int(1), .int(SymbolId.max), .add()]);

      expect(
        () => expr.eval(.identity(), tmpSymbols, .identity()),
        throwsA(const ExecutionError.overflow()),
      );

      expr = Expression(const [.int(-10), .int(SymbolId.max), .sub()]);

      expect(
        () => expr.eval(.identity(), tmpSymbols, .identity()),
        throwsA(const ExecutionError.overflow()),
      );

      expr = Expression(const [.int(2), .int(SymbolId.max), .mul()]);

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

      var expr = Expression(const [
        .int(-1),
        .variable(.new(1026)),
        .lessThan(),
      ]);

      expect(expr.stringify(symbols), '-1 < \$var1');

      expr = Expression(const [.int(1), .int(2), .int(3), .add(), .lessThan()]);

      expect(expr.stringify(symbols), '1 < 2 + 3');

      expr = Expression(const [.int(1), .int(2), .add(), .int(3), .lessThan()]);

      expect(expr.stringify(symbols), '1 + 2 < 3');
    });

    test('null equal', () {
      final symbols = SymbolTable();
      final tmpSymbols = TemporarySymbolTable(symbols);

      const operands = <Op>[.nil(), .nil()];
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

      const operands = <Op>[.nil(), .nil()];
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

      const operands = <Op>[.nil(), .int(1)];
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
        const [.bool(true), .int(1)],
        const [.bool(true), .str(.new(1))],
        const [.int(1), .str(.new(1))],
        [
          .set(.of({const .int(1)})),
          .set(.of({const .str(.new(1))})),
        ],
        [.bytes(.new(0)), const .int(1)],
        [.bytes(.new(0)), const .str(.new(1025))],
        [.date(.fromMillisecondsSinceEpoch(12)), const .int(1)],
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
        const [Term.bool(true), .int(1)],
        const [Term.bool(true), .str(.new(1))],
        const [.int(1), .str(.new(1))],
        [.bytes(.new(0)), const .int(1)],
        [.bytes(.new(0)), const .str(.new(1025))],
        [.date(.fromMillisecondsSinceEpoch(12)), const .int(1)],
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

      final expr = Expression(const [
        .bool(false),
        .closure(
          params: [],
          ops: [
            .bool(true),
            .closure(params: [], ops: [.bool(true)]),
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
        .set(.of({const .bool(false), const .bool(true)})),
        .closure(params: [p], ops: [.variable(p)]),
        const .any(),
      ]);

      printOnFailure('expression1: ${expr.stringify(symbols)}');

      var res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression([
        .set(.of({const .int(1), const .int(2)})),
        .closure(
          params: [p],
          ops: [.variable(p), const .int(0), const .lessThan()],
        ),
        const .any(),
      ]);

      printOnFailure('expression2: ${expr.stringify(symbols)}');

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = Expression([
        .set(.of({const .int(1), const .int(2)})),
        .closure(params: [p], ops: const [.int(0)]),
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
        .set(.of({const .int(1), const .int(2)})),
        .closure(
          params: [p],
          ops: [.variable(p), const .int(0), const .greaterThan()],
        ),
        const .all(),
      ]);

      printOnFailure('expression1: ${expr.stringify(symbols)}');

      var res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression([
        .set(.of({const .int(1), const .int(2)})),
        .closure(
          params: [p],
          ops: [.variable(p), const .int(0), const .lessThan()],
        ),
        const .all(),
      ]);

      printOnFailure('expression2: ${expr.stringify(symbols)}');

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = Expression([
        .set(.of({const .int(1), const .int(2)})),
        .closure(params: [p], ops: const [.int(0)]),
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
        .set(.of({const .int(1), const .int(2), const .int(3)})),
        .closure(
          params: [p],
          ops: [
            .variable(p),
            const .int(1),
            const .greaterThan(),
            .closure(
              params: [],
              ops: [
                .set(.of({const .int(3), const .int(4), const .int(5)})),
                .closure(
                  params: [q],
                  ops: [.variable(p), .variable(q), const .equal()],
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
        .set(.of({const .int(1), const .int(2)})),
        .closure(
          params: [p],
          ops: [.variable(p), const .int(0), const .greaterThan()],
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
        .set(.of({const .int(1), const .int(2), const .int(3)})),
        .closure(
          params: [p],
          ops: [
            .variable(p),
            const .int(1),
            const .greaterThan(),
            .closure(
              params: [],
              ops: [
                .set(.of({const .int(3), const .int(4), const .int(5)})),
                .closure(
                  params: [p],
                  ops: [.variable(p), .variable(p), const .equal()],
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

      var expr = Expression(const [
        .array([.int(0), .int(1)]),
        .array([.int(0), .int(1)]),
        .equal(),
      ]);

      var res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression(const [
        .array([.int(0), .int(1)]),
        .array([.int(0)]),
        .equal(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = Expression(const [
        .array([.int(0), .int(1)]),
        .int(1),
        .contains(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression(const [
        .array([.int(0), .int(1)]),
        .int(2),
        .contains(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = Expression(const [
        .array([.int(0), .int(1), .int(2)]),
        .array([.int(0), .int(1)]),
        .prefix(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression(const [
        .array([.int(0), .int(1), .int(2)]),
        .array([.int(2), .int(1)]),
        .prefix(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = Expression(const [
        .array([.int(0), .int(1), .int(2)]),
        .array([.int(1), .int(2)]),
        .suffix(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression(const [
        .array([.int(0), .int(1), .int(2)]),
        .array([.int(0), .int(2)]),
        .suffix(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = Expression(const [
        .array([.int(0), .int(1), .int(2)]),
        .int(1),
        .get(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.int(1));

      expr = Expression(const [
        .array([.int(0), .int(1), .int(2)]),
        .int(3),
        .get(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.nil());

      final p = symbols.insert('param');

      expr = Expression([
        const .array([.int(1), .int(2)]),
        .closure(
          params: [p],
          ops: [.variable(p), const .int(0), const .greaterThan()],
        ),
        const .all(),
      ]);

      printOnFailure('expression all: ${expr.stringify(symbols)}');

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression([
        const .array([.int(1), .int(2)]),
        .closure(
          params: [p],
          ops: [.variable(p), const .int(0), const .equal()],
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
        .map(
          .of({
            const .str(.new(1)): const .int(0),
            const .str(.new(2)): const .int(1),
          }),
        ),
        .map(
          .of({
            const .str(.new(2)): const .int(1),
            const .str(.new(1)): const .int(0),
          }),
        ),
        const .equal(),
      ]);

      var res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression([
        .map(
          .of({
            const .str(.new(1)): const .int(0),
            const .str(.new(2)): const .int(1),
          }),
        ),
        .map(.of({const .str(.new(1)): const .int(0)})),
        const .equal(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = Expression([
        .map(
          .of({
            const .str(.new(1)): const .int(0),
            const .str(.new(2)): const .int(1),
          }),
        ),
        const .str(.new(1)),
        const .contains(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression([
        .map(
          .of({
            const .str(.new(1)): const .int(0),
            const .str(.new(2)): const .int(1),
          }),
        ),
        const .int(0),
        const .contains(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = Expression([
        .map(
          .of({
            const .str(.new(1)): const .int(0),
            const .int(2): const .int(1),
          }),
        ),
        const .str(.new(1)),
        const .get(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.int(0));

      expr = Expression([
        .map(
          .of({
            const .str(.new(1)): const .int(0),
            const .int(2): const .int(1),
          }),
        ),
        const .int(2),
        const .get(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.int(1));

      expr = Expression([
        .map(
          .of({
            const .str(.new(1)): const .int(0),
            const .str(.new(2)): const .int(1),
          }),
        ),
        const .int(0),
        const .get(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.nil());

      expr = Expression([
        .map(
          .of({
            const .str(.new(1)): const .int(0),
            const .str(.new(2)): const .int(1),
          }),
        ),
        const .str(.new(3)),
        const .get(),
      ]);

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.nil());

      expr = Expression([
        .map(
          .of({
            const .str(.new(1)): const .int(0),
            const .str(.new(2)): const .int(1),
          }),
        ),
        .closure(
          params: [p],
          ops: [
            .variable(p),
            const .int(1),
            const .get(),
            const .int(2),
            const .lessThan(),
          ],
        ),
        const .all(),
      ]);

      printOnFailure('expression all: ${expr.stringify(symbols)}');

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));

      expr = Expression([
        .map(
          .of({
            const .str(.new(1)): const .int(0),
            const .str(.new(2)): const .int(1),
          }),
        ),
        .closure(
          params: [p],
          ops: [
            .variable(p),
            const .int(0),
            const .get(),
            const .str(.new(1)),
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
        const .int(60),
        const .int(0),
        .binFfi(testBin),
        .str(i),
        .str(j),
        .binFfi(testBin),
        const .and(),
        const .int(42),
        .unFfi(testUn),
        const .and(),
        const .int(42),
        .unFfi(testClosure),
        const .and(),
        .str(i),
        .unFfi(testClosure),
        const .and(),
        const .int(42),
        .unFfi(testFn),
        const .and(),
        const .int(42),
        .unFfi(idFn),
        const .int(42),
        const .heterogeneousEqual(),
        const .and(),
        .str(i),
        .unFfi(idFn),
        .str(i),
        const .heterogeneousEqual(),
        const .and(),
        const .bool(true),
        .unFfi(idFn),
        const .bool(true),
        const .heterogeneousEqual(),
        const .and(),
        .date(.fromMillisecondsSinceEpoch(0)),
        .unFfi(idFn),
        .date(.fromMillisecondsSinceEpoch(0)),
        const .heterogeneousEqual(),
        const .and(),
        .bytes(.fromList([42])),
        .unFfi(idFn),
        .bytes(.fromList([42])),
        const .heterogeneousEqual(),
        const .and(),
        const .nil(),
        .unFfi(idFn),
        const .nil(),
        const .heterogeneousEqual(),
        const .and(),
        const .array([.nil()]),
        .unFfi(idFn),
        const .array([.nil()]),
        const .heterogeneousEqual(),
        const .and(),
        .set(.of(const {.nil()})),
        .unFfi(idFn),
        .set(.of(const {.nil()})),
        const .heterogeneousEqual(),
        const .and(),
        .map(.of({const .int(42): const .nil(), .str(i): const .nil()})),
        .unFfi(idFn),
        .map(.of({const .int(42): const .nil(), .str(i): const .nil()})),
        const .heterogeneousEqual(),
        const .and(),
      ];

      final values = HashMap<SymbolId, Term>();
      final expr = Expression(ops);
      final externFunctions = HashMap<String, ExternFn>();

      externFunctions['test_bin'] = ExternFn(({required left, right}) {
        switch ((left, right)) {
          case (b.Int(value: final l), b.Int(value: final r)):
            printOnFailure('$l $r');
            return .bool((l % 60) == (r % 60));

          case (b.Str(value: final l), b.Str(value: final r)):
            printOnFailure('$l $r');
            return .bool(l.toLowerCase() == r.toLowerCase());

          default:
            throw 'Expected two strings or two integers';
        }
      });

      externFunctions['test_un'] = ExternFn(({required left, right}) {
        switch ((left, right)) {
          case (b.Int(:final value), null):
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
          case (b.Int(:final value), null):
            return .bool(value == 42);

          case (b.Str(:final value), null):
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

      var expr = Expression(const [
        .closure(
          params: [],
          ops: [.bool(true), .int(0), .greaterThan(), .parens()],
        ),
        .bool(false),
        .tryOr(),
      ]);

      printOnFailure('expression1: ${expr.stringify(symbols)}');

      var res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(false));

      expr = Expression(const [
        .closure(params: [], ops: [.int(0), .int(0), .equal(), .parens()]),
        .bool(false),
        .tryOr(),
      ]);

      printOnFailure('expression2: ${expr.stringify(symbols)}');

      res = expr.eval(.identity(), tmpSymbols, .identity());

      expect(res, const Term.bool(true));
    });
  });
}
