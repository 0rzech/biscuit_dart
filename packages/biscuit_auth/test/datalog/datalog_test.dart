// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/datalog/fact.dart';
import 'package:biscuit_auth/datalog/origin.dart';
import 'package:biscuit_auth/datalog/rule.dart';
import 'package:biscuit_auth/datalog/run_limits.dart';
import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:biscuit_auth/datalog/world.dart';
import 'package:test/test.dart';

void main() {
  group('datalog', () {
    late World world;
    late SymbolTable symbols;

    setUp(() {
      world = .new();
      symbols = .new();
    });

    test('family', () {
      final a = symbols.add('A');
      final b = symbols.add('B');
      final c = symbols.add('C');
      final d = symbols.add('D');
      final e = symbols.add('e');
      final parent = symbols.insert('parent');
      final grandparent = symbols.insert('grandparent');

      world.addFact(factOrigin, .fromTerms(parent, [a, b]));
      world.addFact(factOrigin, .fromTerms(parent, [b, c]));
      world.addFact(factOrigin, .fromTerms(parent, [c, d]));

      final rule1 = Rule(
        headName: grandparent,
        headTerms: [
          variable(symbols, 'grandparent'),
          variable(symbols, 'grandchild'),
        ],
        predicates: [
          .new(parent, [
            variable(symbols, 'grandparent'),
            variable(symbols, 'parent'),
          ]),
          .new(parent, [
            variable(symbols, 'parent'),
            variable(symbols, 'grandchild'),
          ]),
        ],
      );
      printOnFailure('\nsymbols: $symbols\n');
      printOnFailure('testing rule1: $rule1\n');

      var result = world.queryRule(
        rule: rule1,
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );
      printOnFailure('grandparents query rules: $result\n');
      printOnFailure('current facts: ${world.stringify(symbols)}\n');

      final rule2 = Rule(
        headName: grandparent,
        headTerms: [
          variable(symbols, 'grandparent'),
          variable(symbols, 'grandchild'),
        ],
        predicates: [
          .new(parent, [
            variable(symbols, 'grandparent'),
            variable(symbols, 'parent'),
          ]),
          .new(parent, [
            variable(symbols, 'parent'),
            variable(symbols, 'grandchild'),
          ]),
        ],
      );

      printOnFailure('adding rule2: $rule2\n');
      world.addRule(ruleOrigin, scope, rule2);
      world.run(symbols, limits: runLimits);

      printOnFailure('parents:');
      result = world.queryRule(
        rule: .new(
          headName: parent,
          headTerms: [variable(symbols, 'parent'), variable(symbols, 'child')],
          predicates: [
            .new(parent, [
              variable(symbols, 'parent'),
              variable(symbols, 'child'),
            ]),
          ],
        ),
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );

      for (final (origin, fact) in result.trustedIterator(scope)) {
        printOnFailure('\t$origin\t${fact.predicate}');
      }

      result = world.queryRule(
        rule: .new(
          headName: parent,
          headTerms: [variable(symbols, 'parent'), b],
          predicates: [
            .new(parent, [variable(symbols, 'parent'), b]),
          ],
        ),
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );
      printOnFailure('\nparents of B: $result\n');

      result = world.queryRule(
        rule: .new(
          headName: grandparent,
          headTerms: [
            variable(symbols, 'grandparent'),
            variable(symbols, 'grandchild'),
          ],
          predicates: [
            .new(grandparent, [
              variable(symbols, 'grandparent'),
              variable(symbols, 'grandchild'),
            ]),
          ],
        ),
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );
      printOnFailure('grandparents $result\n');

      world.addFact(factOrigin, .fromTerms(parent, [c, e]));
      world.run(symbols, limits: runLimits);

      result = world.queryRule(
        rule: .new(
          headName: grandparent,
          headTerms: [
            variable(symbols, 'grandparent'),
            variable(symbols, 'grandchild'),
          ],
          predicates: [
            .new(grandparent, [
              variable(symbols, 'grandparent'),
              variable(symbols, 'grandchild'),
            ]),
          ],
        ),
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );
      printOnFailure('grandparents after inserting parent(C, E): $result\n');

      expect(
        result.all.map((entry) => entry.$2),
        unorderedEquals(<Fact>{
          .fromTerms(grandparent, [a, c]),
          .fromTerms(grandparent, [b, d]),
          .fromTerms(grandparent, [b, e]),
        }),
      );
    });

    test('numbers', () {
      final abc = symbols.add('abc');
      final def = symbols.add('def');
      final ghi = symbols.add('ghi');
      final jkl = symbols.add('jkl');
      final mno = symbols.add('mno');
      final aaa = symbols.add('AAA');
      final bbb = symbols.add('BBB');
      final ccc = symbols.add('CCC');
      final t1 = symbols.insert('t1');
      final t2 = symbols.insert('t2');
      final join = symbols.insert('join');

      world.addFact(factOrigin, .fromTerms(t1, [const .int(0), abc]));
      world.addFact(factOrigin, .fromTerms(t1, [const .int(1), def]));
      world.addFact(factOrigin, .fromTerms(t1, [const .int(2), ghi]));
      world.addFact(factOrigin, .fromTerms(t1, [const .int(3), jkl]));
      world.addFact(factOrigin, .fromTerms(t1, [const .int(4), mno]));

      world.addFact(
        factOrigin,
        .fromTerms(t2, [const .int(0), aaa, const .int(0)]),
      );
      world.addFact(
        factOrigin,
        .fromTerms(t2, [const .int(1), bbb, const .int(0)]),
      );
      world.addFact(
        factOrigin,
        .fromTerms(t2, [const .int(2), ccc, const .int(1)]),
      );

      var result = world.queryRule(
        rule: .new(
          headName: join,
          headTerms: [variable(symbols, 'left'), variable(symbols, 'right')],
          predicates: [
            .new(t1, [variable(symbols, 'id'), variable(symbols, 'left')]),
            .new(t2, [
              variable(symbols, 't2_id'),
              variable(symbols, 'right'),
              variable(symbols, 'id'),
            ]),
          ],
        ),
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );

      expect(result.all.map((tup) => tup.$2), <Fact>{
        .fromTerms(join, [abc, aaa]),
        .fromTerms(join, [abc, bbb]),
        .fromTerms(join, [def, ccc]),
      });

      // test constraints
      result = world.queryRule(
        rule: .withExpressions(
          headName: join,
          headTerms: [variable(symbols, 'left'), variable(symbols, 'right')],
          predicates: [
            .new(t1, [variable(symbols, 'id'), variable(symbols, 'left')]),
            .new(t2, [
              variable(symbols, 't2_id'),
              variable(symbols, 'right'),
              variable(symbols, 'id'),
            ]),
          ],
          expressions: [
            .new([variable(symbols, 'id'), const .int(1), const .lessThan()]),
          ],
        ),
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );

      expect(
        result.all.map((tup) => tup.$2),
        unorderedEquals(<Fact>{
          .fromTerms(join, [abc, aaa]),
          .fromTerms(join, [abc, bbb]),
        }),
      );
    });

    test('str', () {
      final app0 = symbols.add('app_0');
      final app1 = symbols.add('app_1');
      final app2 = symbols.add('app_2');
      final predName = symbols.insert('route');
      final headName = symbols.insert('route suffix');
      final example = symbols.add('example.com');
      final testCom = symbols.add('test.com');
      final testPl = symbols.add('test.pl');
      final wwwExample = symbols.add('www.example.com');
      final mxExample = symbols.add('mx.example.com');

      world.addFact(
        factOrigin,
        .fromTerms(predName, [const .int(0), app0, example]),
      );
      world.addFact(
        factOrigin,
        .fromTerms(predName, [const .int(1), app1, testCom]),
      );
      world.addFact(
        factOrigin,
        .fromTerms(predName, [const .int(2), app2, testPl]),
      );
      world.addFact(
        factOrigin,
        .fromTerms(predName, [const .int(3), app0, wwwExample]),
      );
      world.addFact(
        factOrigin,
        .fromTerms(predName, [const .int(4), app1, mxExample]),
      );

      Iterable<Fact> testSuffix({
        required World world,
        required SymbolTable symbols,
        required SymbolId headName,
        required SymbolId predName,
        required String suffix,
      }) => world
          .queryRule(
            rule: .withExpressions(
              headName: headName,
              headTerms: [
                variable(symbols, 'app_id'),
                variable(symbols, 'domain_name'),
              ],
              predicates: [
                .new(predName, [
                  variable(symbols, 'route_id'),
                  variable(symbols, 'app_id'),
                  variable(symbols, 'domain_name'),
                ]),
              ],
              expressions: [
                .new([
                  variable(symbols, 'domain_name'),
                  symbols.add(suffix),
                  const .suffix(),
                ]),
              ],
            ),
            origin: ruleOrigin,
            scope: scope,
            symbols: symbols,
          )
          .all
          .map((tup) => tup.$2);

      var result = testSuffix(
        world: world,
        symbols: symbols,
        headName: headName,
        predName: predName,
        suffix: '.pl',
      );

      expect(
        result,
        unorderedEquals(<Fact>{
          .fromTerms(headName, [app2, testPl]),
        }),
      );

      result = testSuffix(
        world: world,
        symbols: symbols,
        headName: headName,
        predName: predName,
        suffix: 'example.com',
      );

      expect(
        result,
        unorderedEquals(<Fact>{
          .fromTerms(headName, [app0, example]),
          .fromTerms(headName, [app0, wwwExample]),
          .fromTerms(headName, [app1, mxExample]),
        }),
      );
    });

    test('date constraint', () {
      final t1 = DateTime.now().toUtc();
      final t2 = t1.add(const .new(seconds: 10));
      final t3 = t2.add(const .new(seconds: 30));

      final abc = symbols.add('abc');
      final def = symbols.add('def');
      final x = symbols.insert('x');
      final before = symbols.insert('before');
      final after = symbols.insert('after');

      world.addFact(factOrigin, .fromTerms(x, [.date(t1), abc]));
      world.addFact(factOrigin, .fromTerms(x, [.date(t3), def]));

      var rule = Rule.withExpressions(
        headName: before,
        headTerms: [variable(symbols, 'date'), variable(symbols, 'val')],
        predicates: [
          .new(x, [variable(symbols, 'date'), variable(symbols, 'val')]),
        ],
        expressions: [
          .new([variable(symbols, 'date'), .date(t2), const .lessOrEqual()]),
          .new([
            variable(symbols, 'date'),
            .date(.fromMillisecondsSinceEpoch(0)),
            const .greaterOrEqual(),
          ]),
        ],
      );

      printOnFailure('\ntesting rule1: $rule\n');

      var result = world.queryRule(
        rule: rule,
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );

      expect(
        result.all.map((tup) => tup.$2),
        unorderedEquals(<Fact>{
          .fromTerms(before, [.date(t1), abc]),
        }),
      );

      rule = .withExpressions(
        headName: after,
        headTerms: [variable(symbols, 'date'), variable(symbols, 'val')],
        predicates: [
          .new(x, [variable(symbols, 'date'), variable(symbols, 'val')]),
        ],
        expressions: [
          .new([variable(symbols, 'date'), .date(t2), const .greaterOrEqual()]),
          .new([
            variable(symbols, 'date'),
            .date(.fromMillisecondsSinceEpoch(0)),
            const .greaterOrEqual(),
          ]),
        ],
      );

      printOnFailure('testing rule2: $rule\n');

      result = world.queryRule(
        rule: rule,
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );

      expect(
        result.all.map((tup) => tup.$2),
        unorderedEquals(<Fact>{
          .fromTerms(after, [.date(t3), def]),
        }),
      );
    });

    test('set constraint', () {
      final abc = symbols.add('abc');
      final def = symbols.add('def');
      final x = symbols.insert('x');
      final intSet = symbols.insert('int_set');
      final symbolSet = symbols.insert('symbol_set');
      final strSet = symbols.insert('string_set');
      final test = symbols.add('test');
      final hello = symbols.add('hello');
      final aaa = symbols.add('zzz');

      world.addFact(factOrigin, .new(.new(x, [abc, const .int(0), test])));
      world.addFact(factOrigin, .new(.new(x, [def, const .int(2), hello])));

      var result = world.queryRule(
        rule: .withExpressions(
          headName: intSet,
          headTerms: [variable(symbols, 'sym'), variable(symbols, 'str')],
          predicates: [
            .new(x, [
              variable(symbols, 'sym'),
              variable(symbols, 'int'),
              variable(symbols, 'str'),
            ]),
          ],
          expressions: [
            .new([
              .set(.of(const [.int(0), .int(1)])),
              variable(symbols, 'int'),
              const .contains(),
            ]),
          ],
        ),
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );

      expect(
        result.all.map((tup) => tup.$2),
        unorderedEquals(<Fact>{
          .fromTerms(intSet, [abc, test]),
        }),
      );

      result = world.queryRule(
        rule: .withExpressions(
          headName: symbolSet,
          headTerms: [
            variable(symbols, 'symbol'),
            variable(symbols, 'int'),
            variable(symbols, 'str'),
          ],
          predicates: [
            .new(x, [
              variable(symbols, 'symbol'),
              variable(symbols, 'int'),
              variable(symbols, 'str'),
            ]),
          ],
          expressions: [
            .new([
              .set(.of([abc, symbols.add('ghi')])),
              variable(symbols, 'symbol'),
              const .contains(),
              const .negate(),
            ]),
          ],
        ),
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );

      expect(
        result.all.map((tup) => tup.$2),
        unorderedEquals(<Fact>{
          .fromTerms(symbolSet, [def, const .int(2), hello]),
        }),
      );

      result = world.queryRule(
        rule: .withExpressions(
          headName: strSet,
          headTerms: [
            variable(symbols, 'sym'),
            variable(symbols, 'int'),
            variable(symbols, 'str'),
          ],
          predicates: [
            .new(x, [
              variable(symbols, 'sym'),
              variable(symbols, 'int'),
              variable(symbols, 'str'),
            ]),
          ],
          expressions: [
            .new([
              .set(.of([test, aaa])),
              variable(symbols, 'str'),
              const .contains(),
            ]),
          ],
        ),
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );

      expect(
        result.all.map((tup) => tup.$2),
        unorderedEquals(<Fact>{
          .fromTerms(strSet, [abc, const .int(0), test]),
        }),
      );
    });

    test('resource', () {
      final resource = symbols.insert('resource');
      final operation = symbols.insert('operation');
      final right = symbols.insert('right');
      final file1 = symbols.add('file1');
      final file2 = symbols.add('file2');
      final read = symbols.add('read');
      final write = symbols.add('write');
      final check1 = symbols.insert('check1');
      final check2 = symbols.insert('check2');

      world.addFact(factOrigin, .fromTerms(resource, [file2]));
      world.addFact(factOrigin, .fromTerms(operation, [write]));
      world.addFact(factOrigin, .fromTerms(right, [file1, read]));
      world.addFact(factOrigin, .fromTerms(right, [file2, read]));
      world.addFact(factOrigin, .fromTerms(right, [file1, write]));

      var result = world.queryRule(
        rule: .new(
          headName: check1,
          headTerms: [file1],
          predicates: [
            .new(resource, [file1]),
          ],
        ),
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );

      expect(result.all, isEmpty);
      expect(result.isEmpty(), true);

      result = world.queryRule(
        rule: .new(
          headName: check2,
          headTerms: [const .variable(.new(0))],
          predicates: [
            .new(resource, [const .variable(.new(0))]),
            .new(operation, [read]),
            .new(right, [const .variable(.new(0)), read]),
          ],
        ),
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );

      expect(result.all, isEmpty);
      expect(result.isEmpty(), true);
    });

    test('int expr', () {
      final abc = symbols.add('abc');
      final def = symbols.add('def');
      final x = symbols.insert('x');
      final lessThan = symbols.insert('less_than');

      world.addFact(factOrigin, .fromTerms(x, [const .int(-2), abc]));
      world.addFact(factOrigin, .fromTerms(x, [const .int(0), def]));

      final rule = Rule.withExpressions(
        headName: lessThan,
        headTerms: [variable(symbols, 'nb'), variable(symbols, 'val')],
        predicates: [
          .new(x, [variable(symbols, 'nb'), variable(symbols, 'val')]),
        ],
        expressions: [
          .new([
            const .int(5),
            const .int(-4),
            const .add(),
            const .int(-1),
            const .mul(),
            variable(symbols, 'nb'),
            const .lessThan(),
          ]),
        ],
      );

      printOnFailure('\nworld: ${world.stringify(symbols)}\n');
      printOnFailure('testing rule: $rule\n');

      final result = world.queryRule(
        rule: rule,
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );

      expect(
        result.all.map((tup) => tup.$2),
        unorderedEquals(<Fact>{
          .fromTerms(lessThan, [const .int(0), def]),
        }),
      );
    });

    test('unbound variables', () {
      final operation = symbols.insert('operation');
      final check = symbols.insert('check');
      final read = symbols.add('read');
      final write = symbols.add('write');
      final unbound = variable(symbols, 'unbound');
      final any1 = variable(symbols, 'any1');
      final any2 = variable(symbols, 'any2');

      world.addFact(factOrigin, .fromTerms(operation, [write]));

      var rule = Rule(
        headName: operation,
        headTerms: [unbound, read],
        predicates: [
          .new(operation, [any1, any2]),
        ],
      );

      printOnFailure('\nworld: ${world.stringify(symbols)}\n');
      printOnFailure('testing rule1: $rule\n');

      var result = world.queryRule(
        rule: rule,
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );

      expect(result.all, isEmpty);
      expect(result.isEmpty(), true);

      // Operation($unbound, "read") should not have been generated. In case
      // it is generated though, verify that rule application will not match it.
      world.addFact(factOrigin, .fromTerms(operation, [unbound, read]));

      rule = Rule(
        headName: check,
        headTerms: [read],
        predicates: [
          .new(operation, [read]),
        ],
      );

      printOnFailure('world: ${world.stringify(symbols)}\n');
      printOnFailure('testing rule2: $rule\n');

      result = world.queryRule(
        rule: rule,
        origin: ruleOrigin,
        scope: scope,
        symbols: symbols,
      );

      expect(result.all, isEmpty);
      expect(result.isEmpty(), true);
    });
  });
}

const ruleOrigin = SymbolId(0);
final factOrigin = Origin.of(const [.new(0)]);
final scope = TrustedOrigins.of(const [.new(0)]);
final runLimits = RunLimits(maxTime: const .new(seconds: 10));
