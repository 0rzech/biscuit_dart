// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/parser/builder/check.dart';
import 'package:biscuit_auth/parser/builder/expression/op.dart';
import 'package:biscuit_auth/parser/builder/fact.dart';
import 'package:biscuit_auth/parser/builder/policy.dart';
import 'package:biscuit_auth/parser/builder/rule.dart';
import 'package:biscuit_auth/parser/builder/term.dart';
import 'package:biscuit_auth/parser/expression.dart';
import 'package:biscuit_auth/parser/grammar.dart';
import 'package:kiri_check/kiri_check.dart';
import 'package:petitparser/core.dart';
import 'package:petitparser/parser.dart' as p;
import 'package:test/test.dart';

void main() {
  group(DatalogGrammar, () {
    late DatalogGrammar datalog;

    setUp(() => datalog = const .new());

    property('name', () {
      late Parser<String> parser;

      forAll(variableArbitrary(), (name) {
        expectSuccess(parser.parse('$name("read")'), name);
      }, setUpAll: () => parser = datalog.buildFrom(datalog.name()));
    });

    property('string', () {
      late Parser<Term> parser;

      forAll(stringArbitrary(), (tup) {
        expectSuccess(parser.parse('"${tup.string}"'), Term.str(tup.expected));
      }, setUpAll: () => parser = datalog.buildFrom(datalog.str()));
    });

    property('integer', () {
      late Parser<Term> parser;

      forAll(integer(), (i) {
        expectSuccess(parser.parse(i.toString()), Term.int(i));
      }, setUpAll: () => parser = datalog.buildFrom(datalog.integer()));
    });

    property('date', () {
      late Parser<Term> parser;

      forAll(dateTime(), (date) {
        expectSuccess(parser.parse(date.toIso8601String()), Term.date(date));
      }, setUpAll: () => parser = datalog.buildFrom(datalog.date()));
    });

    property('variable', () {
      late Parser<Term> parser;

      forAll(variableArbitrary(), (variable) {
        expectSuccess(parser.parse('\$$variable'), Term.variable(variable));
      }, setUpAll: () => parser = datalog.buildFrom(datalog.variable()));
    });

    property('parameter', () {
      late Parser<Term> parser;

      forAll(
        combine2(
          string(minLength: 1, maxLength: 1, characterSet: .letter(.ascii)),
          string(characterSet: .alphanum(.ascii)..addCharacters('_:')),
        ).map((tup) => '${tup.$1}${tup.$2}'),
        (string) {
          expectSuccess(parser.parse('{$string}'), Term.parameter(string));
        },
        setUpAll: () => parser = datalog.buildFrom(datalog.parameter()),
      );
    });

    group('constraint', () {
      late Parser<List<Op>> parser;

      setUp(() {
        parser = datalog.buildFrom(
          datalog.expr().map((expr) => expr.toOpcodes()),
        );
      });

      property('variable lessOrEqual to date', () {
        forAll(combine2(variableArbitrary(), dateTime()), (tup) {
          final result = parser.parse(
            '\$${tup.$1} <= ${tup.$2.toIso8601String()}',
          );

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.date(tup.$2)),
            const .lessOrEqual(),
          ]);
        });
      });

      property('variable greaterOrEqual to date', () {
        forAll(combine2(variableArbitrary(), dateTime()), (tup) {
          final result = parser.parse(
            '\$${tup.$1} >= ${tup.$2.toIso8601String()}',
          );

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.date(tup.$2)),
            const .greaterOrEqual(),
          ]);
        });
      });

      property('variable lessThan integer', () {
        forAll(combine2(variableArbitrary(), integer()), (tup) {
          final result = parser.parse('\$${tup.$1} < ${tup.$2}');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.int(tup.$2)),
            const .lessThan(),
          ]);
        });
      });

      property('variable greaterThan integer', () {
        forAll(combine2(variableArbitrary(), integer()), (tup) {
          final result = parser.parse('\$${tup.$1} > ${tup.$2}');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.int(tup.$2)),
            const .greaterThan(),
          ]);
        });
      });

      property('variable lessOrEqual to integer', () {
        forAll(combine2(variableArbitrary(), integer()), (tup) {
          final result = parser.parse('\$${tup.$1} <= ${tup.$2}');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.int(tup.$2)),
            const .lessOrEqual(),
          ]);
        });
      });

      property('variable greaterOrEqual to integer', () {
        forAll(combine2(variableArbitrary(), integer()), (tup) {
          final result = parser.parse('\$${tup.$1} >= ${tup.$2}');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.int(tup.$2)),
            const .greaterOrEqual(),
          ]);
        });
      });

      property('variable equal to integer', () {
        forAll(combine2(variableArbitrary(), integer()), (tup) {
          final result = parser.parse('\$${tup.$1} === ${tup.$2}');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.int(tup.$2)),
            const .equal(),
          ]);
        });
      });

      property('variable heterogeneousEqual to integer', () {
        forAll(combine2(variableArbitrary(), integer()), (tup) {
          final result = parser.parse('\$${tup.$1} == ${tup.$2}');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.int(tup.$2)),
            const .heterogeneousEqual(),
          ]);
        });
      });

      property('variable notEqual to integer', () {
        forAll(combine2(variableArbitrary(), integer()), (tup) {
          final result = parser.parse('\$${tup.$1} !== ${tup.$2}');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.int(tup.$2)),
            const .notEqual(),
          ]);
        });
      });

      property('variable heterogeneousNotEqual to integer', () {
        forAll(combine2(variableArbitrary(), integer()), (tup) {
          final result = parser.parse('\$${tup.$1} != ${tup.$2}');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.int(tup.$2)),
            const .heterogeneousNotEqual(),
          ]);
        });
      });

      property('variable.length() equal to variable', () {
        forAll(
          combine2(variableArbitrary(), variableArbitrary()),
          (tup) {
            final result = parser.parse('\$${tup.$1}.length() === \$${tup.$2}');

            expectSuccess(result, <Op>[
              .value(.variable(tup.$1)),
              const .length(),
              .value(.variable(tup.$2)),
              const .equal(),
            ]);
          },
          setUp: () => parser = datalog.buildFrom(
            datalog.expr().map((expr) => expr.toOpcodes()),
          ),
        );
      });

      property('variable.length() heterogeneousEqual to variable', () {
        forAll(combine2(variableArbitrary(), variableArbitrary()), (tup) {
          final result = parser.parse('\$${tup.$1}.length() == \$${tup.$2}');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            const .length(),
            .value(.variable(tup.$2)),
            const .heterogeneousEqual(),
          ]);
        });
      });

      property('variable.length() notEqual to variable', () {
        forAll(combine2(variableArbitrary(), variableArbitrary()), (tup) {
          final result = parser.parse('\$${tup.$1}.length() !== \$${tup.$2}');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            const .length(),
            .value(.variable(tup.$2)),
            const .notEqual(),
          ]);
        });
      });

      property('variable.length() heterogeneousNotEqual to variable', () {
        forAll(
          combine2(variableArbitrary(), variableArbitrary()),
          (tup) {
            final result = parser.parse('\$${tup.$1}.length() != \$${tup.$2}');

            expectSuccess(result, <Op>[
              .value(.variable(tup.$1)),
              const .length(),
              .value(.variable(tup.$2)),
              const .heterogeneousNotEqual(),
            ]);
          },
          setUp: () => parser = datalog.buildFrom(
            datalog.expr().map((expr) => expr.toOpcodes()),
          ),
        );
      });

      property('negate variable equal to variable', () {
        forAll(combine2(variableArbitrary(), variableArbitrary()), (tup) {
          final result = parser.parse('!\$${tup.$1} === \$${tup.$2}');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            const .negate(),
            .value(.variable(tup.$2)),
            const .equal(),
          ]);
        });
      });

      property('negate variable heterogeneousEqual to variable', () {
        forAll(combine2(variableArbitrary(), variableArbitrary()), (tup) {
          final result = parser.parse('!\$${tup.$1} == \$${tup.$2}');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            const .negate(),
            .value(.variable(tup.$2)),
            const .heterogeneousEqual(),
          ]);
        });
      });

      property('negate variable notEqual to variable', () {
        forAll(combine2(variableArbitrary(), variableArbitrary()), (tup) {
          final result = parser.parse('!\$${tup.$1} !== \$${tup.$2}');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            const .negate(),
            .value(.variable(tup.$2)),
            const .notEqual(),
          ]);
        });
      });

      property('negate variable heterogeneousNotEqual to variable', () {
        forAll(combine2(variableArbitrary(), variableArbitrary()), (tup) {
          final result = parser.parse('!\$${tup.$1} != \$${tup.$2}');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            const .negate(),
            .value(.variable(tup.$2)),
            const .heterogeneousNotEqual(),
          ]);
        });
      });

      property('negate bool and bool', () {
        forAll(combine2(boolean(), boolean()), (tup) {
          final result = parser.parse('!${tup.$1} && ${tup.$2}');

          expectSuccess(result, <Op>[
            .value(.bool(tup.$1)),
            const .negate(),
            .closure(params: const [], ops: [.value(.bool(tup.$2))]),
            const .lazyAnd(),
          ]);
        });
      });

      property('bool or bool and bool', () {
        forAll(combine3(boolean(), boolean(), boolean()), (tup) {
          final result = parser.parse('${tup.$1} || ${tup.$2} && ${tup.$3}');

          expectSuccess(result, <Op>[
            .value(.bool(tup.$1)),
            .closure(
              params: const [],
              ops: [
                .value(.bool(tup.$2)),
                .closure(params: const [], ops: [.value(.bool(tup.$3))]),
                const .lazyAnd(),
              ],
            ),
            const .lazyOr(),
          ]);
        });
      });

      property('integer greaterThan integer and equal to integer', () {
        forAll(combine3(integer(), integer(), integer()), (tup) {
          var result = parser.parse('(${tup.$1} > ${tup.$2}) === ${tup.$3}');

          expectSuccess(result, <Op>[
            .value(.int(tup.$1)),
            .value(.int(tup.$2)),
            const .greaterThan(),
            const .parens(),
            .value(.int(tup.$3)),
            const .equal(),
          ]);

          result = parser.parse('${tup.$1} > ${tup.$2} === ${tup.$3}');

          expectFailure(result, startsWith('Associative'));
        });
      });

      property('integer greaterThan integer '
          'and heterogeneousEqual to integer', () {
        forAll(combine3(integer(), integer(), integer()), (tup) {
          var result = parser.parse('(${tup.$1} > ${tup.$2}) == ${tup.$3}');

          expectSuccess(result, <Op>[
            .value(.int(tup.$1)),
            .value(.int(tup.$2)),
            const .greaterThan(),
            const .parens(),
            .value(.int(tup.$3)),
            const .heterogeneousEqual(),
          ]);

          result = parser.parse('${tup.$1} > ${tup.$2} == ${tup.$3}');

          expectFailure(result, startsWith('Associative'));
        });
      });

      property('integer greaterThan integer and notEqual to integer', () {
        forAll(combine3(integer(), integer(), integer()), (tup) {
          var result = parser.parse('(${tup.$1} > ${tup.$2}) !== ${tup.$3}');

          expectSuccess(result, <Op>[
            .value(.int(tup.$1)),
            .value(.int(tup.$2)),
            const .greaterThan(),
            const .parens(),
            .value(.int(tup.$3)),
            const .notEqual(),
          ]);

          result = parser.parse('${tup.$1} > ${tup.$2} !== ${tup.$3}');

          expectFailure(result, startsWith('Associative'));
        });
      });

      property('integer greaterThan integer '
          'and heterogeneousNotEqual to integer', () {
        forAll(combine3(integer(), integer(), integer()), (tup) {
          var result = parser.parse('(${tup.$1} > ${tup.$2}) != ${tup.$3}');

          expectSuccess(result, <Op>[
            .value(.int(tup.$1)),
            .value(.int(tup.$2)),
            const .greaterThan(),
            const .parens(),
            .value(.int(tup.$3)),
            const .heterogeneousNotEqual(),
          ]);

          result = parser.parse('${tup.$1} > ${tup.$2} != ${tup.$3}');

          expectFailure(result, startsWith('Associative'));
        });
      });

      property('integer greaterThan sum of integers', () {
        forAll(combine3(integer(), integer(), integer()), (tup) {
          final result = parser.parse('${tup.$1} > ${tup.$2} + ${tup.$3}');

          expectSuccess(result, <Op>[
            .value(.int(tup.$1)),
            .value(.int(tup.$2)),
            .value(.int(tup.$3)),
            const .add(),
            const .greaterThan(),
          ]);
        });
      });

      property('set of integers contains variable', () {
        forAll(
          combine4(
            integer(),
            integer(),
            integer(),
            variableArbitrary(),
          ).filter((tup) => tup.$1 != tup.$2 && tup.$2 != tup.$3),
          (tup) {
            final result = parser.parse(
              '{${tup.$1}, ${tup.$2}, ${tup.$3}}.contains(\$${tup.$4})',
            );

            expectSuccess(result, <Op>[
              .value(.set(.of([.int(tup.$1), .int(tup.$2), .int(tup.$3)]))),
              .value(.variable(tup.$4)),
              const .contains(),
            ]);
          },
        );
      });

      property('negate set of integers contains variable', () {
        forAll(
          combine4(
            integer(),
            integer(),
            integer(),
            variableArbitrary(),
          ).filter((tup) => tup.$1 != tup.$2 && tup.$2 != tup.$3),
          (tup) {
            final result = parser.parse(
              '!{${tup.$1}, ${tup.$2}, ${tup.$3}}.contains(\$${tup.$4})',
            );

            expectSuccess(result, <Op>[
              .value(.set(.of([.int(tup.$1), .int(tup.$2), .int(tup.$3)]))),
              .value(.variable(tup.$4)),
              const .contains(),
              const .negate(),
            ]);
          },
        );
      });

      property('set of dates contains date', () {
        forAll(
          combine3(dateTime(), dateTime(), dateTime()).filter((tup) {
            return tup.$1 != tup.$2 && tup.$2 != tup.$3;
          }),
          (tup) {
            final same = tup.$1.toIso8601String();
            final result = parser.parse(
              '{$same, ${tup.$2.toIso8601String()}, ${tup.$3.toIso8601String()}}'
              '.contains($same)',
            );

            expectSuccess(result, <Op>[
              .value(.set(.of([.date(tup.$1), .date(tup.$2), .date(tup.$3)]))),
              .value(.date(tup.$1)),
              const .contains(),
            ]);
          },
        );
      });

      property('variable equals string', () {
        forAll(combine2(variableArbitrary(), stringArbitrary()), (tup) {
          final result = parser.parse('\$${tup.$1} === "${tup.$2.string}"');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.str(tup.$2.expected)),
            const .equal(),
          ]);
        });
      });

      property('variable heterogeneousEqual to string', () {
        forAll(combine2(variableArbitrary(), stringArbitrary()), (tup) {
          final result = parser.parse('\$${tup.$1} == "${tup.$2.string}"');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.str(tup.$2.expected)),
            const .heterogeneousEqual(),
          ]);
        });
      });

      property('variable notEqual to string', () {
        forAll(combine2(variableArbitrary(), stringArbitrary()), (tup) {
          final result = parser.parse('\$${tup.$1} !== "${tup.$2.string}"');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.str(tup.$2.expected)),
            const .notEqual(),
          ]);
        });
      });

      property('variable heterogeneousEqual to string', () {
        forAll(combine2(variableArbitrary(), stringArbitrary()), (tup) {
          final result = parser.parse('\$${tup.$1} != "${tup.$2.string}"');

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.str(tup.$2.expected)),
            const .heterogeneousNotEqual(),
          ]);
        });
      });

      property('variable ends_with string', () {
        forAll(combine2(variableArbitrary(), stringArbitrary()), (tup) {
          final result = parser.parse(
            '\$${tup.$1}.ends_with("${tup.$2.string}")',
          );

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.str(tup.$2.expected)),
            const .suffix(),
          ]);
        });
      });

      property('variable starts_with string', () {
        forAll(combine2(variableArbitrary(), stringArbitrary()), (tup) {
          final result = parser.parse(
            '\$${tup.$1}.starts_with("${tup.$2.string}")',
          );

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.str(tup.$2.expected)),
            const .prefix(),
          ]);
        });
      });

      property('variable matches pattern', () {
        forAll(combine2(variableArbitrary(), stringArbitrary()), (tup) {
          final result = parser.parse(
            '\$${tup.$1}.matches("${tup.$2.string}")',
          );

          expectSuccess(result, <Op>[
            .value(.variable(tup.$1)),
            .value(.str(tup.$2.expected)),
            const .regex(),
          ]);
        });
      });

      property('string set contains variable', () {
        forAll(
          combine4(
            stringArbitrary(),
            stringArbitrary(),
            stringArbitrary(),
            variableArbitrary(),
          ).filter((tup) => tup.$1 != tup.$2 && tup.$2 != tup.$3),
          (tup) {
            final result = parser.parse(
              '{"${tup.$1.string}", "${tup.$2.string}", "${tup.$3.string}"}'
              '.contains(\$${tup.$4})',
            );

            expectSuccess(result, <Op>[
              .value(
                .set(
                  .of([
                    .str(tup.$1.expected),
                    .str(tup.$2.expected),
                    .str(tup.$3.expected),
                  ]),
                ),
              ),
              .value(.variable(tup.$4)),
              const .contains(),
            ]);
          },
        );
      });

      property('negate string set contains variable', () {
        forAll(
          combine4(
            stringArbitrary(),
            stringArbitrary(),
            stringArbitrary(),
            variableArbitrary(),
          ).filter((tup) => tup.$1 != tup.$2 && tup.$2 != tup.$3),
          (tup) {
            final result = parser.parse(
              '!{"${tup.$1.string}", "${tup.$2.string}", "${tup.$3.string}"}'
              '.contains(\$${tup.$4})',
            );

            expectSuccess(result, <Op>[
              .value(
                .set(
                  .of([
                    .str(tup.$1.expected),
                    .str(tup.$2.expected),
                    .str(tup.$3.expected),
                  ]),
                ),
              ),
              .value(.variable(tup.$4)),
              const .contains(),
              const .negate(),
            ]);
          },
        );
      });

      property('mathematical and bitwise operations on integers', () {
        forAll(combine4(integer(), integer(), integer(), integer()), (tup) {
          final result = parser.parse(
            '${tup.$1} + ${tup.$2} | ${tup.$4} * ${tup.$3} & ${tup.$4}',
          );

          expectSuccess(result, <Op>[
            .value(.int(tup.$1)),
            .value(.int(tup.$2)),
            const .add(),
            .value(.int(tup.$4)),
            .value(.int(tup.$3)),
            const .mul(),
            .value(.int(tup.$4)),
            const .bitwiseAnd(),
            const .bitwiseOr(),
          ]);
        });
      });
    });

    group(Fact, () {
      late Parser<Fact> parser;

      setUp(() => parser = datalog.buildFrom(datalog.fact()));

      property('with strings', () {
        forAll(combine2(stringArbitrary(), stringArbitrary()), (tup) {
          final result = parser.parse(
            'right( "${tup.$1.string}", "${tup.$2.string}" )',
          );

          expectSuccess(
            result,
            Fact('right', [.str(tup.$1.expected), .str(tup.$2.expected)]),
          );
        });
      });

      property('with variable', () {
        forAll(
          combine2(
            stringArbitrary(),
            string(
              minLength: 1,
              characterSet: .alphanum(.ascii)..addCharacters('_:'),
            ),
          ),
          (tup) {
            final result = parser.parse(
              'right( "${tup.$1.string}", \$${tup.$2})',
            );

            expectFailure(result, '")" expected');
          },
        );
      });

      property('with date', () {
        forAll(dateTime(), (date) {
          final result = parser.parse('date( ${date.toIso8601String()} )');

          expectSuccess(result, Fact('date', [.date(date)]));
        });
      });
    });

    group(Rule, () {
      late Parser<Rule> parser;

      setUp(() => parser = datalog.buildFrom(datalog.rule()));

      test('basic', () {
        final result = parser.parse(
          'right(\$0, "read") <- resource( \$0), operation("read")',
        );

        expectSuccess(
          result,
          Rule.basic(
            headName: 'right',
            headTerms: const [.variable('0'), .str('read')],
            predicates: [
              .new('resource', const [.variable('0')]),
              .new('operation', const [.str('read')]),
            ],
          ),
        );
      });

      test('constrained', () {
        final result = parser.parse(
          'valid_date("file") <- time(\$0 ), resource("file"), '
          '\$0 <= 2019-12-04T09:46:41+00:00',
        );

        expectSuccess(
          result,
          Rule.constrained(
            headName: 'valid_date',
            headTerms: const [.str('file')],
            predicates: [
              .new('time', const [.variable('0')]),
              .new('resource', const [.str('file')]),
            ],
            expressions: [
              .new([
                const .value(.variable('0')),
                .value(.date(DateTime.parse('2019-12-04T09:46:41+00:00'))),
                const .lessOrEqual(),
              ]),
            ],
          ),
        );
      });

      test('constrained ordering', () {
        final result = parser.parse(
          'valid_date("file") <- time(\$0 ), \$0 <= 2019-12-04T09:46:41+00:00, '
          'resource("file")',
        );

        expectSuccess(
          result,
          Rule.constrained(
            headName: 'valid_date',
            headTerms: const [.str('file')],
            predicates: [
              .new('time', const [.variable('0')]),
              .new('resource', const [.str('file')]),
            ],
            expressions: [
              .new([
                const .value(.variable('0')),
                .value(.date(DateTime.parse('2019-12-04T09:46:41+00:00'))),
                const .lessOrEqual(),
              ]),
            ],
          ),
        );
      });

      test('with unused variables', () {
        final result = parser.parse(
          'right(\$0, \$test) <- resource(\$0), operation("read")',
        );

        expectFailure(
          result,
          contains(
            'the rule contains variables that are not bound by predicates '
            "in the rule's body: test",
          ),
        );
      });
    });

    group(Check, () {
      late Parser<Check> parser;

      setUp(() => parser = datalog.buildFrom(datalog.check()));

      test('valid', () {
        final result = parser.parse(
          'check if resource( \$0), operation("read") or admin("authority")',
        );

        expectSuccess(
          result,
          Check.one(<Rule>[
            .basic(
              headName: 'query',
              headTerms: const [],
              predicates: [
                .new('resource', const [.variable('0')]),
                .new('operation', const [.str('read')]),
              ],
            ),
            .basic(
              headName: 'query',
              headTerms: const [],
              predicates: [
                .new('admin', const [.str('authority')]),
              ],
            ),
          ]),
        );
      });

      test('invalid', () {
        var result = parser.parse(
          'check if resource(\$0) and operation("read") or admin("authority")',
        );

        expectFailure(result, isNotEmpty);

        result = parser.parse(
          'check if resource("{}"), operation("write")) or operation("read")',
        );

        expectFailure(result, isNotEmpty);

        result = parser.parse(
          'check if resource("{}") && operation("write")) || operation("read")',
        );

        expectFailure(result, isNotEmpty);
      });
    });

    group('expression', () {
      late Parser<Expr> parser;

      setUp(() => parser = datalog.buildFrom(datalog.expr()));

      property('negative number', () {
        forAll(integer(max: -1), (i) {
          final result = parser.parse(i.toString());

          expectSuccess(result, Expr.value(.int(i)));
          expect(result.value.toOpcodes(), [Op.value(.int(i))]);
        });
      });

      property('variable lessOrEqual to date', () {
        forAll(combine2(integer(min: 0), dateTime()), (tup) {
          final result = parser.parse(
            ' \$${tup.$1} <= ${tup.$2.toIso8601String()}',
          );

          expectSuccess(
            result,
            Expr.binary(
              const .lessOrEqual(),
              .value(.variable(tup.$1.toString())),
              .value(.date(tup.$2)),
            ),
          );
          expect(result.value.toOpcodes(), <Op>[
            .value(.variable(tup.$1.toString())),
            .value(.date(tup.$2)),
            const .lessOrEqual(),
          ]);
        });
      });

      property('integer lessThan sum of variable and integer', () {
        forAll(combine3(integer(), variableArbitrary(), integer()), (tup) {
          final result = parser.parse(' ${tup.$1} < \$${tup.$2} + ${tup.$3} ');

          expectSuccess(
            result,
            Expr.binary(
              const .lessThan(),
              .value(.int(tup.$1)),
              .binary(
                const .add(),
                .value(.variable(tup.$2)),
                .value(.int(tup.$3)),
              ),
            ),
          );
          expect(result.value.toOpcodes(), <Op>[
            .value(.int(tup.$1)),
            .value(.variable(tup.$2)),
            .value(.int(tup.$3)),
            const .add(),
            const .lessThan(),
          ]);
        });
      });

      property('lessThan with logical operators', () {
        forAll(
          combine5(
            integer(),
            variableArbitrary(),
            variableArbitrary(),
            stringArbitrary(),
            boolean(),
          ),
          (tup) {
            final result = parser.parse(
              ' ${tup.$1} < \$${tup.$2} &&'
              ' \$${tup.$3}.starts_with("${tup.$4.string}") && ${tup.$5} ',
            );

            expectSuccess(
              result,
              Expr.binary(
                const .lazyAnd(),
                Expr.binary(
                  const .lazyAnd(),
                  .binary(
                    const .lessThan(),
                    .value(.int(tup.$1)),
                    .value(.variable(tup.$2)),
                  ),
                  .closure(
                    const [],
                    .binary(
                      const .prefix(),
                      .value(.variable(tup.$3)),
                      .value(.str(tup.$4.expected)),
                    ),
                  ),
                ),
                .closure(const [], .value(.bool(tup.$5))),
              ),
            );
            expect(result.value.toOpcodes(), <Op>[
              .value(.int(tup.$1)),
              .value(.variable(tup.$2)),
              const .lessThan(),
              .closure(
                params: const [],
                ops: [
                  .value(.variable(tup.$3)),
                  .value(.str(tup.$4.expected)),
                  const .prefix(),
                ],
              ),
              const .lazyAnd(),
              .closure(params: const [], ops: [.value(.bool(tup.$5))]),
              const .lazyAnd(),
            ]);
          },
        );
      });

      property('math operators without parens', () {
        forAll(combine3(integer(), integer(), integer()), (tup) {
          final result = parser.parse(' ${tup.$1} + ${tup.$2} * ${tup.$3} ');

          expectSuccess(
            result,
            Expr.binary(
              const .add(),
              .value(.int(tup.$1)),
              .binary(const .mul(), .value(.int(tup.$2)), .value(.int(tup.$3))),
            ),
          );
          expect(result.value.toOpcodes(), <Op>[
            .value(.int(tup.$1)),
            .value(.int(tup.$2)),
            .value(.int(tup.$3)),
            const .mul(),
            const .add(),
          ]);
        });
      });

      property('math operators with parens', () {
        forAll(combine3(integer(), integer(), integer()), (tup) {
          final result = parser.parse(' (${tup.$1} + ${tup.$2} ) * ${tup.$3} ');

          expectSuccess(
            result,
            Expr.binary(
              const .mul(),
              .unary(
                const .parens(),
                .binary(
                  const .add(),
                  .value(.int(tup.$1)),
                  .value(.int(tup.$2)),
                ),
              ),
              .value(.int(tup.$3)),
            ),
          );
          expect(result.value.toOpcodes(), <Op>[
            .value(.int(tup.$1)),
            .value(.int(tup.$2)),
            const .add(),
            const .parens(),
            .value(.int(tup.$3)),
            const .mul(),
          ]);
        });
      });

      property('chained calls', () {
        forAll(combine3(integer(), integer(), integer()), (tup) {
          var result = parser.parse(
            '{${tup.$1}}.intersection({${tup.$2}}).contains(${tup.$3})',
          );

          expectSuccess(
            result,
            Expr.binary(
              const .contains(),
              .binary(
                const .intersection(),
                .value(.set(.from([Term.int(tup.$1)]))),
                .value(.set(.from([Term.int(tup.$2)]))),
              ),
              .value(.int(tup.$3)),
            ),
          );
          expect(result.value.toOpcodes(), <Op>[
            .value(.set(.from([Term.int(tup.$1)]))),
            .value(.set(.from([Term.int(tup.$2)]))),
            const .intersection(),
            .value(.int(tup.$3)),
            const .contains(),
          ]);

          result = parser.parse(
            '{${tup.$1}}.intersection({${tup.$2}}).union({${tup.$3}}).length()',
          );

          expectSuccess(
            result,
            Expr.unary(
              const .length(),
              .binary(
                const .union(),
                .binary(
                  const .intersection(),
                  .value(.set(.from([Term.int(tup.$1)]))),
                  .value(.set(.from([Term.int(tup.$2)]))),
                ),
                .value(.set(.of([Term.int(tup.$3)]))),
              ),
            ),
          );
          expect(result.value.toOpcodes(), <Op>[
            .value(.set(.from([Term.int(tup.$1)]))),
            .value(.set(.from([Term.int(tup.$2)]))),
            const .intersection(),
            .value(.set(.from([Term.int(tup.$3)]))),
            const .union(),
            const .length(),
          ]);

          result = parser.parse(
            '{${tup.$1}}.intersection({${tup.$2}}).length().union({${tup.$3}})',
          );

          expectSuccess(
            result,
            Expr.binary(
              const .union(),
              .unary(
                const .length(),
                .binary(
                  const .intersection(),
                  .value(.set(.from([Term.int(tup.$1)]))),
                  .value(.set(.from([Term.int(tup.$2)]))),
                ),
              ),
              .value(.set(.from([Term.int(tup.$3)]))),
            ),
          );
          expect(result.value.toOpcodes(), <Op>[
            .value(.set(.from([Term.int(tup.$1)]))),
            .value(.set(.from([Term.int(tup.$2)]))),
            const .intersection(),
            const .length(),
            .value(.set(.from([Term.int(tup.$3)]))),
            const .union(),
          ]);
        });
      });

      property('array contains', () {
        forAll(
          combine4(
            integer(),
            integer(),
            integer(),
            variableArbitrary(),
          ).map((tup) => ([tup.$1, tup.$2, tup.$3], tup.$4)),
          (tup) {
            final result = parser.parse('${tup.$1}.contains(\$${tup.$2})');

            final expectedArray = tup.$1.map(Term.int).toList(growable: false);

            expectSuccess(
              result,
              Expr.binary(
                const .contains(),
                .value(.array(expectedArray)),
                .value(.variable(tup.$2)),
              ),
            );
            expect(result.value.toOpcodes(), <Op>[
              .value(.array(expectedArray)),
              .value(.variable(tup.$2)),
              const .contains(),
            ]);
          },
        );
      });

      group('extern functions', () {
        property('without parameter', () {
          forAll(combine2(integer(), variableArbitrary()), (tup) {
            final result = parser.parse('${tup.$1}.extern::${tup.$2}()');

            expectSuccess(
              result,
              Expr.unary(.ffi(tup.$2), .value(.int(tup.$1))),
            );
            expect(result.value.toOpcodes(), <Op>[
              .value(.int(tup.$1)),
              .unFfi(tup.$2),
            ]);
          });
        });

        property('with parameter', () {
          forAll(combine3(integer(), variableArbitrary(), integer()), (tup) {
            final result = parser.parse(
              '${tup.$1}.extern::${tup.$2}(${tup.$3})',
            );

            expectSuccess(
              result,
              Expr.binary(
                .ffi(tup.$2),
                .value(.int(tup.$1)),
                .value(.int(tup.$3)),
              ),
            );
            expect(result.value.toOpcodes(), <Op>[
              .value(.int(tup.$1)),
              .value(.int(tup.$3)),
              .binFfi(tup.$2),
            ]);
          });
        });
      });

      test('empty set', () {
        final result = parser.parse('{,}');

        expectSuccess(result, Expr.value(.set(.new())));
        expect(result.value.toOpcodes(), <Op>[.value(.set(.new()))]);
      });

      test('empty map', () {
        final result = parser.parse('{}');

        expectSuccess(result, Expr.value(.map(.new())));
        expect(result.value.toOpcodes(), <Op>[.value(.map(.new()))]);
      });

      property('try_or', () {
        forAll(combine2(boolean(), boolean()), (tup) {
          final result = parser.parse('${tup.$1}.length().try_or(${tup.$2})');

          expectSuccess(
            result,
            Expr.binary(
              const .tryOr(),
              .closure(
                const [],
                .unary(const .length(), .value(.bool(tup.$1))),
              ),
              .value(.bool(tup.$2)),
            ),
          );
          expect(result.value.toOpcodes(), <Op>[
            .closure(
              params: const [],
              ops: [.value(.bool(tup.$1)), const .length()],
            ),
            .value(.bool(tup.$2)),
            const .tryOr(),
          ]);
        });
      });
    });

    test('source', () {
      final parser = datalog.buildFrom(datalog.source());
      const input = r'''
        fact("string");
        fact2(1234);

        rule_head($var0) <- fact($var0, $var1), 1 < 2;

        // line comment
        check if 1 === 2;

        allow if rule_head("string");

        /*
         other comment
        */
    check if
           fact(5678)
           or fact(1234), "test".starts_with("abc");

        check if 2021-01-01T00:00:00Z <= 2021-01-01T00:00:00Z;

        deny if true;
      ''';

      final result = parser.parse(input);

      expectSuccess(result, isNotNull);

      final value = result.value;

      expect(value.scopes, const []);

      expect(value.facts, <Fact>[
        .new('fact', const [.str('string')]),
        .new('fact2', const [.int(1234)]),
      ]);

      expect(value.rules, <Rule>[
        .constrained(
          headName: 'rule_head',
          headTerms: const [.variable('var0')],
          predicates: [
            .new('fact', const [.variable('var0'), .variable('var1')]),
          ],
          expressions: const [
            .new([.value(.int(1)), .value(.int(2)), .lessThan()]),
          ],
        ),
      ]);

      expect(value.checks, <Check>[
        .one([
          .constrained(
            headName: 'query',
            headTerms: const [],
            predicates: const [],
            expressions: const [
              .new([.value(.int(1)), .value(.int(2)), .equal()]),
            ],
          ),
        ]),
        .one([
          .basic(
            headName: 'query',
            headTerms: const [],
            predicates: [
              .new('fact', const [.int(5678)]),
            ],
          ),
          .constrained(
            headName: 'query',
            headTerms: const [],
            predicates: [
              .new('fact', const [.int(1234)]),
            ],
            expressions: const [
              .new([.value(.str('test')), .value(.str('abc')), .prefix()]),
            ],
          ),
        ]),
        .one([
          .constrained(
            headName: 'query',
            headTerms: const [],
            predicates: const [],
            expressions: [
              .new([
                .value(.date(DateTime.parse('2021-01-01T00:00:00Z'))),
                .value(.date(DateTime.parse('2021-01-01T00:00:00Z'))),
                const .lessOrEqual(),
              ]),
            ],
          ),
        ]),
      ]);

      expect(value.policies, <Policy>[
        .allow([
          .basic(
            headName: 'query',
            headTerms: const [],
            predicates: [
              .new('rule_head', const [.str('string')]),
            ],
          ),
        ]),
        .deny([
          .constrained(
            headName: 'query',
            headTerms: const [],
            predicates: const [],
            expressions: const [
              .new([.value(.bool(true))]),
            ],
          ),
        ]),
      ]);

      expectSuccess(parser.parse(input), result.value);
    });

    test('block source', () {
      final parser = datalog.buildFrom(datalog.blockSource());
      const input = r'''
        fact("string");
        fact2(1234);

  rule_head($var0) <- fact($var0, $var1), 1 < 2; // line comment
  check if 1 === 2; /*
                    other comment
                   */
  check if
           fact(5678)
           or fact(1234), "test".starts_with("abc");

        check if 2021-01-01T00:00:00Z <= 2021-01-01T00:00:00Z;
      ''';

      final result = parser.parse(input);

      expectSuccess(result, isNotNull);

      final value = result.value;

      expect(value.scopes, const []);

      expect(value.facts, <Fact>[
        .new('fact', const [.str('string')]),
        .new('fact2', const [.int(1234)]),
      ]);

      expect(value.rules, <Rule>[
        .constrained(
          headName: 'rule_head',
          headTerms: const [.variable('var0')],
          predicates: [
            .new('fact', const [.variable('var0'), .variable('var1')]),
          ],
          expressions: const [
            .new([.value(.int(1)), .value(.int(2)), .lessThan()]),
          ],
        ),
      ]);

      expect(value.checks, <Check>[
        .one([
          .constrained(
            headName: 'query',
            headTerms: const [],
            predicates: const [],
            expressions: const [
              .new([.value(.int(1)), .value(.int(2)), .equal()]),
            ],
          ),
        ]),
        .one([
          .basic(
            headName: 'query',
            headTerms: const [],
            predicates: [
              .new('fact', const [.int(5678)]),
            ],
          ),
          .constrained(
            headName: 'query',
            headTerms: const [],
            predicates: [
              .new('fact', const [.int(1234)]),
            ],
            expressions: const [
              .new([.value(.str('test')), .value(.str('abc')), .prefix()]),
            ],
          ),
        ]),
        .one([
          .constrained(
            headName: 'query',
            headTerms: const [],
            predicates: const [],
            expressions: [
              .new([
                .value(.date(DateTime.parse('2021-01-01T00:00:00Z'))),
                .value(.date(DateTime.parse('2021-01-01T00:00:00Z'))),
                const .lessOrEqual(),
              ]),
            ],
          ),
        ]),
      ]);

      expect(value.policies, const []);

      expectSuccess(parser.parse(input), result.value);
    });
  });
}

void expectSuccess<R, M>(Result<R> result, M valueMatcher) => switch (result) {
  Success(value: final actual) => expect(actual, valueMatcher),
  _ => fail(result.toString()),
};

void expectFailure<R, M>(Result<R> result, M messageMatcher) =>
    switch (result) {
      Failure(:final message) => expect(message, messageMatcher),
      _ => fail('Expected $Failure, got $result'),
    };

Arbitrary<({String string, String expected})> stringArbitrary() {
  return string(
        characterSet: .alphanum(.utf8)
          ..addCharacterSet(.whitespaceAndNewline(.utf8))
          ..addCharacterSet(.symbol(.utf8))
          ..addCharacterSet(.bitDigit())
          ..addCharacterSet(.octalDigit())
          ..addCharacterSet(.hexDigit()),
      )
      .flatMap((s) {
        return s.length < 10
            ? constant(s)
            : integer(min: 0, max: s.length).map((index) {
                return s.replaceRange(index, index, '\\n');
              });
      })
      .map((s) => s.replaceAll('"', '\\"'))
      .map((s) => (string: s, expected: s.replaceAll('\\n', '\n')));
}

Arbitrary<String> variableArbitrary() =>
    string(minLength: 1, characterSet: .alphanum(.ascii)..addCharacters('_:'));
