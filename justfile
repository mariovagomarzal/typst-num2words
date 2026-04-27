[private]
default:
    @just --list --unsorted

[group("style")]
format-typst INPUT_FILES=".":
    typstyle --verbose --inplace --line-width 120 --indent-width 2 {{INPUT_FILES}}

alias ft := format-typst
