#!/usr/bin/env bash
# Keep-it-working check for midnghtsapphire/gitleaks-demo.
# Installs a pinned Gitleaks CLI if needed, scans the toy codebase, verifies
# that site/ scenario copies match example-data/scenarios/, and exits 0 only
# when the seeded EXAMPLE DATA finding is detected and the copies match.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

GITLEAKS_VERSION="${GITLEAKS_VERSION:-8.30.0}"
CACHE="$ROOT/.cache"
BIN="$CACHE/gitleaks"
OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
  Linux)  os=linux ;;
  Darwin) os=darwin ;;
  *) echo "run-demo.sh: unsupported OS: $OS" >&2; exit 1 ;;
esac
case "$ARCH" in
  x86_64|amd64) arch=x64 ;;
  arm64|aarch64) arch=arm64 ;;
  *) echo "run-demo.sh: unsupported arch: $ARCH" >&2; exit 1 ;;
esac

if [[ ! -x "$BIN" ]]; then
  mkdir -p "$CACHE"
  asset="gitleaks_${GITLEAKS_VERSION}_${os}_${arch}.tar.gz"
  url="https://github.com/gitleaks/gitleaks/releases/download/v${GITLEAKS_VERSION}/${asset}"
  echo "Downloading gitleaks v${GITLEAKS_VERSION} from GitHub releases..."
  curl -fsSL "$url" -o "$CACHE/$asset"
  tar -xzf "$CACHE/$asset" -C "$CACHE" gitleaks
  chmod +x "$BIN"
fi

echo "Using $($BIN version)"

REPORT="$CACHE/gitleaks-report.json"
# Exit code 0 from gitleaks is forced so this script decides pass/fail:
# a finding is the expected demo result, not a failure.
set +e
"$BIN" detect \
  --no-git \
  --no-banner \
  --no-color \
  --source "$ROOT" \
  --config "$ROOT/.gitleaks.toml" \
  --report-format json \
  --report-path "$REPORT" \
  --exit-code 0
detect_status=$?
set -e
if [[ "$detect_status" -ne 0 ]]; then
  echo "run-demo.sh: gitleaks detect failed with status $detect_status" >&2
  exit 1
fi

if [[ ! -s "$REPORT" ]]; then
  echo "run-demo.sh: gitleaks wrote no report" >&2
  exit 1
fi

# The job passes only when the seeded EXAMPLE DATA finding is present
# and site/ scenario copies match example-data/scenarios/.
python3 - "$REPORT" "$ROOT" << 'PYCHECK'
import json, sys
from pathlib import Path

report_path = Path(sys.argv[1])
root = Path(sys.argv[2])
findings = json.loads(report_path.read_text() or "[]")
if not isinstance(findings, list):
    print("run-demo.sh: report is not a JSON list", file=sys.stderr)
    sys.exit(1)

def is_seed(item):
    secret = str(item.get("Secret") or "")
    match = str(item.get("Match") or "")
    rule = str(item.get("RuleID") or "")
    path = str(item.get("File") or "").replace("\\", "/")
    return (
        rule == "demo-gitleaks-seed"
        and "gitleaks-demo-seed-not-a-real-credential" in (secret + match)
        and path.endswith("toy/config.env.example")
    )

seeds = [f for f in findings if is_seed(f)]
if not seeds:
    print("run-demo.sh: FAIL — seeded EXAMPLE DATA finding was not detected", file=sys.stderr)
    print(json.dumps(findings, indent=2), file=sys.stderr)
    sys.exit(1)
if len(findings) != 1 or len(seeds) != 1:
    print("run-demo.sh: FAIL — expected exactly one finding (the seeded demo token)", file=sys.stderr)
    print(json.dumps(findings, indent=2), file=sys.stderr)
    sys.exit(1)

site_dir = root / "site"
if not site_dir.is_dir():
    print("run-demo.sh: FAIL — missing site/ directory", file=sys.stderr)
    sys.exit(1)
for required in ("index.html", "app.js", "styles.css"):
    path = site_dir / required
    if not path.is_file():
        print(f"run-demo.sh: FAIL — missing {path.relative_to(root)}", file=sys.stderr)
        sys.exit(1)

example_scenarios = root / "example-data" / "scenarios"
site_scenarios = site_dir / "scenarios"
if not site_scenarios.is_dir():
    print("run-demo.sh: FAIL — missing site/scenarios/ directory", file=sys.stderr)
    sys.exit(1)

for name in ("seeded-finding.json", "clean-scan.json", "allowlisted-path.json"):
    src = example_scenarios / name
    dst = site_scenarios / name
    if not src.is_file():
        print(f"run-demo.sh: FAIL — missing canned scenario {src.relative_to(root)}", file=sys.stderr)
        sys.exit(1)
    if not dst.is_file():
        print(f"run-demo.sh: FAIL — missing site copy {dst.relative_to(root)}", file=sys.stderr)
        sys.exit(1)
    try:
        json.loads(src.read_text())
    except json.JSONDecodeError as exc:
        print(f"run-demo.sh: FAIL — invalid JSON in {src.relative_to(root)}: {exc}", file=sys.stderr)
        sys.exit(1)
    try:
        json.loads(dst.read_text())
    except json.JSONDecodeError as exc:
        print(f"run-demo.sh: FAIL — invalid JSON in {dst.relative_to(root)}: {exc}", file=sys.stderr)
        sys.exit(1)
    if dst.read_bytes() != src.read_bytes():
        print(
            f"run-demo.sh: FAIL — site copy {dst.relative_to(root)} differs from {src.relative_to(root)}",
            file=sys.stderr,
        )
        sys.exit(1)

print("PASS: seeded EXAMPLE DATA finding detected in toy/config.env.example")
print("Rule: demo-gitleaks-seed")
print("Secret (fake): gitleaks-demo-seed-not-a-real-credential")
print("Canned scenarios: seeded-finding, clean-scan, allowlisted-path — valid JSON")
print("site/scenarios/ copies match example-data/scenarios/")
print()
print(json.dumps(findings, indent=2))
PYCHECK
