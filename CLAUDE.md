# CLAUDE.md

Guidance for Claude Code (claude.ai/code) when working in this repository.

`num2words` is a Typst package that converts numbers to their written word form. It is written entirely in Typst
(`.typ`), with no Rust or other compiled code.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the development environment and the full tooling list. The commands used most
often are `just test` (all tests), `just test 'exact:langs/en'` (one test), `just ft` (format) and `just docs` (build
the manual).

## Layout

- `src/lib.typ` — entrypoint. Exports `num2words` and the `converters` dictionary.
- `src/errors.typ` — shared assertion helpers.
- `src/langs/<code>.typ` — one module per language, each exporting a `convert` function.
- `tests/<group>/<name>/test.typ` — tytanic tests.
- `docs/` — the manual, built with [mantys](https://github.com/jneug/typst-mantys).

A language is spread across the module, its entry in `converters` (`src/lib.typ`), its test directory, its prose
chapter (`docs/langs/<code>.typ`, included from `docs/langs.typ`), its API section (`docs/api.typ`) and the README
table. Missing either documentation step is silent — nothing fails, the manual is just incomplete. Use the
`add-language` skill when adding or reviewing one; it carries the full procedure and the required test cases.

## Docstrings

Documentation comments use the [tidy](https://github.com/Mc-Zen/tidy) 0.4.0+ syntax, where each argument is documented
**above the argument itself** and types go on a `-> type` line:

```typst
/// Converts a number to its written word form.
///
/// -> content
#let num2words(
  /// The number to convert.
  /// -> int
  number,
  /// The language code. When `auto`, uses the current `text.lang`.
  /// -> str | auto
  lang: auto,
) = { ... }
```

Do not use the pre-0.4.0 syntax (`- number (int): The number to convert.` inside the leading comment block). It is what
most examples on the web still show, but this repository was migrated away from it and the legacy parser is no longer
enabled in `docs/api.typ`.

Module files open with a single `///` line describing the module, with the imports immediately after and no blank line
between them.

## Errors

Converters never call bare `assert` or `panic`. They use the helpers in `src/errors.typ` — `assert-type`,
`assert-option`, `assert-lang`, `out-of-range` — passing `lang: _lang-code` so the message is scoped to the language.
This keeps error text uniform, and the tests in `tests/errors/` assert on those exact strings.

## Tests

Tests are plain Typst scripts run by [tytanic](https://typst-community.github.io/tytanic/) (`tt`). Three kinds:

- **compile-only** (`tt new -C <name>`) — passes if it compiles. Used for all assertion-based tests.
- **persistent** (`tt new <name>`) — output compared against reference images in `ref/`. Regenerate intentional
  changes with `tt update <name>`.
- **ephemeral** (`tt new -E <name>`) — rendered but not compared.

Language tests use the `check` helper from `tests/utils.typ`, which takes `(number, expected)` pairs (or `(number,
expected, extra-args)` triples) and reports the failing case:

```typst
#import "/tests/utils.typ": check

check(convert, ((0, "zero"), (42, "forty-two")))
check(convert, ((1, "first"),), form: "ordinal")
```

Two functions are injected into every test by the runner: `assert-panic(() => f())` asserts that a call panics, and
`catch(() => f())` returns the panic message (or `none`). Note that the panic message format is compiler-dependent —
Typst 0.15 stopped wrapping `panic()` string arguments in quotes.

## Conventions

- Formatting is typstyle at 120 columns, 2-space indent, enforced by a `prek` hook that pins its own typstyle version
  independently of the dev shell.
- Commits follow [Conventional Commits](https://www.conventionalcommits.org/), enforced by a commitizen `commit-msg`
  hook. Scopes are optional and recent (`feat(lang/tr):`, `docs(api):`); most of the history has none. What is
  consistent is the split: a new language lands as separate `feat`, `test` and `docs` commits rather than one.
- `compiler` in `typst.toml` is the **minimum** Typst version the package requires, not the version used to build it.
  Only raise it when the code actually starts depending on newer syntax or stdlib.
