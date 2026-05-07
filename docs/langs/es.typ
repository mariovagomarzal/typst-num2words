#import "@preview/mantys:1.0.2": arg

== Spanish

Language code: `"es"`.

=== Options

/ #arg("form"): The output form. One of `"cardinal"` (default) or `"ordinal"`.
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
