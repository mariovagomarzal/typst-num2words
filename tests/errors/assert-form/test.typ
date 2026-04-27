/// Tests for the `assert-form` error helper.
#import "/src/errors.typ": assert-form

// Passes when the form is in the supported list.
#assert-form("cardinal", ("cardinal", "ordinal"), "en")

// Passes when the form is a key in the supported dictionary.
#assert-form("cardinal", (cardinal: none, ordinal: none), "en")

// Panics when the form is not supported.
#assert.eq(
  catch(() => assert-form("roman", ("cardinal", "ordinal"), "en")),
  "assertion failed: num2words (en): unsupported form 'roman'",
)
