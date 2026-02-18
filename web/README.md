# CLI Skills & CWL Web

Static site to host skills (SKILL.md) and CWL definitions for CLI tools. Structure and UI are inspired by [SkillsMP](https://skillsmp.com/).

## Features

- **Browse & search** tools (client-side Fuse.js over a pre-built index).
- **Tool pages** show metadata and validation status from `report.md`, plus download links for SKILL.md and all CWL files.
- **Efficient for thousands of tools**: build-time index and static export; no runtime DB or server required.

## Data layout

- `data/<tool_id>/` — one directory per tool.
- Each tool directory must have `report.md`; may have `skills/SKILL.md` and `*.cwl` files.
- Run the index script to regenerate `public/tools-index.json`, `public/tools/<id>.json`, and `public/files/<id>/*` (copied skills and CWLs).

## Commands

- **Index data** (from repo root): `python3 scripts/build_index.py`. Or from `web/`: `npm run index`.
- **Build site**: `cd web && npm run build` (runs index then Next.js static export). Output is in `web/out/`.
- **Dev**: `cd web && npm run dev`.

## Deploy

### GitHub Pages

1. **Enable GitHub Pages** in the repo: **Settings → Pages → Build and deployment → Source**: choose **GitHub Actions**.
2. Push to `main` (or trigger the workflow manually). The workflow `.github/workflows/deploy-gh-pages.yml` will:
   - Run the index script and Next.js static export
   - Deploy the contents of `web/out/` to GitHub Pages
3. The site will be at **https://\<username>.github.io/\<repo>/** (project site) or **https://\<username>.github.io/** (user/org site).

If the site is a **project site** (e.g. `https://username.github.io/coala-mp/`), add to `web/next.config.js`:

```js
const nextConfig = {
  output: 'export',
  trailingSlash: true,
  basePath: '/coala-mp',   // use your repo name
  assetPrefix: '/coala-mp/',
};
```

Then rebuild and redeploy.

### Other hosts

Serve the `web/out/` directory with any static host (e.g. nginx, S3 + CloudFront, Vercel static). No Node server needed.
