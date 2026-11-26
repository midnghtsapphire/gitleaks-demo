# LEDGER — gitleaks-demo

Append-only. Newest first.

## 2026-11-26 — Public visibility and single-SHA default-rule scan

- **Files:** `README.md`, `CHANGELOG.md`, `LEDGER.md`
- **What was done:** Re-ran the official-default-rule check on a fresh clone checked out at `69cb260207b0a4b8a39d3d28ef563fa775285271`. Downloaded `https://raw.githubusercontent.com/gitleaks/gitleaks/v8.30.0/config/gitleaks.toml` to `gitleaks-default-8.30.0.toml` (not committed). Commands: `gitleaks git --config gitleaks-default-8.30.0.toml` (0 findings, exit 0, 2 commits scanned in this SHA's history) and `gitleaks dir --config gitleaks-default-8.30.0.toml` (0 findings, exit 0) on that checkout. Documented the `curl -fsSL ... -o gitleaks-default-8.30.0.toml` download and the required `--config` flag so a fresh checkout does not load `.gitleaks.toml`. Did not use `--log-opts=--all`.
- **Decisions:** Supersedes the 2026-11-26 decision "Keep the repo private until a later, separate visibility change." The repository went public on 2026-11-26 on Audrey Evans's yes. The earlier line is left in place and should not be used.

## 2026-11-26 — Record exact clean-check commands

- **Files:** `README.md`, `wrangler.toml`, `CHANGELOG.md`, `LEDGER.md`
- **What was done:** Re-ran Gitleaks v8.30.0 with the official default config from https://raw.githubusercontent.com/gitleaks/gitleaks/v8.30.0/config/gitleaks.toml (passed with `--config` so the repo's custom demo rules are not loaded). Commands: `gitleaks git --config gitleaks-default-8.30.0.toml --log-opts=--all` and `gitleaks dir --config gitleaks-default-8.30.0.toml`. Scanned SHA `69cb260207b0a4b8a39d3d28ef563fa775285271` (`main`, 3 commits): 0 findings (exit 0) on both commands. Recorded those commands, the SHA, and that this check is separate from `scripts/run-demo.sh` (custom `demo-gitleaks-seed` rule). Added a `wrangler.toml` comment that `workers_dev = true` is intentional for a public workers.dev hosting URL. The Worker was not deployed in this commit.
- **Decisions:** Keep `workers_dev = true`. Do not treat the `run-demo.sh` custom-rule result as the public clean check.

## 2026-11-26 — Clean-check notes and Worker static-site config

- **Files:** `README.md`, `site/index.html`, `wrangler.toml`, `CHANGELOG.md`, `LEDGER.md`
- **What was done:** After a full-history gitleaks check on 2026-11-26 (official v8.30.0 default rules, 0 findings in history and in the working tree; `scripts/run-demo.sh` passing), updated the README and the live-page footer so they describe that completed check instead of saying the repo is private until a clean check is complete. Switched `wrangler.toml` to an assets-only free Cloudflare Worker config with `[assets] directory = "./site"` and no Worker script. Ran `npx wrangler deploy --dry-run` only; nothing was deployed. Visibility was not changed.
- **Decisions:** Keep the repo private until a later, separate visibility change. Hosting, when approved, is a free Worker serving only the canned `site/` files, with no tracking.

## 2026-11-26 — Initial gitleaks-demo

- **Files:** everything in this repository's initial commit on `main`, including `LICENSE`, `README.md`, `CHANGELOG.md`, `LEDGER.md`, and the root `Library/` folder.
- **What was done:** Bootstrapped a private Gitleaks demo with canned EXAMPLE DATA only. The initial commit is on `main`. Further changes go through a pull request into a `daily/YYYY-MM-DD` branch. The repository starts private and is intended to become public after a clean check. No real credentials, private prompts, or internal configs are included. Cloudflare Pages deploy of `site/` (canned data only) is allowed while the repo is private. Stay on the free Cloudflare and CircleCI plans.
- **Decisions:** License is MIT, Copyright (c) 2026 Audrey Evans (no demo-specific license is specified in the governing standards, so MIT is used). The seeded token is named `DEMO_GITLEAKS_TOKEN` with the value `gitleaks-demo-seed-not-a-real-credential`, an obviously fake pattern that does not resemble vendor tokens. `.gitleaks.toml` uses only that custom rule and narrowly allowlists the canned copy paths by exact file path. The live page serves three canned scenarios and never runs visitor input. `scripts/run-demo.sh` fails if `site/` or the `site/scenarios/` copies are missing or differ from `example-data/scenarios/`.
