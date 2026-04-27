#import "@preview/mantys:1.0.2": arg, example, typ

= Usage

== The `num2words` function

The package provides a single main function, @cmd:num2words, that converts numbers to their written word form. To use
it, import the package and call the function with a number:

#example[
  ```typ
  #import "@preview/num2words:0.1.0": num2words

  #num2words(42)
  ```
][
  forty-two
]

The @cmd:num2words function always takes a positional #arg("number") argument and an optional #arg("lang") keyword
argument (explained in the next section). Any other arguments are forwarded to the language-specific converter function.
This means that the available options depend on the selected language --- see @chp:supported-languages for the full list
of options for each language.

For example, the standard behavior for most of the languages is to produce cardinal forms by default, but if the
language supports it, you can request a different #arg("form"):

```example
#num2words(3, lang: "en", form: "ordinal")
```

Depending on the language, you may also specify additional options. For instance, the English converter allows
customizing the prefix for negative numbers:

```example
#num2words(-10, lang: "en", negative: "minus")
```

== Language selection

The @cmd:num2words function selects the conversion language through the #arg("lang") argument. It can be set to any
supported language code (see @chp:supported-languages) or left as #typ.t.auto (the default), in which case it uses the
document's current `text.lang` setting:

```example
#set text(lang: "en")

The number 100 is written as #num2words(100).
```

As shown in previous examples, you can also pass the language code explicitly:

```example
#num2words(100, lang: "en")
```
