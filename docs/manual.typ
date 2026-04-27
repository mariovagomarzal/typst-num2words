#import "@preview/mantys:1.0.2": git-info, mantys
#import "../src/lib.typ": num2words

#show: mantys(
  ..toml("../typst.toml"),
  title: "num2words",
  date: datetime.today(),
  abstract: [
    A Typst package to convert numbers to their written word form. It provides a single function, @cmd:num2words, that
    automatically adapts to the document's language and supports multiple output forms.
  ],
  examples-scope: (scope: (num2words: num2words)),
  git: git-info(file => read(file)),
)

#include "usage.typ"

#include "langs.typ"

#include "api.typ"
