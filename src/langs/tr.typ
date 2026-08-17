/// Turkish (Turkey) number-to-words conversion.
#import "../errors.typ"

/// The language code for this module.
#let _lang-code = "tr"

// Data tables.

/// Words for numbers 0–9.
#let _units = (
  "sıfır",
  "bir",
  "iki",
  "üç",
  "dört",
  "beş",
  "altı",
  "yedi",
  "sekiz",
  "dokuz",
)

/// Words for multiples of ten from 10–90.
#let _tens = (
  "on",
  "yirmi",
  "otuz",
  "kırk",
  "elli",
  "altmış",
  "yetmiş",
  "seksen",
  "doksan",
)

/// Scale words for groups of three digits (short scale).
#let _scales = (
  "",
  "bin",
  "milyon",
  "milyar",
  "trilyon",
  "katrilyon",
  "kentilyon",
  "sekstilyon",
  "septilyon",
  "oktilyon",
  "nonilyon",
  "desilyon",
  "undesilyon",
  "dodesilyon",
  "tredesilyon",
  "katordesilyon",
  "kendesilyon",
  "seksdesilyon",
  "septendesilyon",
  "oktodesilyon",
  "novemdesilyon",
  "vigintilyon",
)

/// Supported forms for this language module.
#let _supported-forms = ("cardinal", "ordinal", "year")

// Cardinal helpers.

/// Converts a number in the range 1–99 to its cardinal word form.
///
/// -> str
#let _convert-below-100(
  /// The number to convert (1–99).
  /// -> int
  number,
) = {
  if number < 10 {
    _units.at(number)
  } else {
    let tens-digit = calc.quo(number, 10)
    let units-digit = calc.rem(number, 10)
    if units-digit == 0 {
      _tens.at(tens-digit - 1)
    } else {
      _tens.at(tens-digit - 1) + " " + _units.at(units-digit)
    }
  }
}

/// Converts a number in the range 1–999 to its cardinal word form.
///
/// -> str
#let _convert-below-1000(
  /// The number to convert (1–999).
  /// -> int
  number,
) = {
  if number < 100 {
    _convert-below-100(number)
  } else {
    let hundreds-digit = calc.quo(number, 100)
    let remainder = calc.rem(number, 100)

    // Exception: "100" = "yüz" but not "bir yüz"
    let hundreds-part = (
      if hundreds-digit == 1 {
        ""
      } else {
        _units.at(hundreds-digit) + " "
      }
        + "yüz"
    )

    if remainder == 0 {
      hundreds-part
    } else {
      hundreds-part + " " + _convert-below-100(remainder)
    }
  }
}

/// Recursively splits a number into 3-digit chunks and converts each chunk,
/// appending the appropriate scale word.
///
/// -> array
#let _chunk-and-convert(
  /// The remaining number to convert.
  /// -> int
  number,
  /// The current scale index (0 = units, 1 = thousands, etc.).
  /// -> int
  scale-index,
) = {
  if number == 0 {
    ()
  } else {
    errors.out-of-range(scale-index, max: _scales.len() - 1, lang: _lang-code)
    let chunk = calc.rem(number, 1000)
    let rest = calc.quo(number, 1000)
    let higher = _chunk-and-convert(rest, scale-index + 1)
    if chunk == 0 {
      higher
    } else {
      // Exception: the thousands group drops "bir", so 1000 is "bin" and not "bir bin".
      let words = if scale-index == 1 and chunk == 1 {
        _scales.at(1)
      } else if scale-index > 0 {
        _convert-below-1000(chunk) + " " + _scales.at(scale-index)
      } else {
        _convert-below-1000(chunk)
      }
      higher + (words,)
    }
  }
}

/// Converts a positive integer to its cardinal word form.
///
/// -> str
#let _convert-cardinal(
  /// The number to convert (>= 1).
  /// -> int
  number,
) = {
  _chunk-and-convert(number, 0).join(" ")
}

// Ordinal helpers.

/// The vowels of the Turkish alphabet.
#let _vowels = "aeıioöuü"

/// The suffix vowel required by each possible last vowel of a cardinal, following vowel harmony.
#let _ordinal-vowels = (
  "a": "ı",
  "e": "i",
  "ı": "ı",
  "i": "i",
  "o": "u",
  "ö": "ü",
  "u": "u",
  "ü": "ü",
)

/// Transforms a full cardinal string into its ordinal form by ordinalizing
/// according to the last letter and last vowel.
///
/// -> str
#let _cardinal-to-ordinal(
  /// The cardinal string to transform.
  /// -> str
  cardinal,
) = {
  let all-letters = cardinal.clusters()
  let last-letter = all-letters.last()

  // Alternation: a final "t" becomes "d", so "dört" gives "dörd" and then "dördüncü".
  if last-letter == "t" {
    cardinal = all-letters.slice(0, -1).join() + "d"
  }

  let ends-with-vowel = last-letter in _vowels
  let last-vowel = all-letters.rev().find(letter => letter in _vowels)
  let ordinal-vowel = _ordinal-vowels.at(last-vowel)

  // The suffix vowel comes from vowel harmony, and is repeated before "nc" only when the cardinal ends in a
  // consonant: "iki" gives "ikinci", but "bir" gives "birinci" and "altı" gives "altıncı".
  let ordinal-part = (
    if ends-with-vowel {
      ""
    } else {
      ordinal-vowel
    }
      + "nc"
      + ordinal-vowel
  )

  return cardinal + ordinal-part
}

/// Converts a positive integer to its ordinal word form.
///
/// -> str
#let _convert-ordinal(
  /// The number to convert (>= 1).
  /// -> int
  number,
) = {
  let cardinal = _convert-cardinal(number)
  _cardinal-to-ordinal(cardinal)
}

// Year helpers.

/// Converts a positive integer to its year reading form. Turkish reads years as plain cardinals, so 1999 is
/// "bin dokuz yüz doksan dokuz".
///
/// -> str
#let _convert-year(
  /// The number to convert (>= 1).
  /// -> int
  number,
) = {
  _convert-cardinal(number)
}

// Public entry point.

/// Converts a number to its Turkish word form.
///
/// -> str
#let convert(
  /// The number to convert.
  /// -> int
  number,
  /// The form: `"cardinal"`, `"ordinal"`, or `"year"` (default: `"cardinal"`).
  /// -> str
  form: "cardinal",
  /// The prefix for negative numbers (default: `"eksi"`).
  /// -> str
  negative: "eksi",
) = {
  errors.assert-type("form", str, form, lang: _lang-code)
  errors.assert-option("form", form, _supported-forms, lang: _lang-code)
  errors.assert-type("negative", str, negative, lang: _lang-code)

  if number == 0 {
    if form == "ordinal" {
      "sıfırıncı"
    } else {
      "sıfır"
    }
  } else {
    let prefix = if number < 0 { negative + " " } else { "" }
    let abs-number = calc.abs(number)
    let result = if form == "cardinal" {
      _convert-cardinal(abs-number)
    } else if form == "ordinal" {
      _convert-ordinal(abs-number)
    } else {
      _convert-year(abs-number)
    }
    prefix + result
  }
}
