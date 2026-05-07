#import "@preview/mantys:1.0.2": arg

== Catalan

Language code: `"ca"`.

=== Options

/ #arg("form"): The output form. One of `"cardinal"` (default) or `"ordinal"`.
/ #arg("gender"): Grammatical gender. One of `"masculine"` (default) or `"feminine"`. Affects cardinals
  (`"una"`, `"dues"`, `"vint-i-una"`, `"dues-centes"`, `"vint-i-una mil persones"`) and ordinals (`"primera"`,
  `"vint-i-unena"`). Scale nouns (`mil`, `milió`, `bilió`, …) are invariable and stay masculine.
/ #arg("apocopated"): Whether to return the apocopated cardinal form (`"un"`, `"vint-i-un"`, `"trenta-un"`,
  `"cent un"`). Defaults to `false`. Only available for cardinals in masculine; combining it with `form: "ordinal"`
  or `gender: "feminine"` raises an error.
/ #arg("negative"): The prefix used for negative numbers. Defaults to `"menys"`.

=== Forms

==== Cardinal

The default form. Converts numbers to their cardinal word representation, using the long-scale convention ($10^9$ is
`mil milions`, $10^(12)$ is `bilió`, etc.) and the IEC 2017 hyphenation rules within each hundreds–tens–units block.

```example
#num2words(42, lang: "ca")
```

```example
#num2words(100, lang: "ca") / #num2words(101, lang: "ca")
```

```example
#num2words(245, lang: "ca")
```

```example
#num2words(1000000000000, lang: "ca")
```

Negative numbers are prefixed with the value of #arg("negative"):

```example
#num2words(-7, lang: "ca")
```

```example
#num2words(-7, lang: "ca", negative: "negatiu")
```

The default form for `1` and its compounds is the counting form `"u"` (`"vint-i-u"`, `"trenta-u"`, `"cent u"`). Use
#arg("apocopated") to obtain the form used before a noun (`"un"`, `"vint-i-un"`, `"trenta-un"`):

```example
#num2words(1, lang: "ca", apocopated: true) llibre
```

```example
#num2words(21, lang: "ca", apocopated: true) capítols
```

When a scale word (`mil`, `milió`, …) follows, the trailing unit is always apocopated regardless of #arg("apocopated"):

```example
#num2words(21000, lang: "ca")
```

Use #arg("gender") to obtain the feminine form. Only `u` and `dos` (and the hundreds 200–900) inflect; multi-word
numbers agree with the noun even before "mil":

```example
#num2words(1, lang: "ca", gender: "feminine") / #num2words(200, lang: "ca", gender: "feminine")
```

```example
#num2words(21000, lang: "ca", gender: "feminine") persones
```

Scale words like `mil`, `milió`, `bilió`, … are themselves nouns and impose their own (masculine) agreement, so the
preceding cardinal stays masculine regardless of #arg("gender"):

```example
#num2words(1000000, lang: "ca", gender: "feminine") de persones
```

==== Ordinal

Converts numbers to their ordinal word form. Ordinals are supported in the closed range $[1, 999]$. Values outside the
supported range raise an out-of-range error.

```example
#num2words(1, lang: "ca", form: "ordinal")
```

```example
#num2words(11, lang: "ca", form: "ordinal")
```

```example
#num2words(21, lang: "ca", form: "ordinal")
```

```example
#num2words(100, lang: "ca", form: "ordinal")
```

In compound ordinals, the suffix `-è/-ena` is applied only to the last word. Hyphenated blocks (21–99 and the fused
hundreds 200–900) take the suffix on their final element (`vint-i-unè`, `trenta-dosè`, `dos-centè`); when the trailing
unit is separated by a space (101–104, 201–204, …), the standalone forms `primer`, `segon`, `tercer`, `quart` are used.

```example
#num2words(101, lang: "ca", form: "ordinal")
```

```example
#num2words(121, lang: "ca", form: "ordinal")
```

```example
#num2words(999, lang: "ca", form: "ordinal")
```

The feminine form replaces the trailing `-è` with `-ena` (or appends `-a` to `primer`/`segon`/`tercer`/`quart`):

```example
#num2words(21, lang: "ca", form: "ordinal", gender: "feminine")
```

```example
#num2words(101, lang: "ca", form: "ordinal", gender: "feminine")
```
