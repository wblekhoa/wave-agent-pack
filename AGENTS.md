If this checkout lives under `~/JAK` (the owner's workspace), read `~/JAK/AGENTS.md` first (map + floor rules), then `~/JAK/companies/design-system/AGENTS.md`. Standalone clones can ignore this line.

# WAVE agent pack — agent instructions

Portable, verified AI skills; the public incubator of the WAVE family. Scope, trust and release rules: `README.md`.

- One folder per skill under `skills/`; each ships its own evals.
- Verify every package you touch: `node skills/<skill>/evals/verify.mjs` (README § Verify).
- Public repo: never add owner data, secrets or former-employer content.
