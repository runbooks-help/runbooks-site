# runbooks-site

The static marketing site at [runbooks.help](https://runbooks.help): a single
landing page in plain HTML and CSS.

## Design language

The tokens and fonts come from the shared
[design system](https://github.com/runbooks-help/design-system), fetched at a
pinned tag by `scripts/build.sh` (`DESIGN_SYSTEM_VERSION`, default `v0.2.1`);
nothing here re-declares a colour or a font.

## Build & preview

```bash
./scripts/build.sh
python3 -m http.server -d _site 8000
```

Then open <http://localhost:8000>.

## Deploy

GitHub Pages, via `.github/workflows/pages.yml`: on push to `main` it builds and
publishes `_site`. The custom domain (`CNAME` → `runbooks.help`) and TLS live in
the repository's Pages settings.

## Licence

FSL-1.1-MIT. See [LICENSE](LICENSE).
