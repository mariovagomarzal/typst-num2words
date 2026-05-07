/// Tests for the `assert-option` error helper.
#import "/src/errors.typ": assert-option

// Passes when the value is in the supported array.
#assert-option("form", "cardinal", ("cardinal", "ordinal"))

// Passes when the value is a key in the supported dictionary.
#assert-option("gender", "feminine", (masculine: none, feminine: none))

// Panics when the value is not supported (with a language tag).
#assert.eq(
  catch(() => assert-option("form", "roman", ("cardinal", "ordinal"), lang: "en")),
  "assertion failed: num2words (en): unsupported value 'roman' for 'form'",
)

// Without a language, the prefix omits the language tag.
#assert.eq(
  catch(() => assert-option("gender", "neuter", ("masculine", "feminine"))),
  "assertion failed: num2words: unsupported value 'neuter' for 'gender'",
)
