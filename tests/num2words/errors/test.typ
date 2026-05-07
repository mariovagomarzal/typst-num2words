/// Tests that `num2words` fails with appropriate errors.
#import "/src/lib.typ": num2words

// Check that `num2words` fails when given a non-integer input.
#assert.eq(
  catch(() => num2words("hello", lang: "en")),
  "assertion failed: num2words: expected integer for 'number', got string",
)

/* TODO: Check that `num2words` fails when given an unsupported language code.
Currently not possible because, when inside a `catch`/`assert-panic`, since the lang verification is done inside a
context block, the error is not propagated to the caller, and instead the function returns `context()`. */

// Check that `num2words` fails when given an invalid `fallback` argument.
#assert.eq(
  catch(() => num2words(1, lang: "en", fallback: 42)),
  "panicked with: \"num2words: 'fallback' entries must be strings or `none`, got integer at index 0\"",
)

#assert.eq(
  catch(() => num2words(1, lang: "en", fallback: ("en", 1))),
  "panicked with: \"num2words: 'fallback' entries must be strings or `none`, got integer at index 1\"",
)
