/// Test utilities for language converter tests.

/// Builds a diagnostic message for a failed test case.
///
/// - number (int): The input number.
/// - args (arguments): Additional arguments forwarded to the converter.
/// - got (str): The actual output.
/// - expected (str): The expected output.
/// -> str
#let _failure-message(number, args, got, expected) = {
  "convert(" + repr(number) + ", " + repr(args) + ") = " + repr(got) + ", expected " + repr(expected)
}

/// Asserts that a converter call produces the expected output, with a
/// diagnostic message on failure.
///
/// - convert (function): The converter function to test.
/// - number (int): The input number.
/// - expected (str): The expected output.
/// - args (arguments): Additional arguments forwarded to the converter.
#let _assert-case(convert, number, expected, args) = {
  let got = convert(number, ..args)
  assert.eq(got, expected, message: _failure-message(number, args, got, expected))
}

/// Runs a list of test cases against a converter function, asserting that each
/// produces the expected output. Each case is either a `(number, expected)`
/// pair or a `(number, expected, extra-args)` triple, where `extra-args` is an
/// `arguments` value merged with the top-level args for that case.
/// Any additional arguments are forwarded to every converter call, which is
/// useful for grouping cases that share the same options (e.g., `form`).
///
/// - convert (function): The converter function to test.
/// - cases (array): An array of `(number, expected)` or `(number, expected, extra-args)` entries.
/// - ..args: Additional arguments forwarded to every `convert` call.
#let check(convert, cases, ..args) = {
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
