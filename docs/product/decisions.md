---
id: wave-agent-pack-decisions
type: decision
product: wave-agent-pack
title: "WAVE agent pack — Decisions"
status: active
updated: 2026-10-11
summary: "Append-only decisions: one public skill collection with split-out rules, CI verification of every package, the read-only Codex storage audit, the rename and debrand to WAVE agent pack, and the product-docs layout."
tags: [area/ai, area/release, area/docs]
---
# WAVE agent pack — Decisions (append-only, newest first)

Entries before 2026-10-11 are reconstructed from the README and commit messages; hashes are in this repository.

## 2026-10-11 · Product docs in `docs/product/`, REQ-IDs as trailing comments
- **Context**: the pack had a README per package but no record of its install/verify rules or its decisions.
- **Decision**: adopt the goal / ux / logic / decisions / releases layout. REQ-IDs `WAP-INST-*` and `WAP-VER-*` are
  trailing comments on existing verifier lines and on the CI loop, so no assertion changed. Rules with no code behind
  them (an install script, a public receipt writer) are recorded as `not built`.
- **Evidence**: both `evals/verify.mjs` print `PASS` after the edit; receipts regenerated afterwards (next entry).
- **Reversal**: delete `docs/product/` and the `WAP-` comments, then regenerate both receipts.

## 2026-10-11 · Rename to `wave-agent-pack` and remove the former employer's brand
- **Context**: the owner left the company whose name the collection carried, and renamed the GitHub repository to
  `wblekhoa/wave-agent-pack` so it joins the WAVE family. A public repository must not keep a former employer's brand,
  paths or people.
- **Decision**: title "WAVE agent pack"; clone and copy commands point at `wave-agent-pack`; manifest `owner.id` and
  `canonical_repository` point at the new repository; the copyright line of the pack's own MIT licence names "WAVE
  agent pack contributors"; Deep Research's provenance reads "authored for this collection". The two skills already had
  neutral names (`deep-research`, `audit-codex-storage`), so no skill was renamed. The third-party notices (daymade,
  Weizhena, MIT) are unchanged apart from that one provenance sentence. Package versions were raised (deep-research
  0.2.0 → 0.2.1, audit-codex-storage 0.1.0 → 0.1.1) because package content changed and the owner's installer refuses
  a changed package at the same version. Git history was not rewritten.
- **Evidence**: `git grep -n -i -w` for the former brand returns 0 lines; both verifiers `PASS`; both receipts
  regenerated on 2026-10-11 and re-audited `PASS` (package and publication).
- **Reversal**: new entry; restoring the old name would also need the old repository name on GitHub.

## 2026-08-18 · Publish Audit Codex Storage 0.1.0 (94fe09e)
- **Context**: repeated audits of oversized Codex storage needed a safe, reusable procedure.
- **Decision**: a read-only helper that always reports zero reclaimable bytes; mutation only after explicit approval of
  exact action IDs. The verifier forbids file-removing calls in the helper (WAP-VER-006).
- **Evidence**: `skills/audit-codex-storage/evals/verify.mjs`.
- **Reversal**: new entry.

## 2026-08-12 · Verify every package in CI (6bcb776)
- **Context**: local verifiers only protect a package when someone runs them.
- **Decision**: a GitHub workflow runs every `skills/*/evals/verify.mjs` and fails when none exists (WAP-VER-005).
- **Evidence**: `.github/workflows/verify.yml`.
- **Reversal**: new entry.

## 2026-08-11 · One public collection, one boundary; packages split out only with reason (96cc5d9)
- **Context**: first public skill (Deep Research 0.1.0).
- **Decision**: one repository for skills that share one trust, licensing and release boundary; a package moves out
  only when it gains distinct maintainers, security policy, runtime, release cadence or contribution workflow. Each
  package carries a hash-bound verification receipt.
- **Evidence**: README "Publication policy".
- **Reversal**: new entry.
