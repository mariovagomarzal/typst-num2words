/// Test utilities for language converter tests.

/// Builds a diagnostic message for a failed test case.
///
/// -> str
#let _failure-message(
  /// The input number.
  /// -> int
  number,
  /// Additional arguments forwarded to the converter.
  /// -> arguments
  args,
  /// The actual output.
  /// -> str
  got,
  /// The expected output.
  /// -> str
  expected,
) = {
  "convert(" + repr(number) + ", " + repr(args) + ") = " + repr(got) + ", expected " + repr(expected)
}

/// Asserts that a converter call produces the expected output, with a
/// diagnostic message on failure.
#let _assert-case(
  /// The converter function to test.
  /// -> function
  convert,
  /// The input number.
  /// -> int
  number,
  /// The expected output.
  /// -> str
  expected,
  /// Additional arguments forwarded to the converter.
  /// -> arguments
  args,
) = {
  let got = convert(number, ..args)
  assert.eq(got, expected, message: _failure-message(number, args, got, expected))
}

/// Runs a list of test cases against a converter function, asserting that each
/// produces the expected output. Each case is either a `(number, expected)`
/// pair or a `(number, expected, extra-args)` triple, where `extra-args` is an
/// `arguments` value merged with the top-level args for that case.
/// Any additional arguments are forwarded to every converter call, which is
/// useful for grouping cases that share the same options (e.g., `form`).
#let check(
  /// The converter function to test.
  /// -> function
  convert,
  /// An array of `(number, expected)` or `(number, expected, extra-args)` entries.
  /// -> array
  cases,
  /// Additional arguments forwarded to every `convert` call.
  /// -> any
  ..args,
) = {
  for case in cases {
    let number = case.at(0)
    let expected = case.at(1)
    let merged = if case.len() > 2 {
      arguments(..args, ..case.at(2))
    } else {
      args
    }
    _assert-case(convert, number, expected, merged)
  }
}
