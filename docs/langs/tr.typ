#import "@preview/mantys:1.0.2": arg

== Turkish

Language code: `"tr"`.

=== Options

/ #arg("form"): The output form. One of `"cardinal"` (default), `"ordinal"` or `"year"`.
/ #arg("negative"): The prefix used for negative numbers. Defaults to `"eksi"`.

=== Forms

==== Cardinal

The default form. Converts numbers to their cardinal word representation.

```example
#num2words(42, lang: "tr")
```

Turkish drops the "bir" of the hundreds and thousands groups, so 100 is "yüz" and 1000 is "bin":

```example
#num2words(1000, lang: "tr")
```

```example
#num2words(1001000, lang: "tr")
```

Negative numbers are prefixed with the value of #arg("negative"):

```example
#num2words(-7, lang: "tr")
```

```example
#num2words(-7, lang: "tr", negative: "negatif")
```

==== Ordinal

Converts numbers to their ordinal word form. The suffix follows vowel harmony, and a final "t" becomes "d".

```example
#num2words(1, lang: "tr", form: "ordinal")
```

```example
#num2words(4, lang: "tr", form: "ordinal")
```

```example
#num2words(42, lang: "tr", form: "ordinal")
```

==== Year

Turkish reads years as plain cardinals, so this form matches the cardinal one.

```example
#num2words(1999, lang: "tr", form: "year")
```

```example
#num2words(2024, lang: "tr", form: "year")
```
