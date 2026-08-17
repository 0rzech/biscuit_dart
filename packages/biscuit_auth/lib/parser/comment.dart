// Copyright 2026 Piotr Mieczysław Orzechowski
// SPDX-License-Identifier: Apache-2.0

sealed class const Comment() {
  const factory line() = LineComment;
  const factory multiLine() = MultiLineComment;
}

final class const LineComment() extends Comment {
  @override
  String toString() => 'LineComment';
}

final class const MultiLineComment() extends Comment {
  @override
  String toString() => 'MultiLineComment';
}
