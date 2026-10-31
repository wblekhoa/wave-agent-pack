#!/bin/bash
# WAVE agent pack gate for the JAK product-gate hooks (~/JAK/hq/githooks/gate.mjs, hq/plans/product-gates.md).
# Same check as CI (.github/workflows/verify.yml): every skills/*/evals/verify.mjs. Fast and full are the same (~2 s).
set -euo pipefail
cd "$(dirname "$0")/.."
found=0
for verifier in skills/*/evals/verify.mjs; do
  [ -f "$verifier" ] || continue
  found=1
  node "$verifier"
done
[ "$found" -eq 1 ] || { echo "No skill package verifier found." >&2; exit 1; }
