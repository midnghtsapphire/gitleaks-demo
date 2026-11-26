# Changelog

Append-only, newest first. Each entry: date, what changed.

## 2026-11-26 — Record exact clean-check commands

- Documented the clean check in the README, CHANGELOG, and LEDGER with the exact commands: Gitleaks v8.30.0, official default config (not this repo's `.gitleaks.toml`), `gitleaks git --log-opts=--all` and `gitleaks dir`. Scanned SHA `69cb260207b0a4b8a39d3d28ef563fa775285271` (`main`): 0 findings in history and in the working tree. This scan is separate from `scripts/run-demo.sh`, which uses the custom demo rule.
- Noted in `wrangler.toml` that `workers_dev = true` is intentional so the demo can be hosted on a public workers.dev URL. The Worker is not deployed in this commit.

## 2026-11-26 — Clean-check notes and Worker static-site config

- Recorded that this repository passed a full-history gitleaks check (official v8.30.0 default rules, 0 findings) on 2026-11-26. Updated the README visibility section and the `site/index.html` footer so they no longer say the repo is private until a clean check is complete.
- Replaced the Pages-only Wrangler config with an assets-only Cloudflare Worker config pointing at `site/` (no Worker script, no tracking). The Worker is prepared but not deployed.
- Visibility was not changed in this commit.

## 2026-11-26 — Initial gitleaks-demo

- Added an always-working Gitleaks demo: toy codebase with one seeded EXAMPLE DATA token, `scripts/run-demo.sh` (fails if `site/` or the `site/scenarios/` copies are missing or differ from `example-data/scenarios/`), canned `example-data/` output and three scenarios, static `site/` demo page, root `Library/`, MIT LICENSE (Copyright 2026 Audrey Evans), CircleCI config that passes when the seeded finding is detected, and Wrangler notes for Cloudflare Pages (free).
- This repository starts private and is intended to become public after a clean check. It contains only canned example data. No real credentials.
