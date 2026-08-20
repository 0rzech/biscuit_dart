// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

import 'package:biscuit_auth/src/boilerplate_gen_annotations.dart';

part 'gen/comment.bp.dart';

sealed class const Comment() {
  const factory line() = LineComment;
  const factory multiLine() = MultiLineComment;
}

@boilerplate
final class const LineComment() extends Comment {
  @override
  String toString() => _toString();
}

@boilerplate
final class const MultiLineComment() extends Comment {
  @override
  String toString() => _toString();
}
