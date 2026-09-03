// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/parser/builder/bytes.dart';
import 'package:biscuit_auth/parser/builder/check.dart';
import 'package:biscuit_auth/parser/builder/expression/expression.dart';
import 'package:biscuit_auth/parser/builder/expression/op.dart';
import 'package:biscuit_auth/parser/builder/fact.dart';
import 'package:biscuit_auth/parser/builder/policy.dart';
import 'package:biscuit_auth/parser/builder/rule.dart';
import 'package:biscuit_auth/parser/builder/scope.dart';
import 'package:biscuit_auth/parser/comment.dart';
import 'package:biscuit_auth/parser/expression.dart';
import 'package:biscuit_auth/parser/rule_body.dart';
import 'package:biscuit_auth/parser/source.dart';
import 'package:meta/meta.dart';
import 'package:petitparser/petitparser.dart';

@immutable
final class const DatalogGrammar() extends GrammarDefinition {
  @override
  Parser<Source> start() =>
      throw UnimplementedError('Use source() or blockSource() parser instead');

  Parser<Source> source() {
    final body = [
      ref0(ruleInner),
      ref0(factInner),
      ref0(checkInner),
      ref0(policyInner),
    ].toChoiceParser();

    return [
          body.skip(after: ref0(semicolonSep)),
          ref0(singleLineComment),
          ref0(multiLineComment),
        ]
        .toChoiceParser()
        .star()
        .map((list) {
          final source = Source.empty();

          for (final item in list) {
            switch (item) {
              case final Rule rule:
                source.rules.add(rule);
              case final Fact fact:
                source.facts.add(fact);
              case final Check check:
                source.checks.add(check);
              case final Policy policy:
                source.policies.add(policy);
              case final Comment _:
                continue;
              default:
                throw ArgumentError.value(item, 'unexpected source item type');
            }
          }

          return source;
        })
        .labeled('source');
  }

  Parser<Source> blockSource() {
    final body = [
      ref0(ruleInner),
      ref0(factInner),
      ref0(checkInner),
    ].toChoiceParser();

    return seq2(
          ref0(scopes).skip(after: ref0(semicolonSep)).optionalWith(const []),
          [
            body.skip(after: ref0(semicolonSep)),
            ref0(singleLineComment),
            ref0(multiLineComment),
          ].toChoiceParser().star(),
        )
        .map2((scopes, list) {
          final source = Source.empty(scopes: scopes);

          for (final item in list) {
            switch (item) {
              case final Rule rule:
                source.rules.add(rule);
              case final Fact fact:
                source.facts.add(fact);
              case final Check check:
                source.checks.add(check);
              case final Comment _:
                continue;
              default:
                throw ArgumentError.value(
                  item,
                  'unexpected block source item type',
                );
            }
          }

          return source;
        })
        .labeled('block');
  }

  @visibleForTesting
  Parser<List<Scope>> scopes() =>
      ref0(scope)
          .skip(before: ref0(starSpace))
          .plusSeparated(ref0(commaSep))
          .skip(before: ref1(trimBefore, 'trusting'))
          .map((list) => list.elements)
          .optionalWith(const [])
          .labeled('scopes');

  @visibleForTesting
  Parser<Scope> scope() => [
    string('authority').map((_) => const Scope.authority()),
    string('previous').map((_) => const Scope.previous()),
    ref0(publicKey).map(Scope.publicKey),
    ref0(parameterName).map(Scope.parameter),
  ].toChoiceParser().labeled('scope');

  @visibleForTesting
  Parser<PublicKey> publicKey() {
    return seq2(
          [
            string('ed25519/').map((_) => PublicKey.ed25519),
            string('secp256r1/').map((_) => PublicKey.secp256r1),
          ].toChoiceParser(),
          ref0(hex),
        )
        .map2((factory, hex) => factory(bytesStrToUint8List(hex)))
        .labeled('publicKey');
  }

  @visibleForTesting
  Parser<Rule> rule() =>
      ref0(ruleInner).skip(after: ref0(starSpace)).end().labeled('rule');

  @visibleForTesting
  Parser<Rule> ruleInner() =>
      seq2(ref0(ruleHead).skip(after: ref1(trimBefore, '<-')), ref0(ruleBody))
          .callCC<Rule>((continuation, context) {
            switch (continuation(context)) {
              case Success(value: final tup, :final position):
                final rule = Rule(
                  head: tup.$1,
                  predicates: tup.$2.predicates,
                  expressions: tup.$2.expressions,
                  scopes: tup.$2.scopes,
                );

                if (rule.validateVariables() case final error?) {
                  return context.failure(error, context.position);
                }

                return context.success(rule, position);
              case final Failure failure:
                return failure;
            }
          })
          .labeled('ruleInner');

  @visibleForTesting
  Parser<Predicate> ruleHead() =>
      seq2(
            ref0(name).skip(after: ref0(starSpace)),
            ref0(term)
                .starSeparated(ref0(commaSep))
                .skip(before: ref0(openParen), after: ref0(closeParen)),
          )
          .map2((name, terms) => Predicate(name, terms.elements))
          .skip(before: ref0(starSpace))
          .labeled('ruleHead');

  @visibleForTesting
  Parser<RuleBody> ruleBody() {
    return seq2(ref0(predicateOrExpr), ref0(scopes))
        .map2((predicatesOrExprs, scopes) {
          final predicates = <Predicate>[];
          final expressions = <Expression>[];

          for (final poe in predicatesOrExprs) {
            switch (poe) {
              case final Predicate p:
                predicates.add(p);
              case final Expr e:
                expressions.add(.fromAst(e));
              default:
                throw ArgumentError(
                  'Expected $Predicate or $Expr, '
                  'but got ${poe.runtimeType}',
                );
            }
          }

          return (
            predicates: predicates,
            expressions: expressions,
            scopes: scopes,
          );
        })
        .labeled('ruleBody');
  }

  @visibleForTesting
  Parser<Fact> fact() =>
      ref0(factInner)
          .skip(before: ref0(starSpace), after: ref0(starSpace))
          .labeled('fact');

  @visibleForTesting
  Parser<Fact> factInner() =>
      seq2(
            ref0(name).skip(after: ref0(starSpace)),
            ref0(termInFact)
                .plusSeparated(ref0(commaSep))
                .skip(before: ref0(openParen), after: ref0(closeParen)),
          )
          .skip(before: ref0(starSpace))
          .map2((name, terms) => Fact(name, terms.elements))
          .labeled('factInner');

  @visibleForTesting
  Parser<Check> check() =>
      ref0(checkInner).skip(after: ref0(starSpace)).end().labeled('check');

  @visibleForTesting
  Parser<Check> checkInner() =>
      seq2(
            [
              string('check if', ignoreCase: true).map((_) => Check.one),
              string('check all', ignoreCase: true).map((_) => Check.all),
              string('reject if', ignoreCase: true).map((_) => Check.reject),
            ].toChoiceParser(),
            ref0(checkBody),
          )
          .skip(before: ref0(starSpace))
          .map2((factory, body) => factory(body))
          .labeled('checkInner');

  @visibleForTesting
  Parser<List<Rule>> checkBody() =>
      ref0(ruleBody)
          .skip(before: ref0(starSpace))
          .plusSeparated(ref1(trimBefore, 'or'))
          .map(
            (list) => list.elements.map((tup) {
              return Rule(
                head: .new('query', const []),
                predicates: tup.predicates,
                expressions: tup.expressions,
                scopes: tup.scopes,
              );
            }).toList(),
          )
          .labeled('checkBody');

  @visibleForTesting
  Parser<Policy> policy() =>
      ref0(policyInner).skip(after: ref0(starSpace)).end().labeled('policy');

  @visibleForTesting
  Parser<Policy> policyInner() =>
      seq2(
            [
              ref1(trimAfter, 'allow if').map((_) => Policy.allow),
              ref1(trimAfter, 'deny if').map((_) => Policy.deny),
            ].toChoiceParser(),
            ref0(checkBody),
          )
          .skip(before: ref0(starSpace))
          .map2((factory, body) => factory(body))
          .labeled('policyBody');

  @visibleForTesting
  Parser<List<Object>> predicateOrExpr() => [ref0(predicate), ref0(expr)]
      .toChoiceParser()
      .plusSeparated(ref0(commaSep))
      .map((list) => list.elements)
      .labeled('predicateOrExpr');

  @visibleForTesting
  Parser<Predicate> predicate() =>
      seq2(
            ref0(name).skip(after: ref0(starSpace)),
            ref0(term)
                .plusSeparated(ref0(commaSep))
                .skip(before: ref0(openParen), after: ref0(closeParen)),
          )
          .skip(before: ref0(starSpace))
          .map2((name, terms) => Predicate(name, terms.elements))
          .labeled('predicate');

  @visibleForTesting
  Parser<Expr> expr() {
    final builder = ExpressionBuilder<Expr>()
      ..primitive(ref0(term).map((t) => .value(t)));

    builder.group().wrapper(
      seq2(ref0(starSpace), ref0(openParen)),
      ref0(closeParen),
      (_, expr, _) => .unary(const .parens(), expr),
    );

    builder.group()
      ..postfix(ref1(binaryMethod, builder), (left, tup) {
        return switch ((tup.$1, tup.$2)) {
          (const .tryOr(), _) => .binary(
            tup.$1,
            .closure(const [], left),
            tup.$3,
          ),
          (_, final params?) => .binary(tup.$1, left, .closure(params, tup.$3)),
          (_, _) => .binary(tup.$1, left, tup.$3),
        };
      })
      ..postfix(ref0(unaryMethod), (expr, op) => .unary(op, expr));

    builder.group().prefix(ref1(trimBefore, '!'), (_, expr) {
      return .unary(const .negate(), expr);
    });

    builder.group()
      ..left(ref1(trimBefore, '*'), (l, _, r) => .binary(const .mul(), l, r))
      ..left(ref1(trimBefore, '/'), (l, _, r) => .binary(const .div(), l, r));

    builder.group()
      ..left(ref1(trimBefore, '+'), (l, _, r) => .binary(const .add(), l, r))
      ..left(ref1(trimBefore, '-'), (l, _, r) => .binary(const .sub(), l, r));

    builder.group().left(ref1(trimBefore, '&'), (l, _, r) {
      return .binary(const .bitwiseAnd(), l, r);
    });

    builder.group().left(ref1(trimBefore, '|'), (l, _, r) {
      return .binary(const .bitwiseOr(), l, r);
    });

    builder.group().left(ref1(trimBefore, '^'), (l, _, r) {
      return .binary(const .bitwiseXor(), l, r);
    });

    builder.group()
      ..left(ref1(trimBefore, '<='), (l, _, r) {
        return .binary(const .lessOrEqual(), l, r);
      })
      ..left(ref1(trimBefore, '>='), (l, _, r) {
        return .binary(const .greaterOrEqual(), l, r);
      })
      ..left(ref1(trimBefore, '<'), (l, _, r) {
        return .binary(const .lessThan(), l, r);
      })
      ..left(ref1(trimBefore, '>'), (l, _, r) {
        return .binary(const .greaterThan(), l, r);
      })
      ..left(ref1(trimBefore, '==='), (l, _, r) {
        return .binary(const .equal(), l, r);
      })
      ..left(ref1(trimBefore, '!=='), (l, _, r) {
        return .binary(const .notEqual(), l, r);
      })
      ..left(ref1(trimBefore, '=='), (l, _, r) {
        return .binary(const .heterogeneousEqual(), l, r);
      })
      ..left(ref1(trimBefore, '!='), (l, _, r) {
        return .binary(const .heterogeneousNotEqual(), l, r);
      });

    builder.group().left(ref1(trimBefore, '&&'), (l, _, r) {
      return .binary(const .lazyAnd(), l, .closure(const [], r));
    });

    builder.group().left(ref1(trimBefore, '||'), (l, _, r) {
      return .binary(const .lazyOr(), l, .closure(const [], r));
    });

    return builder
        .build()
        .callCC<Expr>(((continuation, context) {
          final result = continuation(context);

          switch (result) {
            case Success(:final value):
              if (value.validate() case final error?) {
                return context.failure(error, context.position);
              }
              return result;

            case final Failure failure:
              return failure;
          }
        }))
        .labeled('expr');
  }

  @visibleForTesting
  Parser<(BinaryOp, List<String>?, Expr)> binaryMethod(
    ExpressionBuilder<Expr> builder,
  ) {
    final regularOp = <Parser<BinaryOp>>[
      string('contains').map((_) => const .contains()),
      string('starts_with').map((_) => const .prefix()),
      string('ends_with').map((_) => const .suffix()),
      string('matches').map((_) => const .regex()),
      string('intersection').map((_) => const .intersection()),
      string('union').map((_) => const .union()),
      string('get').map((_) => const .get()),
      string('try_or').map((_) => const .tryOr()),
      ref0(name).skip(before: string('extern::')).map((n) => .ffi(n)),
    ].toChoiceParser();

    final regularMethod = seq2(
      regularOp.skip(after: ref0(openParen)),
      builder.loopback,
    ).map2((op, expr) => (op, null, expr));

    final quantifierOp = <Parser<BinaryOp>>[
      string('all').map((_) => const .all()),
      string('any').map((_) => const .any()),
    ].toChoiceParser();

    final quantifierMethod = seq3(
      quantifierOp.skip(after: ref0(openParen)),
      ref0(name).skip(before: char('\$'), after: ref1(trimBefore, '->')),
      builder.loopback,
    ).map3((op, name, expr) => (op, [name], expr));

    return [regularMethod, quantifierMethod]
        .toChoiceParser()
        .skip(before: char('.'), after: ref0(closeParen))
        .labeled('binaryMethod');
  }

  @visibleForTesting
  Parser<UnaryOp> unaryMethod() {
    return <Parser<UnaryOp>>[
          string('length').map((_) => const .length()),
          string('type').map((_) => const .type()),
          ref0(name).skip(before: string('extern::')).map((name) => .ffi(name)),
        ]
        .toChoiceParser()
        .skip(before: char('.'), after: seq2(ref1(trimAfter, '('), char(')')))
        .labeled('unaryMethod');
  }

  @visibleForTesting
  Parser<Term> set() =>
      [
            string('{,}').map((_) => SeparatedList(const [], const [])),
            ref0(termInSet)
                .starSeparated(ref0(commaSep))
                .skip(before: ref0(openBrace), after: ref0(closeBrace)),
          ]
          .toChoiceParser()
          .skip(before: ref0(starSpace))
          .callCC<Term>((continuation, context) {
            switch (continuation(context)) {
              case Success(value: final list, :final position):
                final elements = list.elements;
                if (elements.isEmpty) {
                  return context.success(.set(.new()), position);
                }

                final firstType = elements.first.runtimeType;
                if (elements.every((e) => e.runtimeType == firstType)) {
                  return context.success(
                    .set(SplayTreeSet.from(elements)),
                    position,
                  );
                }

                return context.failure(
                  'every set element must have the same type',
                  context.position,
                );

              case final Failure failure:
                return failure;
            }
          })
          .labeled('set');

  @visibleForTesting
  Parser<Term> array() =>
      ref0(termInFact)
          .starSeparated(ref0(commaSep))
          .skip(before: ref0(openBracket), after: ref0(closeBracket))
          .map((list) => Term.array(list.elements))
          .labeled('array');

  @visibleForTesting
  Parser<Term> map() => ref0(mapEntry)
      .starSeparated(ref0(commaSep))
      .skip(
        before: seq2(ref0(starSpace), ref0(openBrace)),
        after: ref0(closeBrace),
      )
      .map((list) => Term.map(.fromIterable(list.elements)))
      .labeled('map');

  @visibleForTesting
  Parser<MapEntry<MapKey, Term>> mapEntry() => seq2(
    ref0(mapKey).skip(after: ref1(trimBefore, ':')),
    ref0(termInFact),
  ).map2((key, term) => MapEntry(key, term)).labeled('mapEntry');

  @visibleForTesting
  Parser<MapKey> mapKey() => [
    ref0(parameterKey),
    ref0(strKey),
    ref0(integerKey),
  ].toChoiceParser().labeled('mapKey');

  @visibleForTesting
  Parser<MapKey> parameterKey() =>
      ref0(parameterName)
          .map((s) => MapKey.parameter(s))
          .labeled('parameterKey');

  @visibleForTesting
  Parser<MapKey> strKey() =>
      ref0(strParser).map((s) => MapKey.str(s)).labeled('strKey');

  @visibleForTesting
  Parser<MapKey> integerKey() =>
      ref0(integerParser).map((i) => MapKey.integer(i)).labeled('integerKey');

  @visibleForTesting
  Parser<Term> parameter() =>
      ref0(parameterName).map((s) => Term.parameter(s)).labeled('parameter');

  @visibleForTesting
  Parser<String> parameterName() => seq2(letter(), ref0(nameChar).star())
      .flatten(message: 'Invalid parameter name')
      .skip(before: char('{'), after: char('}'))
      .labeled('parameterName');

  @visibleForTesting
  Parser<Term> str() => ref0(strParser).map((s) => Term.str(s)).labeled('str');

  @visibleForTesting
  Parser<String> strParser() {
    final printable = [char('\\'), char('"')]
        .toChoiceParser()
        .neg()
        .plus()
        .flatten(message: 'Invalid printable string character');

    final escaped = [
      char('\\').skip(before: char('\\')),
      char('"').skip(before: char('\\')),
      char('n').skip(before: char('\\')).map((_) => '\n'),
    ].toChoiceParser();

    return [printable, escaped]
        .toChoiceParser()
        .star()
        .skip(before: char('"'), after: char('"'))
        .map((list) => list.join(''))
        .labeled('strParser');
  }

  @visibleForTesting
  Parser<Term> integer() =>
      ref0(integerParser).map((i) => Term.int(i)).labeled('integer');

  @visibleForTesting
  Parser<int> integerParser() => seq2(char('-').optional(), digit().plus())
      .flatten(message: 'Invalid integer format')
      .map((s) => int.parse(s))
      .labeled('integerParser');

  @visibleForTesting
  Parser<Term> date() =>
      anyOf(', )];}')
          .neg()
          .plus()
          .flatten(message: 'Invalid date format')
          .callCC<Term>((continuation, context) {
            switch (continuation(context)) {
              case final Success<String> success:
                if (DateTime.tryParse(success.value) case final dt?) {
                  return context.success(.date(dt), success.position);
                }

                return context.failure(
                  'invalid date format: ${success.value}',
                  context.position,
                );

              case final Failure failure:
                return failure;
            }
          })
          .labeled('date');

  @visibleForTesting
  Parser<Term> bytes() =>
      ref0(hex)
          .skip(before: string('hex:'))
          .map((s) => Term.bytes(bytesStrToUint8List(s)))
          .labeled('bytes');

  @visibleForTesting
  Parser<String> hex() => [digit(), anyOf('abcdef', ignoreCase: true)]
      .toChoiceParser()
      .plus()
      .flatten(message: 'Invalid hex format')
      .labeled('hex');

  @visibleForTesting
  Parser<Term> variable() =>
      ref0(name)
          .skip(before: char('\$'))
          .map((s) => Term.variable(s))
          .labeled('variable');

  @visibleForTesting
  Parser<String> name() =>
      ref0(nameChar).plus().flatten(message: 'Invalid name').labeled('name');

  @visibleForTesting
  Parser<String> nameChar() =>
      [word(), char(':')].toChoiceParser().labeled('nameChar');

  @visibleForTesting
  Parser<Term> boolean() => [
    string('true'),
    string('false'),
  ].toChoiceParser().map((s) => Term.bool(bool.parse(s))).labeled('boolean');

  @visibleForTesting
  Parser<Term> nil() =>
      string('null').map((_) => const Term.nil()).labeled('nil');

  @visibleForTesting
  Parser<Term> term() => [
    ref0(parameter),
    ref0(str),
    ref0(date),
    ref0(variable),
    ref0(integer),
    ref0(bytes),
    ref0(boolean),
    ref0(nil),
    ref0(array),
    ref0(map),
    ref0(set),
  ].toChoiceParser().skip(before: ref0(starSpace)).labeled('term');

  @visibleForTesting
  Parser<Term> termInFact() => [
    ref0(parameter),
    ref0(str),
    ref0(date),
    ref0(integer),
    ref0(bytes),
    ref0(boolean),
    ref0(nil),
    ref0(set),
    ref0(array),
    ref0(map),
  ].toChoiceParser().skip(before: ref0(starSpace)).labeled('termInFact');

  @visibleForTesting
  Parser<Term> termInSet() => [
    ref0(parameter),
    ref0(str),
    ref0(date),
    ref0(integer),
    ref0(bytes),
    ref0(boolean),
    ref0(nil),
    ref0(map),
  ].toChoiceParser().skip(before: ref0(starSpace)).labeled('termInSet');

  @visibleForTesting
  Parser<void> semicolonSep() => [
    char(';'),
    endOfInput(),
  ].toChoiceParser().skip(before: ref0(starSpace)).labeled('semicolon');

  @visibleForTesting
  Parser<void> commaSep() => ref1(trimBefore, ',');

  @visibleForTesting
  Parser<String> openParen() => char('(').labeled('openParen');

  @visibleForTesting
  Parser<String> closeParen() => ref1(trimBefore, ')').labeled('closeParen');

  @visibleForTesting
  Parser<String> openBracket() => char('[').labeled('openBracket');

  @visibleForTesting
  Parser<String> closeBracket() =>
      ref1(trimBefore, ']').labeled('closeBracket');

  @visibleForTesting
  Parser<String> openBrace() => char('{').labeled('openBrace');

  @visibleForTesting
  Parser<String> closeBrace() => ref1(trimBefore, '}').labeled('closeBrace');

  @visibleForTesting
  Parser<String> trimBefore(String input) =>
      input.toParser().skip(before: ref0(starSpace)).labeled('trimmedLeft');

  @visibleForTesting
  Parser<String> trimAfter(String input) =>
      input.toParser().skip(after: ref0(starSpace)).labeled('trimmedRight');

  @visibleForTesting
  Parser<String> starSpace() =>
      anyOf(' \t\r\n')
          .star()
          .flatten(message: 'Invalid whitespace character')
          .labeled('starSpace');

  @visibleForTesting
  Parser<Comment> singleLineComment() =>
      seq3(
            string('//'),
            newline().neg().star(),
            [newline(), endOfInput()].toChoiceParser(),
          )
          .skip(before: ref0(starSpace))
          .flatten(message: 'Invalid single-line comment')
          .map((_) => const Comment.line())
          .labeled('lineComment');

  @visibleForTesting
  Parser<Comment> multiLineComment() =>
      seq3(string('/*'), string('*/').neg().star(), string('*/'))
          .skip(before: ref0(starSpace))
          .flatten(message: 'Invalid multi-line comment')
          .map((_) => const Comment.multiLine())
          .labeled('multilineComment');
}
