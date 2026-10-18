# Advanced Algorithms Notes

## Writing convention

- Use symbols, formulas, implications, and diagrams instead of explanatory prose.
- Define every symbol before its first use.
- Use text only when notation alone would be ambiguous or when an essential qualification cannot be expressed clearly with symbols.
- Keep definitions and proofs compact.
- Append new questions after the last existing question in the relevant Questions section; preserve the order of existing questions.
- Write instance inputs as `I = {S = {...}, ...}`, with the item set and all other instance data inside the outer braces.

## Compilation

Run `./r.sh <file.tex>` to compile a document, e.g. `./r.sh notes.tex` or `./r.sh exercises.tex`. Defaults to `notes.tex` when no argument is given. The shared preamble lives in `preamble.tex`.
