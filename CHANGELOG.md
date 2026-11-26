# Changelog

Append-only, newest first. Each entry: date, what changed.

## 2026-11-26 — Clean-check notes and Worker static-site config

- Recorded that this repository passed a full-history gitleaks check (official v8.30.0 default rules, 0 findings) on 2026-11-26. Updated the README visibility section and the `site/index.html` footer so they no longer say the repo is private until a clean check is complete.
- Replaced the Pages-only Wrangler config with an assets-only Cloudflare Worker config pointing at `site/` (no Worker script, no tracking). The Worker is prepared but not deployed.
- Visibility was not changed in this commit.

## 2026-11-26 — Initial gitleaks-demo

- Added an always-working Gitleaks demo: toy codebase with one seeded EXAMPLE DATA token, `scripts/run-demo.sh` (fails if `site/` or the `site/scenarios/` copies are missing or differ from `example-data/scenarios/`), canned `example-data/` output and three scenarios, static `site/` demo page, root `Library/`, MIT LICENSE (Copyright 2026 Audrey Evans), CircleCI config that passes when the seeded finding is detected, and Wrangler notes for Cloudflare Pages (free).
- This repository starts private and is intended to become public after a clean check. It contains only canned example data. No real credentials.
