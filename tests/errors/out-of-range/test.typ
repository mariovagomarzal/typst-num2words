/// Tests for the `out-of-range` error helper.
#import "/src/errors.typ": out-of-range

// Passes when the number is within range.
#out-of-range(5, min: 0, max: 10)
#out-of-range(0, min: 0)
#out-of-range(-1, max: 0)

// Panics when below the minimum (both bounds, no lang).
#assert.eq(
  catch(() => out-of-range(-1, min: 0, max: 100)),
  "assertion failed: num2words: number \u{2212}1 is out of range ([0, 100])",
)

// Panics when above the maximum (both bounds, with lang).
#assert.eq(
  catch(() => out-of-range(101, min: 0, max: 100, lang: "en")),
  "assertion failed: num2words (en): number 101 is out of range ([0, 100])",
)

// Panics with min-only bound.
#assert.eq(
  catch(() => out-of-range(-1, min: 0)),
  "assertion failed: num2words: number \u{2212}1 is out of range (>= 0)",
)

// Panics with max-only bound.
#assert.eq(
  catch(() => out-of-range(1, max: 0)),
  "assertion failed: num2words: number 1 is out of range (<= 0)",
)
