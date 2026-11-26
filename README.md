# gitleaks-demo

**This is a demo that uses sample data only.** It shows how [Gitleaks](https://github.com/gitleaks/gitleaks) finds a secret in a toy codebase, using one seeded **EXAMPLE DATA** token. Nothing in this repository is a real credential, private prompt, or internal config.

## Visibility

This repository passed a full-history gitleaks check (official v8.30.0 default rules; 0 findings in history and in the working tree) on 2026-11-26. It contains canned example data only — no real keys, prompts, or tracking. It is intended as a public demo with a live working link on a free Cloudflare Worker.

Live demo URL: not deployed yet. The static page lives in `site/` and is ready for a free Cloudflare Worker deploy (see below).

## The flow

1. A tiny toy app lives in `toy/`. One file, `toy/config.env.example`, contains the seeded fake token named `DEMO_GITLEAKS_TOKEN` with the value `gitleaks-demo-seed-not-a-real-credential`.
2. `scripts/run-demo.sh` installs a pinned Gitleaks CLI (v8.30.0) if needed and scans the repo with the demo rule in `.gitleaks.toml`.
3. The script **passes** only when that seeded finding is detected (exactly once, in the toy file) and when every `site/scenarios/` copy matches `example-data/scenarios/`. That pass condition is the opposite of a normal CI secret gate, and it is intentional: the demo must keep showing the finding, and the live page must stay in sync with the canned source files.
4. Canned answers live in `example-data/` (labelled EXAMPLE DATA). The live page in `site/` offers three fixed choices and always shows a clean canned run, never a raw error, and never runs visitor-uploaded code.

### The three fixed choices

| Choice | What you see |
| --- | --- |
| Seeded finding | Gitleaks reports the one fake token in `toy/config.env.example`. |
| Clean scan | A scan of `toy/clean/` reports no findings. |
| Allowlisted path | The same token is present, but a narrow path allowlist suppresses it, so the result is clean. |

## Run it locally

```bash
bash scripts/run-demo.sh
```

A passing run prints `PASS: seeded EXAMPLE DATA finding detected in toy/config.env.example` and the JSON finding, then exits 0. If the seed is missing, or if the `site/` scenario copies are missing or differ from `example-data/scenarios/`, the script exits non-zero.

You need `bash`, `curl`, `python3`, and a network path to GitHub Releases the first time (the binary is cached under `.cache/`, which is gitignored).

## Why this token will not look real to GitGuardian

The seeded value is `gitleaks-demo-seed-not-a-real-credential`. It does not match GitHub, AWS, Slack, Stripe, or other vendor token formats. Gitleaks finds it only because this repo's `.gitleaks.toml` defines a demo-specific rule. Copies of the finding in `example-data/` and `site/` are allowlisted narrowly by exact file path.

## CircleCI

`.circleci/config.yml` runs the same script. The job passes when the seeded finding is detected and the site copies match. This uses CircleCI only (no GitHub-hosted Actions, no billed Actions minutes). Follow the project only if it costs nothing extra; do not buy credits or a plan for this demo.

## Deploy the static demo page (Cloudflare Worker, free)

The page is plain HTML, CSS, and JS in `site/`. No tracking, analytics, affiliate code, or third-party scripts. `wrangler.toml` is an assets-only Worker config pointing at `site/` (no Worker script). It is prepared but not deployed yet.

```bash
# Dry-run only until a deploy is approved:
npx wrangler deploy --dry-run

# When a deploy is approved, stay on the Workers Free plan:
npx wrangler deploy
```

Stay on the Cloudflare Free plan. Do not attach a custom domain without a separate yes. The Worker serves only the canned files in `site/`.

## License

MIT License, Copyright (c) 2026 Audrey Evans. See `LICENSE`.

After the initial `main` bootstrap, further changes go through a pull request into a `daily/YYYY-MM-DD` branch.
