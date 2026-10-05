#!/usr/bin/env bash
# Compile the ZNP lecture notes.
# Usage: ./r.sh [file.tex]      (default: notes.tex)
#        ./r.sh --watch [file]  (recompile on every save; needs inotifywait)
set -euo pipefail

cd "$(dirname "$0")"

BOLD=$'\033[1m'; BLUE=$'\033[1;34m'; GREEN=$'\033[1;32m'
RED=$'\033[1;31m'; DIM=$'\033[2m'; RESET=$'\033[0m'

step() { printf '%s==>%s %s\n' "$BLUE" "$RESET" "$*"; }
fail() { printf '%sError:%s %s\n' "$RED" "$RESET" "$*"; exit 1; }

WATCH=0
if [[ "${1:-}" == "--watch" ]]; then WATCH=1; shift; fi
TEX="${1:-notes.tex}"
BASE="${TEX%.tex}"

command -v pdflatex >/dev/null || fail "pdflatex not found"
[[ -f "$TEX" ]] || fail "no such file: $TEX"

LOG="$(mktemp)"
trap 'rm -f "$LOG"' EXIT

compile() {
  step "Compiling ${BOLD}${TEX}${RESET} ${DIM}(pass 1/2)${RESET}"
  pdflatex -interaction=nonstopmode -halt-on-error -file-line-error "$TEX" >"$LOG" 2>&1 \
    || { show_errors; return 1; }

  step "Compiling ${BOLD}${TEX}${RESET} ${DIM}(pass 2/2)${RESET}"
  pdflatex -interaction=nonstopmode -halt-on-error -file-line-error "$TEX" >"$LOG" 2>&1 \
    || { show_errors; return 1; }

  rm -f "$BASE".aux "$BASE".log "$BASE".out "$BASE".toc
  local pages=""
  command -v pdfinfo >/dev/null && pages=", $(pdfinfo "$BASE.pdf" | awk '/^Pages/{print $2}') pages"
  printf '%s==>%s %sSuccess%s -> %s%s.pdf%s%s\n' \
    "$BLUE" "$RESET" "$GREEN" "$RESET" "$BOLD" "$BASE" "$RESET" "$pages"
}

show_errors() {
  step "${RED}Compilation failed${RESET}"
  grep -nE '^!|^[^:]+:[0-9]+:' "$LOG" | head -20 || tail -20 "$LOG"
}

if [[ "$WATCH" == 1 ]]; then
  command -v inotifywait >/dev/null || fail "--watch needs inotifywait"
  compile || true
  step "Watching ${BOLD}${TEX}${RESET} for changes... (Ctrl-C to stop)"
  while inotifywait -q -e close_write,move_self "$TEX" >/dev/null; do compile || true; done
else
  compile
fi
