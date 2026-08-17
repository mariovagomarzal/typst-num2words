---
name: add-language
description: >-
  Add support for a new language to the num2words Typst package. Use when: (1) The user asks to add, implement or
  support a new language or locale, (2) Reviewing or fixing a contributed language module, (3) Extending an existing
  language with a new form (ordinal, year, gender, …).
---

# Adding a language to num2words

A language is a module exporting one `convert` function, registered in the package entrypoint, covered by tests, and
documented in two separate places. Skipping either documentation step fails silently — nothing breaks, the manual is
just incomplete.

Read an existing module before writing a new one. `src/langs/en.typ` is the smallest complete example with all three
forms; `src/langs/es.typ` additionally shows gender and apocope options.

## 1. Gather the linguistic rules first

Do not start from code. Establish, with the user or from a reliable source, at minimum:

- The scale convention: **short scale** (`10^9` = billion, as in `en`) or **long scale** (`10^9` = mil millones, `10^12`
  = billón, as in `es`/`ca`). Getting this wrong invalidates every large number.
- Whether the leading `one` is dropped before a scale word. Most languages drop it at a thousand (`mil`, not `un mil`;
  `bin`, not `bir bin`; `thousand`, not `one thousand`) but require it at a million. This asymmetry is the single most
  common source of bugs in this repository.
- Word joining: separate words, hyphens, or a single concatenated word (German writes `einhundertdreiundzwanzig`).
- Which forms apply. `cardinal` is mandatory. `ordinal` and `year` are optional per language, and `year` only makes
  sense where the language actually reads years specially.
- Any grammatical agreement the output depends on (gender, apocope), and the range over which each form is defined —
  Spanish and Catalan ordinals are only defined on `[1, 999]`.

State the assumptions you are working from. If a rule is uncertain, ask rather than guess: a wrong rule produces
plausible-looking output that only a speaker will catch.

## 2. The module

Create `src/langs/<code>.typ`, where `<code>` is the language's code as it appears in `text.lang`. Follow the section
order every existing module uses:

```typst
/// <Language> number-to-words conversion.
#import "../errors.typ"

/// The language code for this module.
#let _lang-code = "<code>"

// Data tables.
// _units, _tens, _scales, irregulars…, then:
#let _supported-forms = ("cardinal", "ordinal", "year")

// Cardinal helpers.
// small private helpers, ending in _convert-cardinal

// Ordinal helpers.
// ending in _convert-ordinal

// Year helpers.
// ending in _convert-year

// Public entry point.
#let convert(...) = { ... }
```

Rules the whole package relies on:

- Everything private is prefixed `_`. Only `convert` is public.
- `convert` takes `number` positionally, then `form: "cardinal"`, then any language-specific options, then `negative:`
  last. It returns a `str`, never content.
- `convert` opens with validation and nothing else, using the helpers in `src/errors.typ` — never a bare `assert` or
  `panic` — always passing `lang: _lang-code`:

  ```typst
  errors.assert-type("form", str, form, lang: _lang-code)
  errors.assert-option("form", form, _supported-forms, lang: _lang-code)
  errors.assert-type("negative", str, negative, lang: _lang-code)
  ```

- Guard the top of the scale with `errors.out-of-range` so numbers beyond the last `_scales` entry fail with a clear
  message instead of producing a wrong string or crashing on an index.
- Docstrings use the tidy 0.4.0+ syntax described in `CLAUDE.md`: each argument documented above itself, types on a `->
  type` line. Document range restrictions and option interactions in `convert`'s own docstring.

Register it in `src/lib.typ` — both the import and the `converters` entry:

```typst
#import "langs/<code>.typ"

#let converters = (
  ...,
  <code>: <code>.convert,
)
```

## 3. Tests

Create a compile-only test: `tt new -C langs/<code>`, giving `tests/langs/<code>/test.typ`. Use the `check` helper,
grouped by form, with the same comment sections the other languages use (`// Basic.`, `// Tens.`, `// Hundreds.`, `//
Thousands and beyond.`, `// Negative numbers.`):

```typst
/// Tests for <Language> number-to-words conversion.
#import "/src/lib.typ": converters
#import "/tests/utils.typ": check

#let convert = converters.<code>

// Cardinals.
#check(convert, ((0, "…"), (1, "…")))

// Ordinals.
#check(convert, ((1, "…"),), form: "ordinal")
```

### Mandatory edge cases

Every language bug fixed in this repository so far has been a large-number or scale-boundary bug — German scale words
and thousands in large numbers, German ordinals at millions and above, the Turkish thousands group under a higher scale
word. Basic cases pass while these fail, so cover them explicitly for **each supported form**:

- `0`, and a negative number (default prefix and a custom `negative:`).
- Each tens boundary: `10`, the full teens, `20`, `21`, `99`.
- `100`, `101`, `200`, `999` — where apocope and hundred agreement show up.
- **`1000` and `1000000`.** This is where the dropped leading `one` differs between scales. Add `1001`, `2000`, `100000`
  and `999999`.
- **Groups containing zero**, which is what silently breaks chunking: `1000001`, `1000000001`, `1000000000000`.
- The **last supported scale entry** and, via `assert-panic`, one number past it.
- For each option, at least one case combining it with a large number rather than only a small one.
- Any combination the module explicitly rejects, asserted with `assert-panic`.

Run `just test 'exact:langs/<code>'` while iterating, then `just test` before committing.

## 4. Documentation, both places

**Prose chapter.** Create `docs/langs/<code>.typ` mirroring `docs/langs/en.typ`: a `== <Language>` heading, the language
code, an `=== Options` list using `#arg("name")` from mantys, and an `=== Forms` section with a subsection per form
containing `example` blocks. Then add `#include "langs/<code>.typ"` to `docs/langs.typ`.

**API reference.** Add to `docs/api.typ`, under `== Languages`:

```typst
=== <Language>

#show-lang-module("<code>")
```

Neither omission produces an error, so verify with `just docs` and check that the new language appears in both the
languages chapter and the API reference.

Also add a row to the "Supported languages" table in `README.md`.

## 5. Commits

A language lands as separate commits rather than one, matching the existing history: the module and its registration
(`feat`), then the tests (`test`), then the documentation (`docs`). Keep subjects short and omit the body when the
change is self-evident.
