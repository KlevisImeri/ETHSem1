#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
latexmk -pdf -interaction=nonstopmode -halt-on-error "${1:-3_scheduling_jobs_with_quadratic_load_cost_dynamic_programming_failed_attempt.tex}"
