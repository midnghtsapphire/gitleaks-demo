# Changelog

Append-only, newest first. Each entry: date, what changed.

## 2026-11-26 — Initial gitleaks-demo

- Added an always-working Gitleaks demo: toy codebase with one seeded EXAMPLE DATA token, `scripts/run-demo.sh` (fails if `site/` or the `site/scenarios/` copies are missing or differ from `example-data/scenarios/`), canned `example-data/` output and three scenarios, static `site/` demo page, root `Library/`, MIT LICENSE (Copyright 2026 Audrey Evans), CircleCI config that passes when the seeded finding is detected, and Wrangler notes for Cloudflare Pages (free).
- This repository starts private and is intended to become public after a clean check. It contains only canned example data. No real credentials.
