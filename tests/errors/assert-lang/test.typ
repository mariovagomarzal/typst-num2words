/// Tests for the `assert-lang` error helper.
#import "/src/errors.typ": assert-lang

// Passes when the language is in the supported list (array).
#assert-lang("en", ("en", "es"))

// Passes when the language is a key in the supported dictionary.
#assert-lang("en", (en: none, es: none))

// Panics when the language is not supported.
#assert.eq(
  catch(() => assert-lang("fr", ("en", "es"))),
  "assertion failed: num2words: unsupported language 'fr'",
)
