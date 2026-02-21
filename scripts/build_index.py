#!/usr/bin/env python3
"""
Build index and per-tool JSON from data/ for the skills/CWL hosting site.
Only generates JSON (tools-index.json and tools/*.json). No zip files or files/ directory.
Run in the data repo with DATA_REPO_URL set to get skills_repo_link and cwls_repo_link in tool JSON.
"""
from __future__ import annotations

import json
import os
import re
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parents[1]
DATA_DIR = Path(os.environ.get("COALA_MP_DATA_DIR", str(SCRIPT_DIR / "data")))
OUT_DIR = Path(os.environ.get("COALA_MP_OUT_DIR", str(SCRIPT_DIR / "web" / "public")))
TOOLS_INDEX_PATH = OUT_DIR / "tools-index.json"
TOOLS_JSON_DIR = OUT_DIR / "tools"
# When set, tool JSON gets skills_repo_link and cwls_repo_link (GitHub tree links).
DATA_REPO_URL = (os.environ.get("DATA_REPO_URL") or "").strip()
DATA_REPO_BRANCH = (os.environ.get("DATA_REPO_BRANCH") or "main").strip()
DATA_REPO_DATA_PATH = (os.environ.get("DATA_REPO_DATA_PATH") or "data").strip().rstrip("/")


def _parse_conda_downloads_num(s: str) -> int:
    """Parse conda download string to number, e.g. '6.3K' -> 6300, '1.2M' -> 1200000."""
    s = (s or "").strip().upper().replace(",", "")
    if not s or s == "N/A":
        return 0
    mult = 1
    if s.endswith("K"):
        mult = 1000
        s = s[:-1]
    elif s.endswith("M"):
        mult = 1_000_000
        s = s[:-1]
    try:
        return int(float(s) * mult)
    except ValueError:
        return 0


def parse_report(report_path: Path) -> dict:
    """Parse report.md into structured data: summary table, tools list, first tool metadata."""
    text = report_path.read_text(encoding="utf-8", errors="replace")

    # Runtime validation summary table (first table after ## Runtime validation summary)
    summary_table: list[dict] = []
    summary_match = re.search(
        r"## Runtime validation summary\s*\n\s*\|([^\n]+)\|\s*\n\s*\|[-:\s|]+\|\s*\n((?:\s*\|[^\n]+\|\s*\n)+)",
        text,
        re.MULTILINE,
    )
    if summary_match:
        header_line = summary_match.group(1).strip()
        headers = [h.strip() for h in header_line.split("|") if h.strip()]
        body = summary_match.group(2)
        for line in body.strip().split("\n"):
            cells = [c.strip() for c in line.split("|") if c.strip()]
            if len(cells) >= len(headers):
                summary_table.append(dict(zip(headers, cells[: len(headers)])))

    # Tool sections: ## tool_name (not ## Runtime... or ## Metadata)
    tool_section_pattern = re.compile(
        r"^## ([^\n#]+)$",
        re.MULTILINE,
    )
    sections = list(tool_section_pattern.finditer(text))
    skip_titles = {"Runtime validation summary", "Metadata"}
    tool_names = [
        m.group(1).strip()
        for m in sections
        if m.group(1).strip() not in skip_titles
    ]

    # First tool block: description and metadata (Docker, Homepage, Validation, Conda, GitHub, Total Downloads)
    description = ""
    docker_image = ""
    homepage = ""
    validation = ""
    conda_home = ""
    github = ""
    conda_downloads = ""
    last_updated = ""

    first_tool = tool_names[0] if tool_names else None
    if first_tool:
        # Extract ### Tool Description block
        desc_pattern = re.compile(
            rf"## {re.escape(first_tool)}\s*\n\s*### Tool Description\s*\n(.+?)(?=\n###|\n## |\Z)",
            re.DOTALL,
        )
        desc_m = desc_pattern.search(text)
        if desc_m:
            description = desc_m.group(1).strip()

        # Metadata block (### Metadata)
        meta_pattern = re.compile(
            rf"## {re.escape(first_tool)}.*?### Metadata\s*\n(.*?)(?=\n###|\n## |\Z)",
            re.DOTALL,
        )
        meta_m = meta_pattern.search(text)
        if not meta_m and "### Metadata" in text:
            meta_pattern_any = re.compile(
                r"### Metadata\s*\n(.*?)(?=\n###|\n## |\Z)",
                re.DOTALL,
            )
            meta_m = meta_pattern_any.search(text)
        if meta_m:
            meta_block = meta_m.group(1)
            for line in meta_block.split("\n"):
                if "**Docker Image**:" in line or "**Docker**:" in line:
                    docker_image = line.split(":", 1)[-1].strip()
                elif "**Homepage**:" in line:
                    homepage = line.split(":", 1)[-1].strip()
                elif "**Validation**:" in line:
                    validation = line.split(":", 1)[-1].strip()
                elif "**Conda**:" in line:
                    conda_home = line.split(":", 1)[-1].strip()
                elif "**GitHub**:" in line:
                    github = line.split(":", 1)[-1].strip()
                elif "**Total Downloads**:" in line:
                    conda_downloads = line.split(":", 1)[-1].strip()
                elif "**Last updated**:" in line:
                    last_updated = line.split(":", 1)[-1].strip()

    # Final ## Metadata section (Skill: generated, Validation-run)
    last_metadata = text.split("## Metadata")[-1] if "## Metadata" in text else ""
    skill_generated = "Skill" in last_metadata and "generated" in last_metadata
    validation_run_raw = ""
    if "**Validation-run**:" in last_metadata or "**Validation-run**: " in last_metadata:
        for line in last_metadata.split("\n"):
            if "**Validation-run**:" in line or "**Validation-run**: " in line:
                validation_run_raw = line.split(":", 1)[-1].strip()
                break

    # Derive validation_run status: pass | ongoing | not_done
    validation_run = "not_done"
    if validation_run_raw.upper() == "PASS":
        validation_run = "pass"
    elif validation_run_raw.upper() == "FAIL" or (validation_run_raw and validation_run_raw.upper() != "PASS"):
        validation_run = "ongoing"
    elif summary_table:
        # Use runtime summary table: Runtime column (usually 2nd col)
        runtime_col = None
        for h in summary_table[0].keys():
            if "runtime" in h.lower():
                runtime_col = h
                break
        if not runtime_col and summary_table[0]:
            runtime_col = list(summary_table[0].keys())[1] if len(summary_table[0]) > 1 else None
        if runtime_col:
            values = [row.get(runtime_col, "").strip().upper() for row in summary_table]
            if all(v == "PASS" for v in values):
                validation_run = "pass"
            elif any(v == "FAIL" for v in values):
                validation_run = "ongoing"

    return {
        "runtime_summary_table": summary_table,
        "tool_names": tool_names,
        "description": description,
        "docker_image": docker_image,
        "homepage": homepage,
        "validation": validation,
        "conda_home": conda_home,
        "github": github,
        "conda_downloads": conda_downloads,
        "last_updated": last_updated,
        "skill_generated": skill_generated,
        "validation_run": validation_run,
        "report_raw": text,
    }


def strip_front_matter(text: str) -> str:
    """Remove YAML front matter (--- ... ---) so only the skill body is shown."""
    if text.startswith("---"):
        end = text.find("---", 3)
        if end != -1:
            return text[end + 3 :].lstrip("\n")
    return text


def skill_metadata(skill_path: Path) -> dict:
    """Read name and description from SKILL.md front matter or first lines."""
    text = skill_path.read_text(encoding="utf-8", errors="replace")
    name = ""
    description = ""
    if text.startswith("---"):
        end = text.find("---", 3)
        if end != -1:
            fm = text[3:end]
            for line in fm.split("\n"):
                if line.startswith("name:"):
                    name = line.split(":", 1)[-1].strip()
                elif line.startswith("description:"):
                    description = line.split(":", 1)[-1].strip()
    return {"name": name, "description": description}


def skill_overview(skill_path: Path) -> str:
    """Extract overview from SKILL.md: content under ## Overview only (first paragraph)."""
    text = skill_path.read_text(encoding="utf-8", errors="replace")
    body = strip_front_matter(text)
    overview_match = re.search(
        r"## Overview\s*\n+(.+?)(?=\n## |\n# |\Z)",
        body,
        re.DOTALL,
    )
    if not overview_match:
        return ""
    block = overview_match.group(1).strip()
    first_para = re.split(r"\n\s*\n", block)[0].strip()
    return first_para[:500] if first_para else ""


def build_tool(tool_id: str, tool_path: Path) -> dict | None:
    """Build per-tool data and copy static files. Returns tool record for index and full data for tools/{id}.json."""
    report_path = tool_path / "report.md"
    skill_path = tool_path / "skills" / "SKILL.md"

    if not report_path.exists():
        return None

    parsed = parse_report(report_path)
    cwl_files = sorted(f.name for f in tool_path.glob("*.cwl"))
    has_skill = skill_path.exists()

    skill_meta = skill_metadata(skill_path) if has_skill else {}
    # Prefer skill name/description for card; fallback to report
    name = skill_meta.get("name") or tool_id
    description = skill_meta.get("description") or parsed["description"] or f"CLI tool: {tool_id}"
    overview = skill_overview(skill_path) if has_skill else ""

    conda_downloads_raw = parsed.get("conda_downloads") or ""
    conda_downloads_num = _parse_conda_downloads_num(conda_downloads_raw)

    index_entry = {
        "id": tool_id,
        "name": name,
        "description": description[:500] if description else "",
        "overview": overview[:500] if overview else "",
        "homepage": parsed.get("homepage") or "",
        "validation": parsed.get("validation") or "",
        "conda_home": parsed.get("conda_home") or "",
        "github": parsed.get("github") or "",
        "conda_downloads": conda_downloads_raw,
        "conda_downloads_num": conda_downloads_num,
        "last_updated": parsed.get("last_updated") or "",
        "cwl_count": len(cwl_files),
        "has_skill": has_skill,
        "runtime_summary": parsed.get("runtime_summary_table", []),
    }

    # Repo links (GitHub tree) when DATA_REPO_URL is set
    skills_repo_link = None
    cwls_repo_link = None
    if DATA_REPO_URL:
        base = DATA_REPO_URL.rstrip("/")
        tree = f"{base}/tree/{DATA_REPO_BRANCH}/{DATA_REPO_DATA_PATH}/{tool_id}"
        if has_skill:
            skills_repo_link = f"{tree}/skills"
        if cwl_files:
            cwls_repo_link = tree

    skill_markdown = (
        strip_front_matter(skill_path.read_text(encoding="utf-8", errors="replace"))
        if has_skill
        else None
    )

    full_data = {
        **index_entry,
        "report": {
            "runtime_summary_table": parsed["runtime_summary_table"],
            "tool_names": parsed["tool_names"],
            "description": parsed["description"],
            "docker_image": parsed["docker_image"],
            "homepage": parsed["homepage"],
            "validation": parsed["validation"],
            "conda_home": parsed.get("conda_home") or "",
            "github": parsed.get("github") or "",
            "conda_downloads": parsed.get("conda_downloads") or "",
            "last_updated": parsed.get("last_updated") or "",
            "skill_generated": parsed["skill_generated"],
            "validation_run": parsed["validation_run"],
        },
        "cwl_files": cwl_files,
        "skill_file": "SKILL.md" if has_skill else None,
        "skills_repo_link": skills_repo_link,
        "cwls_repo_link": cwls_repo_link,
        "skill_markdown": skill_markdown,
    }

    return {"index_entry": index_entry, "full_data": full_data}


def main() -> None:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    TOOLS_JSON_DIR.mkdir(parents=True, exist_ok=True)

    index_list: list[dict] = []
    tool_ids = sorted(
        d.name for d in DATA_DIR.iterdir() if d.is_dir() and (d / "report.md").exists()
    )

    for tool_id in tool_ids:
        tool_path = DATA_DIR / tool_id
        result = build_tool(tool_id, tool_path)
        if result:
            index_list.append(result["index_entry"])
            (TOOLS_JSON_DIR / f"{tool_id}.json").write_text(
                json.dumps(result["full_data"], indent=2, ensure_ascii=False),
                encoding="utf-8",
            )

    TOOLS_INDEX_PATH.write_text(
        json.dumps({"tools": index_list, "total": len(index_list)}, indent=2, ensure_ascii=False),
        encoding="utf-8",
    )
    print(f"Indexed {len(index_list)} tools -> {TOOLS_INDEX_PATH}")


if __name__ == "__main__":
    main()
