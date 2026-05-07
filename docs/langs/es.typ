#import "@preview/mantys:1.0.2": arg

== Spanish

Language code: `"es"`.

=== Options

/ #arg("form"): The output form. One of `"cardinal"` (default) or `"ordinal"`.
/ #arg("gender"): Grammatical gender. One of `"masculine"` (default) or `"feminine"`. Affects cardinals
  (`"una"`, `"veintiuna"`, `"doscientas"`, `"veintiuna mil personas"`) and ordinals (`"primera"`, `"vigésima tercera"`).
  Scale nouns (`mil`, `millón`, `billón`, …) are invariable and stay masculine.
/ #arg("apocopated"): Whether to return the apocopated ordinal form (`"primer"`, `"tercer"`,
  `"vigésimo primer"`, `"decimotercer"`). Defaults to `false`. Only available for ordinals in masculine; combining it
  with `gender: "feminine"` raises an error, since Spanish has no feminine apocopated ordinal.
/ #arg("negative"): The prefix used for negative numbers. Defaults to `"menos"`.

=== Forms

==== Cardinal

The default form. Converts numbers to their cardinal word representation, using the long-scale convention ($10^9$ is
`mil millones`, $10^{12}$ is `billón`, etc.).

```example
#num2words(42, lang: "es")
```

```example
#num2words(100, lang: "es") / #num2words(101, lang: "es")
```

```example
#num2words(21, lang: "es") / #num2words(21000, lang: "es")
```

```example
#num2words(1000000000000, lang: "es")
```

Negative numbers are prefixed with the value of #arg("negative"):

```example
#num2words(-7, lang: "es")
```

```example
#num2words(-7, lang: "es", negative: "bajo")
```

Use #arg("gender") to obtain the feminine form. Hundreds and the digits "uno"/"veintiuno" inflect; multi-word
numbers agree with the noun even before "mil":

```example
#num2words(1, lang: "es", gender: "feminine") / #num2words(200, lang: "es", gender: "feminine")
```

```example
#num2words(21000, lang: "es", gender: "feminine") personas
```

Scale words like `mil`, `millón`, `billón`, … are themselves nouns and impose their own (masculine) agreement, so the
preceding cardinal stays masculine regardless of #arg("gender"):

```example
#num2words(1000000, lang: "es", gender: "feminine") de personas
```

==== Ordinal

Converts numbers to their ordinal word form. Ordinals are supported in the closed range $[1, 999]$. Values outside the
supported range raise an out-of-range error.

```example
#num2words(1, lang: "es", form: "ordinal")
```

```example
#num2words(11, lang: "es", form: "ordinal")
```

```example
#num2words(21, lang: "es", form: "ordinal")
```

```example
#num2words(100, lang: "es", form: "ordinal")
```

The feminine form replaces the trailing `-o` of every word with `-a`:

```example
#num2words(21, lang: "es", form: "ordinal", gender: "feminine")
```

The apocopated form drops the final `-o` of `primero`/`tercero` (and their compounds) — used immediately before a
noun. It is only available in masculine:

```example
#num2words(1, lang: "es", form: "ordinal", apocopated: true) capítulo
```

```example
#num2words(23, lang: "es", form: "ordinal", apocopated: true) capítulo
```
