/// Tests for the `assert-type` error helper.
#import "/src/errors.typ": assert-type

// Passes when the value has the expected type.
#assert-type("number", int, 42)
#assert-type("name", str, "hello")

// Panics when the value has the wrong type (no lang).
#assert.eq(
  catch(() => assert-type("number", int, "hello")),
  "assertion failed: num2words: expected integer for 'number', got string",
)

// Panics when the value has the wrong type (with lang).
#assert.eq(
  catch(() => assert-type("number", int, "hello", lang: "en")),
  "assertion failed: num2words (en): expected integer for 'number', got string",
)
