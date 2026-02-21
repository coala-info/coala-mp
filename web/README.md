# CLI Skills & CWL Web

Static site to host skills (SKILL.md) and CWL definitions for CLI tools. Structure and UI are inspired by [SkillsMP](https://skillsmp.com/).

## Features

- **Browse & search** tools (client-side Fuse.js over a pre-built index).
- **Tool pages** show metadata and validation status from `report.md`, plus download links for SKILL.md and all CWL files.
- **Efficient for thousands of tools**: build-time index and static export; no runtime DB or server required.

## Data layout (keep both repos small)

- **Data repo** (10k+ tools): holds `data/<tool_id>/` (report.md, skills/, *.cwl). **Build index there** (no zips): run the index script with `DATA_REPO_URL` and `COALA_MP_OUT_DIR` so it writes only `tools-index.json` and `tools/*.json` (e.g. into a `metadata/` folder). Download links on the site become **GitHub repo links** (Skills → tree for `data/<id>/skills`, CWLs → tree for `data/<id>`), so the data repo stays small (no zip artifacts).
- **Website repo**: no Python in CI. Set **Settings → Variables → DATA_REPO** (e.g. `org/coala-mp-data`) and optionally **METADATA_PATH** (default `metadata`). The workflow clones the data repo, copies metadata into `web/public/`, and runs **next build** only (fast).

**Index script (run in data repo):**

| Env | Description |
|-----|-------------|
| `COALA_MP_DATA_DIR` | Data root (default: repo `data/`). |
| `COALA_MP_OUT_DIR` | Where to write JSON (default: website `web/public`; in data repo use e.g. `./metadata`). |
| `DATA_REPO_URL` | GitHub repo URL (e.g. `https://github.com/org/coala-mp-data`). When set, tool JSON gets `skills_repo_link` and `cwls_repo_link` (GitHub tree links). |
| `DATA_REPO_BRANCH` | Branch for tree links (default `main`). |
| `DATA_REPO_DATA_PATH` | Path to tool data inside repo (default `data`). |

## Commands

- **Index data** (in data repo or locally): `python3 scripts/build_index.py` (set `DATA_REPO_URL` and `COALA_MP_OUT_DIR` in data repo). From website: `cd web && npm run index`.
- **Build site**: `cd web && npm run build` (Next.js only; metadata must exist in `web/public/`). For local dev with data in repo: `npm run build:local` (runs index then build).
- **Dev**: `cd web && npm run dev`.

## Manual testing (data repo + repo links)

**Option A – Build from local `data/` with a fake repo URL (for link behaviour):**

```bash
cd web
DATA_REPO_URL=https://github.com/your-org/your-data-repo npm run index
npm run dev
```

Uses repo root `data/` (e.g. `data/curl`, `data/bedtools`), writes `web/public/tools-index.json` and `web/public/tools/*.json` with `skills_repo_link` / `cwls_repo_link` pointing at `DATA_REPO_URL`. Open http://localhost:3000 and check tool pages.

**Option B – Use metadata from a real data repo:**

```bash
git clone --depth 1 https://github.com/ORG/DATA_REPO.git data-repo
cp data-repo/metadata/tools-index.json web/public/
mkdir -p web/public/tools && cp data-repo/metadata/tools/*.json web/public/tools/
cd web && npm run dev
```

Replace `ORG/DATA_REPO` and `metadata` if your repo uses another path (set `METADATA_PATH` accordingly).

## Deploy

### GitHub Pages

1. **Enable GitHub Pages** in the repo: **Settings → Pages → Build and deployment → Source**: choose **GitHub Actions**.
2. **Two-repo setup (recommended):** In the **data repo**, run the index script with `DATA_REPO_URL=https://github.com/org/coala-mp-data` and `COALA_MP_OUT_DIR=./metadata`; commit `metadata/tools-index.json` and `metadata/tools/*.json`. In the **website repo** set **Settings → Variables → DATA_REPO** = `org/coala-mp-data` (and optionally **METADATA_PATH** = `metadata`). The website workflow will clone the data repo, copy metadata, and run only Next.js build (no Python, fast). Download links on the site point to the data repo (GitHub tree); no zips.
3. Push to `main` (or trigger the workflow manually). The workflow fetches metadata (if DATA_REPO is set) or runs the index from local `data/`, then builds and deploys `web/out/`.
4. The site will be at **https://\<username>.github.io/\<repo>/** (project site) or **https://\<username>.github.io/** (user/org site).

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
