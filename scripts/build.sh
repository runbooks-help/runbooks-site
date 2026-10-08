#!/usr/bin/env bash
# Assemble _site/ from the static sources plus the pinned design-system release.
# The design language is not copied by hand: it is fetched at a pinned tag, so
# tokens and fonts cannot drift from the app.
set -euo pipefail

VERSION="${DESIGN_SYSTEM_VERSION:-v0.3.0}"
BASE="https://github.com/runbooks-help/design-system/releases/download/${VERSION}"
OUT="${1:-_site}"

rm -rf "$OUT"
mkdir -p "$OUT/design-system"

cp index.html supporters.html changelog.html styles.css CNAME .nojekyll "$OUT/"
mkdir -p "$OUT/brand"
cp brand/*.svg "$OUT/brand/"

# The demo clips are rendered artefacts (see the marketing-demos spec); they are
# committed here under media/ and copied as-is.
mkdir -p "$OUT/media"
cp media/* "$OUT/media/"

curl -fsSL "$BASE/tokens.css" -o "$OUT/design-system/tokens.css"
curl -fsSL "$BASE/fonts.css" -o "$OUT/design-system/fonts.css"
curl -fsSL "$BASE/fonts.tar.gz" | tar xz -C "$OUT/design-system"
curl -fsSL "$BASE/brand.tar.gz" | tar xz -C "$OUT/design-system"
cp "$OUT/design-system/favicon.svg" "$OUT/favicon.svg"

# The link preview is served from the site root, so og:image points at a short
# URL that survives a design-system version bump.
cp "$OUT/design-system/brand/social-card-on-dark-1200.png" "$OUT/social-card.png"

echo "built $OUT from design-system $VERSION"
