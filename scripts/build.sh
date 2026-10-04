#!/usr/bin/env bash
# Assemble _site/ from the static sources plus the pinned design-system release.
# The design language is not copied by hand: it is fetched at a pinned tag, so
# tokens and fonts cannot drift from the app.
set -euo pipefail

VERSION="${DESIGN_SYSTEM_VERSION:-v0.2.1}"
BASE="https://github.com/runbooks-help/design-system/releases/download/${VERSION}"
OUT="${1:-_site}"

rm -rf "$OUT"
mkdir -p "$OUT/design-system"

cp index.html styles.css CNAME .nojekyll "$OUT/"

curl -fsSL "$BASE/tokens.css" -o "$OUT/design-system/tokens.css"
curl -fsSL "$BASE/fonts.css" -o "$OUT/design-system/fonts.css"
curl -fsSL "$BASE/fonts.tar.gz" | tar xz -C "$OUT/design-system"
curl -fsSL "$BASE/brand.tar.gz" | tar xz -C "$OUT/design-system"
cp "$OUT/design-system/favicon.svg" "$OUT/favicon.svg"

echo "built $OUT from design-system $VERSION"
