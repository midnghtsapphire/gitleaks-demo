# LEDGER — gitleaks-demo

Append-only. Newest first.

## 2026-11-26 — Initial gitleaks-demo

- **Files:** everything in this repository's initial commit on `main`, including `LICENSE`, `README.md`, `CHANGELOG.md`, `LEDGER.md`, and the root `Library/` folder.
- **What was done:** Bootstrapped a private Gitleaks demo with canned EXAMPLE DATA only. The initial commit is on `main`. Further changes go through a pull request into a `daily/YYYY-MM-DD` branch. The repository starts private and is intended to become public after a clean check. No real credentials, private prompts, or internal configs are included. Cloudflare Pages deploy of `site/` (canned data only) is allowed while the repo is private. Stay on the free Cloudflare and CircleCI plans.
- **Decisions:** License is MIT, Copyright (c) 2026 Audrey Evans (no demo-specific license is specified in the governing standards, so MIT is used). The seeded token is named `DEMO_GITLEAKS_TOKEN` with the value `gitleaks-demo-seed-not-a-real-credential`, an obviously fake pattern that does not resemble vendor tokens. `.gitleaks.toml` uses only that custom rule and narrowly allowlists the canned copy paths by exact file path. The live page serves three canned scenarios and never runs visitor input. `scripts/run-demo.sh` fails if `site/` or the `site/scenarios/` copies are missing or differ from `example-data/scenarios/`.
