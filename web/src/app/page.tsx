'use client';

import { useEffect, useState, useMemo } from 'react';
import Link from 'next/link';
import Fuse from 'fuse.js';

const PAGE_SIZE = 9;
const DATA_REPO = process.env.NEXT_PUBLIC_DATA_REPO || 'coala-info/coala-repo';
const REQUEST_ISSUE_URL = `https://github.com/${DATA_REPO}/issues/new?${new URLSearchParams({
  title: 'Request: new tool or skill',
  labels: 'enhancement',
}).toString()}`;

type ToolEntry = {
  id: string;
  name: string;
  description: string;
  overview?: string;
  homepage: string;
  validation: string;
  cwl_count: number;
  has_skill: boolean;
  runtime_summary: Array<Record<string, string>>;
  conda_downloads_num?: number;
  conda_downloads?: string;
  category?: string;
  category_group?: string;
};

const DEFAULT_CATEGORY = 'Command-line tool';
const DEFAULT_GROUP = 'Command-line tools';
const GROUP_ORDER = ['Command-line tools', 'Libraries', 'Workflows', 'Other'];
// Filter values for a whole group are prefixed so they never clash with a category name.
const GROUP_PREFIX = 'group:';

type CategoryGroup = {
  name: string;
  count: number;
  categories: { name: string; count: number }[];
};

const categoryOf = (t: ToolEntry) => t.category ?? DEFAULT_CATEGORY;
const groupOf = (t: ToolEntry) => t.category_group ?? (t.category ? 'Other' : DEFAULT_GROUP);

type IndexData = {
  tools: ToolEntry[];
  total: number;
};

export default function HomePage() {
  const [index, setIndex] = useState<IndexData | null>(null);
  const [query, setQuery] = useState('');
  const [categoryFilter, setCategoryFilter] = useState('');
  const [loading, setLoading] = useState(true);
  const [currentPage, setCurrentPage] = useState(1);

  useEffect(() => {
    fetch(`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/tools-index.json`)
      .then((r) => r.json())
      .then(setIndex)
      .finally(() => setLoading(false));
  }, []);

  const fuse = useMemo(
    () =>
      index
        ? new Fuse(index.tools, {
            keys: ['name', 'id', 'description', 'overview', 'category'],
            threshold: 0.35,
          })
        : null,
    [index]
  );

  const categoryGroups = useMemo(() => {
    if (!index) return [];
    const groups = new Map<string, Map<string, number>>();
    for (const t of index.tools) {
      const cats = groups.get(groupOf(t)) ?? new Map<string, number>();
      cats.set(categoryOf(t), (cats.get(categoryOf(t)) ?? 0) + 1);
      groups.set(groupOf(t), cats);
    }
    const rank = (g: string) => (GROUP_ORDER.includes(g) ? GROUP_ORDER.indexOf(g) : GROUP_ORDER.length);
    return Array.from(groups.entries())
      .sort(([a], [b]) => rank(a) - rank(b) || a.localeCompare(b))
      .map(([name, cats]): CategoryGroup => ({
        name,
        count: Array.from(cats.values()).reduce((s, n) => s + n, 0),
        // Alphabetical, with "Other ..." entries last
        categories: Array.from(cats.entries())
          .map(([c, count]) => ({ name: c, count }))
          .sort(
            (a, b) =>
              Number(a.name.startsWith('Other')) - Number(b.name.startsWith('Other')) ||
              a.name.localeCompare(b.name, undefined, { sensitivity: 'base' })
          ),
      }));
  }, [index]);

  const tools = useMemo(() => {
    if (!index) return [];
    let list: ToolEntry[];
    if (!query.trim()) {
      list = [...index.tools];
    } else {
      if (!fuse) return [];
      list = fuse.search(query).map((r) => r.item);
    }
    if (categoryFilter) {
      list = categoryFilter.startsWith(GROUP_PREFIX)
        ? list.filter((t) => groupOf(t) === categoryFilter.slice(GROUP_PREFIX.length))
        : list.filter((t) => categoryOf(t) === categoryFilter);
    }
    // Rank by conda downloads (descending); missing or 0 last
    list.sort((a, b) => (b.conda_downloads_num ?? 0) - (a.conda_downloads_num ?? 0));
    return list;
  }, [index, query, fuse, categoryFilter]);

  const totalPages = Math.max(1, Math.ceil(tools.length / PAGE_SIZE));
  const pageTools = useMemo(
    () => tools.slice((currentPage - 1) * PAGE_SIZE, currentPage * PAGE_SIZE),
    [tools, currentPage]
  );

  useEffect(() => {
    setCurrentPage(1);
  }, [query, categoryFilter]);

  const totalCwls = useMemo(
    () => (index ? index.tools.reduce((s, t) => s + t.cwl_count, 0) : 0),
    [index]
  );
  const totalSkills = useMemo(
    () => (index ? index.tools.filter((t) => t.has_skill).length : 0),
    [index]
  );

  return (
    <>
      <section className="mb-12 grid grid-cols-1 lg:grid-cols-2 gap-8 items-start">
        <div className="space-y-6">
          <div>
            <h1 className="text-3xl md:text-4xl font-bold tracking-tight mb-2">
              MCPs & Skills
            </h1>
            <p className="text-[var(--muted)] max-w-2xl mb-4">
              Discover and download SKILL.md and MCPs (CWL definitions) for CLI tools and workflows.
            </p>
            {index && (
              <div className="flex flex-wrap gap-4 items-center">
                <span className="inline-flex items-center gap-2 px-3 py-1.5 rounded-lg bg-[var(--toolname)]/20 text-[var(--toolname)] font-semibold">
                  <span className="text-xl tabular-nums">{totalCwls}</span>
                  MCPs
                </span>
                <span className="inline-flex items-center gap-2 px-3 py-1.5 rounded-lg bg-[var(--success)]/15 text-[var(--success)] font-semibold">
                  <span className="text-xl tabular-nums">{totalSkills}</span>
                  skills
                </span>
                <a
                  href={REQUEST_ISSUE_URL}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-baseline gap-0.5 text-sm font-bold text-[var(--accent)] hover:underline"
                >
                  <span className="text-lg">++</span> More
                </a>
              </div>
            )}
          </div>
          <div className="rounded-xl border border-[var(--border)] bg-[var(--surface)] p-4 lg:p-5">
            <h2 className="text-sm font-semibold text-[var(--text)] mb-3">Search and install MCPs & Skills</h2>
            <pre className="px-3 py-2 rounded bg-[var(--bg)] border border-[var(--border)] font-mono text-xs overflow-x-auto">
              <code>{`coala search bwa\ncoala mcp bwa\ncoala skill bwa`}</code>
            </pre>
          </div>
        </div>
        <div className="flex justify-center lg:justify-end">
          <img
            src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/coala_agent.svg`}
            alt="Coala"
            className="max-w-full h-auto w-full max-w-md coala-hero-svg"
          />
        </div>
      </section>

      <section className="mb-8">
        <div className="flex rounded-lg border border-[var(--border)] bg-[var(--surface)] overflow-hidden transition-colors focus-within:ring-2 focus-within:ring-[var(--accent)]/50 focus-within:border-[var(--accent)]">
          <div className="relative flex-1 min-w-0">
            <span className="absolute left-3 top-1/2 -translate-y-1/2 text-[var(--muted)] text-sm pointer-events-none">
              search
            </span>
            <input
              type="search"
              placeholder="Search tools..."
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              className="w-full pl-20 pr-3 py-2.5 border-0 bg-transparent text-[var(--text)] placeholder:text-[var(--muted)] focus:outline-none focus:ring-0 text-sm"
            />
          </div>
          <div className="flex items-stretch shrink-0 border-l border-[var(--border)] bg-[var(--surface)]">
            <label htmlFor="category-filter" className="sr-only">
              Category
            </label>
            <select
              id="category-filter"
              value={categoryFilter}
              onChange={(e) => setCategoryFilter(e.target.value)}
              className="min-w-[9rem] max-w-[42vw] sm:max-w-none sm:min-w-[11rem] py-2.5 pl-3 pr-2 border-0 text-sm focus:outline-none focus:ring-0 cursor-pointer"
              aria-label="Filter by category"
            >
              <option value="">All categories</option>
              {categoryGroups.map((g) =>
                g.categories.length === 1 ? (
                  <option key={g.name} value={g.categories[0].name}>
                    {g.categories[0].name} ({g.count})
                  </option>
                ) : (
                  <optgroup key={g.name} label={g.name}>
                    <option value={`${GROUP_PREFIX}${g.name}`}>
                      All {g.name.toLowerCase()} ({g.count})
                    </option>
                    {g.categories.map((c) => (
                      <option key={c.name} value={c.name}>
                        {c.name} ({c.count})
                      </option>
                    ))}
                  </optgroup>
                )
              )}
            </select>
          </div>
        </div>
      </section>

      {loading && (
        <p className="text-[var(--muted)]">Loading index...</p>
      )}

      {!loading && index && (
        <section>
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {pageTools.map((tool) => (
              <Link
                key={tool.id}
                href={`/tool/${tool.id}/`}
                className="flex flex-col p-4 rounded-xl border border-[var(--border)] bg-[var(--surface)] hover:bg-[var(--card-hover)] hover:border-[var(--muted)]/50 transition-colors"
              >
                <h2 className="font-semibold text-[var(--toolname)] pb-2 mb-2 border-b border-[var(--border)]">
                  {tool.id}
                </h2>
                <p className="text-sm text-[var(--muted)] line-clamp-3 mb-3 flex-1">
                  {tool.overview || tool.description}
                </p>
                <div className="flex flex-wrap gap-2 text-xs text-[var(--muted)] mt-auto justify-between items-center">
                  <div className="flex flex-wrap gap-2">
                    <span className="px-2 py-0.5 rounded bg-[var(--surface)] border border-[var(--border)]">
                      {categoryOf(tool)}
                    </span>
                    <span className="px-2 py-0.5 rounded bg-[var(--surface)] border border-[var(--border)]">
                      {tool.cwl_count} CWL{tool.cwl_count !== 1 ? 's' : ''}
                    </span>
                  </div>
                  {tool.conda_downloads && (
                    <span className="inline-flex items-center gap-1 shrink-0">
                      <svg className="w-3.5 h-3.5 shrink-0 text-[var(--accent)]" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden>
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
                      </svg>
                      {tool.conda_downloads}
                    </span>
                  )}
                </div>
              </Link>
            ))}
          </div>
          {tools.length === 0 && (
            <p className="text-[var(--muted)]">No tools match your search.</p>
          )}
          {tools.length > 0 && totalPages > 1 && (
            <nav
              className="mt-8 flex flex-wrap items-center justify-center gap-4"
              aria-label="Pagination"
            >
              <button
                type="button"
                onClick={() => setCurrentPage((p) => Math.max(1, p - 1))}
                disabled={currentPage <= 1}
                className="px-4 py-2 rounded-lg border border-[var(--border)] bg-[var(--surface)] text-sm disabled:opacity-50 disabled:cursor-not-allowed hover:bg-[var(--card-hover)]"
              >
                Previous
              </button>
              <span className="text-sm text-[var(--muted)]">
                Page {currentPage} of {totalPages}
              </span>
              <button
                type="button"
                onClick={() => setCurrentPage((p) => Math.min(totalPages, p + 1))}
                disabled={currentPage >= totalPages}
                className="px-4 py-2 rounded-lg border border-[var(--border)] bg-[var(--surface)] text-sm disabled:opacity-50 disabled:cursor-not-allowed hover:bg-[var(--card-hover)]"
              >
                Next
              </button>
            </nav>
          )}
        </section>
      )}
    </>
  );
}
