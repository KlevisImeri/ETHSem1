#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
latexmk -pdf -interaction=nonstopmode -halt-on-error "${1:-1_placing_fire_trucks.tex}"
