#import "@preview/mantys:1.0.2": arg

== English (US)

Language code: `"en"`.

=== Options

/ #arg("form"): The output form. One of `"cardinal"` (default), `"ordinal"`, or `"year"`.
/ #arg("negative"): The prefix used for negative numbers. Defaults to `"negative"`.

=== Forms

==== Cardinal

The default form. Converts numbers to their cardinal word representation.

```example
#num2words(42, lang: "en")
```

```example
#num2words(1000, lang: "en")
```

Negative numbers are prefixed with the value of #arg("negative"):

```example
#num2words(-7, lang: "en")
```

```example
#num2words(-7, lang: "en", negative: "minus")
```

==== Ordinal

Converts numbers to their ordinal word form.

```example
#num2words(1, lang: "en", form: "ordinal")
```

```example
#num2words(42, lang: "en", form: "ordinal")
```

==== Year

Converts numbers using English year-reading conventions (e.g., splitting into two-digit groups).

```example
#num2words(1999, lang: "en", form: "year")
```

```example
#num2words(2005, lang: "en", form: "year")
```

```example
#num2words(2024, lang: "en", form: "year")
```
