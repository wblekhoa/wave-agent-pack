---
id: wave-agent-pack-logic-install-verify
type: logic
product: wave-agent-pack
title: "WAVE agent pack — Install and verify (logic)"
status: active
updated: 2026-10-11
reqPrefix: [WAP-INST, WAP-VER]
relations:
  specifiedBy: [wave-agent-pack-ux-install-verify]
  implements: [skills/deep-research/evals/verify.mjs, skills/audit-codex-storage/evals/verify.mjs, .github/workflows/verify.yml]
---
# WAVE agent pack — Install and verify (logic)

## Purpose
- Decide what a package must contain and prove before it counts as installable, and how that proof runs locally and in
  CI.
- Success signal: every package verifier exits 0 on `main`; a package that breaks any rule below fails its verifier.

## Rules

Evidence notes: each live REQ-ID is a trailing comment on the line that checks it, in both package verifiers
(`skills/*/evals/verify.mjs`) unless the row names one package. The verifiers run locally and in the `Verify skills`
workflow.

| REQ-ID | Rule (behaviour-changing) | Status (live / not built / blocked) | Evidence (code path or test) |
|---|---|---|---|
| WAP-INST-001 | A package declares runtime adapters for exactly `claude-code`, `codex`, `gemini-cli`, `hermes` and `openclaw`, each with the folder it is copied to. | live | `skills/*/evals/verify.mjs` (`compatibility.adapters` assertion) |
| WAP-INST-002 | An install script copies a package into the target runtime folder, refuses to overwrite a skill it does not own, and checks discovery. | not built | install is a manual folder copy documented in the READMEs |
| WAP-VER-001 | `SKILL.md` frontmatter starts with `name: <package>`, and the manifest `name` equals the package name. | live | `skills/*/evals/verify.mjs` |
| WAP-VER-002 | A package has exactly 20 trigger cases: 10 `USE`, 10 `DO_NOT_USE`, all ids unique. | live | `skills/*/evals/verify.mjs` |
| WAP-VER-003 | Report-quality cases cover exactly the package's required categories (8 each), one case per category, unique ids, each with ≥2 evidence items, required and forbidden behaviours. | live | `skills/*/evals/verify.mjs` |
| WAP-VER-004 | The portable text contains none of the package's configured private markers (`publication.private_markers`). | live | `skills/*/evals/verify.mjs` (deep-research checks `SKILL.md`; audit-codex-storage checks `SKILL.md`, README, helper and decision model) |
| WAP-VER-005 | CI runs every `skills/*/evals/verify.mjs` on pushes to `main`, pull requests and manual dispatch, and fails when no verifier exists. | live | `.github/workflows/verify.yml` |
| WAP-VER-006 | The `audit-codex-storage` helper contains no file-removing or renaming call (`os.remove`, `unlink`, `shutil.rmtree`, `os.rename`). | live | `skills/audit-codex-storage/evals/verify.mjs` |
| WAP-VER-007 | The `audit-codex-storage` helper's Python unit tests pass. | live | `skills/audit-codex-storage/evals/verify.mjs` (runs `python3 -m unittest` on `tests/`) |
| WAP-VER-008 | Anyone with this repository alone can regenerate and check `verification-receipt.json`. | not built | the receipt writer is a private tool (`evaluator: scripts/skill-package.mjs`) not shipped here |

## States and transitions
| State | Trigger | Next state | Edge case |
|---|---|---|---|
| package changed | edit any file under `skills/<name>/` | receipt stale | the receipt hashes every package file except itself |
| receipt stale | maintainer regenerates the receipt (private tool) | receipt current | a changed package must raise its version, or installs owned by the private installer refuse to update |
| receipt current | push / pull request | CI green or red | CI runs the verifiers only; it does not check receipt hashes |

## Fixed vs flexible
- Fixed: the five adapters; balanced 20-case trigger set; no private markers in portable text; CI runs every verifier.
- Flexible: package wording, report-quality categories per package, which runtimes a future package adds (would change
  WAP-INST-001 for that package).

## Open questions
- Should CI also check receipt hashes, so a stale receipt fails the build (needs WAP-VER-008 first)?

## Change log
- 2026-10-11: created; REQ-IDs added as trailing comments in both verifiers and the workflow in the same commit.
