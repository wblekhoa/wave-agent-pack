---
id: wave-agent-pack-goal
type: goal
product: wave-agent-pack
title: "WAVE agent pack — Product goal"
status: active
updated: 2026-10-11
---
# WAVE agent pack — Product goal

## Problem
- Useful AI-agent skills tend to live inside one private workspace, tangled with its paths, policies and adapters.
  Anyone else (or another of the owner's projects) cannot reuse them without inheriting that whole control plane, and
  cannot tell whether a copied skill still behaves as its author verified.

## Audience
- Primary: a developer or designer running Claude Code, Codex, Gemini CLI/Antigravity, OpenClaw or Hermes who wants a
  ready, verified skill copied into their own project.
- Secondary: the maintainer, who needs one public place with a single trust, licensing and release boundary.
- Who pays: nobody - the content is MIT licensed.

## Promise
- Copy one folder and you get a skill that declares its owner, provenance, licence and runtime adapters, and that
  proves itself with one `node` command.

## Success measures
| Measure | Today (observed 2026-10-11) | Target | How it is measured (command, dashboard, store data) |
|---|---|---|---|
| Package verifiers pass | 2 of 2 (`deep-research`, `audit-codex-storage`) | every package, every push to `main` | `for v in skills/*/evals/verify.mjs; do node "$v"; done` (also the `Verify skills` workflow) |
| Trigger balance per package | 20 cases, 10 USE / 10 DO_NOT_USE, both packages | unchanged for every new package | `evals/verify.mjs` (WAP-VER-002) |
| Former-employer references in the working tree | 0 | 0 | the word-match grep recorded in `decisions.md` (2026-10-11 entry) |
| Published packages | 2 | not set | `ls skills/` |
| Installs / users | not measured | a number | to add: GitHub traffic (`gh api repos/wblekhoa/wave-agent-pack/traffic/clones`) |

## Non-goals
- No installer, package manager or registry: installation is a documented folder copy.
- No claim that every runtime auto-discovers a copied skill; discovery is verified per runtime by the user.
- No private adapters, host-specific policy, private paths or secrets in this repository.
- A package moves to its own repository only when it gains its own maintainers, security policy, runtime, release
  cadence or contribution workflow.

## Links
- UX: `ux/install-verify.md` · Logic: `logic/install-verify.md` (WAP-INST, WAP-VER) · Decisions: `decisions.md` ·
  Releases: `releases.md`

## Change log
- 2026-10-11: created.
