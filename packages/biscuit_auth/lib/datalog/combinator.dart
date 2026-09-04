// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:biscuit_auth/datalog/expression/op.dart';
import 'package:biscuit_auth/datalog/fact.dart';
import 'package:biscuit_auth/datalog/matched_variables.dart';
import 'package:biscuit_auth/datalog/origin.dart';
import 'package:biscuit_auth/datalog/symbol.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

@immutable
final class const FactCombinator({
  required final MatchedVariables variables,
  required final ListSlice<Predicate> predicates,
  required final Iterable<(Origin, Fact)> facts,
  required final SymbolTable symbols,
}) extends Iterable<(Origin, HashMap<SymbolId, Term>)> {
  @override
  Iterator<(Origin, HashMap<SymbolId, Term>)> get iterator => _Combinator(
    variables: variables,
    predicates: predicates.slice(0, predicates.length),
    facts: facts,
    symbols: symbols,
  );
}

final class _Combinator implements Iterator<(Origin, HashMap<SymbolId, Term>)> {
  MatchedVariables variables;
  final List<Predicate> predicates;
  final Iterable<(Origin, Fact)> allFacts;
  final SymbolTable _symbols;
  final Iterator<(Origin, Fact)> currentFacts;
  Iterator<(Origin, HashMap<SymbolId, Term>)>? currentIterator;
  (Origin, HashMap<SymbolId, Term>)? currentItem;

  new({
    required this.variables,
    required this.predicates,
    required Iterable<(Origin, Fact)> facts,
    required this._symbols,
  }) : allFacts = facts,
       currentFacts = predicates.isEmpty
           ? facts.iterator
           : facts.where((f) {
               return areMatching(rule: predicates.first, fact: f.$2.predicate);
             }).iterator;

  @override
  bool moveNext() {
    // if we're the last iterator in the recursive chain, stop here
    if (predicates.isEmpty) {
      // if we got a complete set of variables, let's test the expressions
      if (variables.complete() case final completed?) {
        // if there were no predicates and expressions evaluated to true,
        // we should return a value, but only once. To prevent further
        // successful calls, we create a set of variables that cannot
        // possibly be completed, so the next call will fail
        variables = .new(.of([const .new(0)]));
        currentItem = (.new(), completed);
        return true;
      }

      return false;
    }

    while (true) {
      if (currentIterator == null) {
        // fix the first predicate
        final pred = predicates[0];

        while (true) {
          if (currentFacts.moveNext()) {
            final (currentOrigin, currentFact) = currentFacts.current;
            // create a new MatchedVariables in which we fix variables we could
            // unify from our first predicate and the current fact
            final vars = variables.clone();
            var matchTerms = true;

            for (final [key, id] in IterableZip([
              pred.terms,
              currentFact.predicate.terms,
            ])) {
              if (key case Variable(id: final k)) {
                if (!vars.insert(k, id)) {
                  matchTerms = false;
                  break;
                }
              }
            }

            if (!matchTerms) {
              continue;
            }

            if (predicates.length == 1) {
              if (vars.complete() case final completed?) {
                // we got a complete set of variables, let's test the
                // expressions
                currentItem = (currentOrigin, completed);
                return true;
              }

              continue;
            } else {
              // create a new iterator with the matched variables, the rest of
              // the predicates, and all of the facts
              currentIterator = FactCombinator(
                variables: vars,
                predicates: predicates.slice(1),
                facts: allFacts,
                symbols: _symbols,
              ).map((tup) => (tup.$1.union(currentOrigin), tup.$2)).iterator;
            }

            break;
          } else {
            return false;
          }
        }
      }

      if (currentIterator case final iter?) {
        if (iter.moveNext()) {
          currentItem = iter.current;
          return true;
        }

        currentIterator = null;
      } else {
        return false;
      }
    }
  }

  @override
  (Origin, HashMap<SymbolId, Term>) get current {
    if (currentItem case final curr?) return curr;

    throw StateError('`moveNext` not called before calling `current`');
  }
}
