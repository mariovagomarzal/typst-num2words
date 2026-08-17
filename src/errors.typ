/// Error helpers for consistent `num2words` error messages.

/// Formats the `num2words` prefix, optionally scoped to a language.
///
/// -> str
#let _prefix(
  /// The language code, or `none` for the top-level function.
  /// -> str | none
  lang,
) = {
  if lang == none {
    "num2words"
  } else {
    "num2words (" + lang + ")"
  }
}

/// Asserts that a value has the expected type. Panics with a consistent message if not.
#let assert-type(
  /// The parameter name.
  /// -> str
  param,
  /// The expected type (e.g., `int`, `str`).
  /// -> type
  expected-type,
  /// The actual value received.
  /// -> any
  value,
  /// The language code, or `none` for the top-level function.
  /// -> str | none
  lang: none,
) = {
  let value-type = type(value)
  assert(
    value-type == expected-type,
    message: _prefix(lang) + ": expected " + str(expected-type) + " for '" + param + "', got " + str(value-type),
  )
}

/// Asserts that a language code is supported.
#let assert-lang(
  /// The language code to check.
  /// -> str
  lang,
  /// The supported languages (array of strings or dictionary with language keys).
  /// -> array | dictionary
  supported,
) = {
  assert(
    lang in supported,
    message: _prefix(none) + ": unsupported language '" + lang + "'",
  )
}

/// Asserts that a parameter value is among a set of supported values. Used for
/// any option with a finite set of valid choices (e.g. `form`, `gender`).
#let assert-option(
  /// The parameter name.
  /// -> str
  param,
  /// The value to check.
  /// -> any
  value,
  /// The supported values (array, or dictionary whose keys are the supported values).
  /// -> array | dictionary
  supported,
  /// The language code, or `none` for the top-level function.
  /// -> str | none
  lang: none,
) = {
  assert(
    value in supported,
    message: _prefix(lang) + ": unsupported value '" + str(value) + "' for '" + param + "'",
  )
}

/// Asserts that a number is within the supported range. Panics if not.
#let out-of-range(
  /// The number to check.
  /// -> int
  number,
  /// The minimum supported value, or `none` if unbounded below.
  /// -> int | none
  min: none,
  /// The maximum supported value, or `none` if unbounded above.
  /// -> int | none
  max: none,
  /// The language code, or `none` for the top-level function.
  /// -> str | none
  lang: none,
) = {
  let in-range = (
    (min == none or number >= min) and (max == none or number <= max)
  )
  let range-str = if min != none and max != none {
    "[" + str(min) + ", " + str(max) + "]"
  } else if min != none {
    ">= " + str(min)
  } else {
    "<= " + str(max)
  }
  assert(
    in-range,
    message: _prefix(lang) + ": number " + str(number) + " is out of range (" + range-str + ")",
  )
}
