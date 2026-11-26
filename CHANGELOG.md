# Changelog

Append-only, newest first. Each entry: date, what changed.

## 2026-11-26 — Clarify default-config download and single-SHA scan

- Documented how to download the official Gitleaks v8.30.0 default config with `curl -fsSL https://raw.githubusercontent.com/gitleaks/gitleaks/v8.30.0/config/gitleaks.toml -o gitleaks-default-8.30.0.toml`, and required `--config gitleaks-default-8.30.0.toml` so a fresh checkout does not load this repo's demo `.gitleaks.toml`.
- Replaced `--log-opts=--all` with a scan of a fresh checkout at `69cb260207b0a4b8a39d3d28ef563fa775285271`: `gitleaks git --config gitleaks-default-8.30.0.toml` (0 findings, exit 0, 2 commits scanned) and `gitleaks dir --config gitleaks-default-8.30.0.toml` (0 findings, exit 0). That check is still separate from `scripts/run-demo.sh`.
- LEDGER: appended an entry that supersedes the earlier "keep the repo private until a later, separate visibility change" decision. The repository went public on 2026-11-26 with Audrey Evans's yes. The earlier line was left in place.

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
