# Contributing

Thanks for your interest in contributing to `num2words`! Feel free to open an [issue][issues] to report bugs, request
features, or suggest support for new languages. Pull requests are also appreciated.

## Development environment

The easiest way to set up the development environment is with [devenv][devenv] (Nix-based). Once installed, run `devenv
shell` to enter the dev shell with all tooling available.

If you prefer a manual setup, you will need the following tools:

- [Typst][typst] (>=0.14.0): the Typst compiler.
- [just][just]: command runner for common tasks.
- [tytanic][tytanic] (`tt`): test runner for Typst.
- [typstyle][typstyle]: Typst formatter.
- [prek][prek]: pre-commit hook manager. Run `prek install -t pre-commit -t commit-msg` to install hooks.

## Key commands

As mentioned, the `just` command runner is used to simplify common tasks. Here are some key commands:

- `just test`: run all tests.
- `just format-typst` (or `just ft`): format Typst files.

Check the [justfile](/justfile) for the full list of commands.

## Commit conventions

This project follows [Conventional Commits][conventional-commits]. The convention is enforced by a
[commitizen][commitizen] pre-commit hook, so make sure hooks are installed before committing.

## Working with coding agents

The repository ships configuration for [Claude Code][claude-code] and similar agents. Using one is entirely optional,
and contributions written without them are just as welcome.

- [CLAUDE.md](/CLAUDE.md) collects the conventions of the codebase: docstring syntax, error helpers, test layout. It is
  plain prose, so it is worth a read even if you never use an agent.
- `.claude/skills/add-language/` describes the full procedure for adding a language, including the edge cases every
  language test is expected to cover.
- `.claude/settings.json` pre-approves the usual test, format and build commands so they run without prompting. Keep
  personal overrides in `.claude/settings.local.json`, which is ignored by Git.

<!-- External links -->

[issues]: https://github.com/mariovagomarzal/typst-num2words/issues
[typst]: https://typst.app/
[devenv]: https://devenv.sh/
[just]: https://just.systems/
[tytanic]: https://typst-community.github.io/tytanic/
[typstyle]: https://github.com/Enter-tainer/typstyle
[prek]: https://github.com/j178/prek
[conventional-commits]: https://www.conventionalcommits.org/
[commitizen]: https://commitizen-tools.github.io/commitizen/
[claude-code]: https://docs.claude.com/en/docs/claude-code/overview
