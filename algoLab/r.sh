#!/usr/bin/env bash

set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
mkdir -p output
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=output "${1:-as.tex}"
