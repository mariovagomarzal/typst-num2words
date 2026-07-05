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

/// Cardinal words whose ordinal form is irregular.
#let _ordinal-irregulars = (
  // All ordinals in Turkish are regular!
)

/// Supported forms for this language module.
#let _supported-forms = ("cardinal", "ordinal", "year")

// Cardinal helpers.

/// Converts a number in the range 1–99 to its cardinal word form.
///
/// - number (int): The number to convert (1–99).
/// -> str
#let _convert-below-100(number) = {
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
/// - number (int): The number to convert (1–999).
/// -> str
#let _convert-below-1000(number) = {
  if number < 100 {
    _convert-below-100(number)
  } else {
    let hundreds-digit = calc.quo(number, 100)
    let remainder = calc.rem(number, 100)

    // Exception: "100" = "yüz" but not "bir yüz"
    let hundreds-part = if hundreds-digit == 1 {
      ""
    } else {
      _units.at(hundreds-digit) + " "
    } + "yüz"
    
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
/// - number (int): The remaining number to convert.
/// - scale-index (int): The current scale index (0 = units, 1 = thousands, etc.).
/// -> array
#let _chunk-and-convert(number, scale-index) = {
  if number == 0 {
    ()
  } else {
    let chunk = calc.rem(number, 1000)
    let rest = calc.quo(number, 1000)
    let higher = if rest == 1 and scale-index == 0 {
      ("bin", ) // Exception: "1000" = "bin" but not "bir bin"
    } else {
      _chunk-and-convert(rest, scale-index + 1)
    }
    if chunk == 0 {
      higher
    } else {
      let words = _convert-below-1000(chunk)
      if scale-index > 0 {
        words = words + " " + _scales.at(scale-index)
      }
      higher + (words,)
    }
  }
}

/// Converts a positive integer to its cardinal word form.
///
/// - number (int): The number to convert (>= 1).
/// -> str
#let _convert-cardinal(number) = {
  _chunk-and-convert(number, 0).join(" ")
}

// Ordinal helpers.

#let vowels = "aeıioöuü"

#let ordinal-vowel-dict = (
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
/// - cardinal (str): The cardinal string to transform.
/// -> str
#let _cardinal-to-ordinal(cardinal) = {
  let all-letters = cardinal.clusters()
  let length = all-letters.len()
  let last-letter = all-letters.last()

  // Convert last letter to "d" if it is "t":
  // "dört" --> "dörd" --> dördüncü
  if last-letter == "t" {
    let root = all-letters.slice(0, -1).join() // All letters except the last letter
    cardinal = root + "d"
  }

  let ends-with-vowel = last-letter in vowels

  // Find the last vowel in the cardinal:
  let last-vowel = ""

  let ndx = length - 1
  let flag = true

  while ndx >= 0 and flag {
    let letter = all-letters.at(ndx)
    if vowels.contains(letter) {
      last-vowel = letter
      flag = false
    }
    ndx -= 1
  }

  let ordinal-vowel = ordinal-vowel-dict.at(last-vowel)

  // Compute the ordinal suffix based on whether the cardinal ends with a vowel or consonant.
  // Based on the last vowel, we determine the appropriate vowel for the suffix.
  // bir --> birinci
  // iki --> ikinci
  // üç --> üçüncü
  // dört --> dördüncü (note: we already handled the "t" to "d" conversion above)
  // altı --> altıncı
  // etc.
  let ordinal-part = if ends-with-vowel {
    ""
  } else {
    ordinal-vowel
  } + "nc" + ordinal-vowel

  return cardinal + ordinal-part
}

/// Converts a positive integer to its ordinal word form.
///
/// - number (int): The number to convert (>= 1).
/// -> str
#let _convert-ordinal(number) = {
  let cardinal = _convert-cardinal(number)
  _cardinal-to-ordinal(cardinal)
}

// Year helpers.

/// Converts a positive integer to its year reading form.
///
/// - number (int): The number to convert (>= 1).
/// -> str
#let _convert-year(number) = {
  return _convert-cardinal(number)
}

// Public entry point.

/// Converts a number to its English word form.
///
/// - number (int): The number to convert.
/// - form (str): The form: `"cardinal"`, `"ordinal"`, or `"year"` (default: `"cardinal"`).
/// - negative (str): The prefix for negative numbers (default: `"eksi"`).
/// -> str
#let convert(number, form: "cardinal", negative: "eksi") = {
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