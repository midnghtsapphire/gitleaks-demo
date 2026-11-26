# LEDGER — gitleaks-demo

Append-only. Newest first.

## 2026-11-26 — Clean-check notes and Worker static-site config

- **Files:** `README.md`, `site/index.html`, `wrangler.toml`, `CHANGELOG.md`, `LEDGER.md`
- **What was done:** After a full-history gitleaks check on 2026-11-26 (official v8.30.0 default rules, 0 findings in history and in the working tree; `scripts/run-demo.sh` passing), updated the README and the live-page footer so they describe that completed check instead of saying the repo is private until a clean check is complete. Switched `wrangler.toml` to an assets-only free Cloudflare Worker config with `[assets] directory = "./site"` and no Worker script. Ran `npx wrangler deploy --dry-run` only; nothing was deployed. Visibility was not changed.
- **Decisions:** Keep the repo private until a later, separate visibility change. Hosting, when approved, is a free Worker serving only the canned `site/` files, with no tracking.

## 2026-11-26 — Initial gitleaks-demo

- **Files:** everything in this repository's initial commit on `main`, including `LICENSE`, `README.md`, `CHANGELOG.md`, `LEDGER.md`, and the root `Library/` folder.
- **What was done:** Bootstrapped a private Gitleaks demo with canned EXAMPLE DATA only. The initial commit is on `main`. Further changes go through a pull request into a `daily/YYYY-MM-DD` branch. The repository starts private and is intended to become public after a clean check. No real credentials, private prompts, or internal configs are included. Cloudflare Pages deploy of `site/` (canned data only) is allowed while the repo is private. Stay on the free Cloudflare and CircleCI plans.
- **Decisions:** License is MIT, Copyright (c) 2026 Audrey Evans (no demo-specific license is specified in the governing standards, so MIT is used). The seeded token is named `DEMO_GITLEAKS_TOKEN` with the value `gitleaks-demo-seed-not-a-real-credential`, an obviously fake pattern that does not resemble vendor tokens. `.gitleaks.toml` uses only that custom rule and narrowly allowlists the canned copy paths by exact file path. The live page serves three canned scenarios and never runs visitor input. `scripts/run-demo.sh` fails if `site/` or the `site/scenarios/` copies are missing or differ from `example-data/scenarios/`.
