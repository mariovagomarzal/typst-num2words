/// Tests that `num2words` uses the fallback chain correctly.
#import "/src/lib.typ": num2words

// The default fallback is `none`: an unsupported language silently produces an empty result.
[#num2words(0, lang: "xx")]

// Primary supported: fallback is ignored.
#num2words(1, lang: "en", fallback: ("es",))

// Primary unsupported, first fallback wins.
#num2words(2, lang: "xx", fallback: ("es", "en"))

// Primary unsupported, second fallback wins.
#num2words(3, lang: "xx", fallback: ("yy", "en"))

// Single string fallback.
#num2words(4, lang: "xx", fallback: "en")

// The `none` sentinel returns an empty result.
[#num2words(5, lang: "xx", fallback: none)]

// A chain ending in `none`: try "en" first and never reach `none` because "en" is supported.
[#num2words(6, lang: "xx", fallback: ("en", none))]

// When `none` is reached before exhausting the chain, the search stops and returns an empty result.
[#num2words(7, lang: "xx", fallback: (none, "en"))]
