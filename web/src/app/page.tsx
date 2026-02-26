'use client';

import { useEffect, useState, useMemo } from 'react';
import Link from 'next/link';
import Fuse from 'fuse.js';

const PAGE_SIZE = 9;

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
};

type IndexData = {
  tools: ToolEntry[];
  total: number;
};

export default function HomePage() {
  const [index, setIndex] = useState<IndexData | null>(null);
  const [query, setQuery] = useState('');
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
            keys: ['name', 'id', 'description', 'overview'],
            threshold: 0.35,
          })
        : null,
    [index]
  );

  const tools = useMemo(() => {
    if (!index) return [];
    let list: ToolEntry[];
    if (!query.trim()) {
      list = [...index.tools];
    } else {
      if (!fuse) return [];
      list = fuse.search(query).map((r) => r.item);
    }
    // Rank by conda downloads (descending); missing or 0 last
    list.sort((a, b) => (b.conda_downloads_num ?? 0) - (a.conda_downloads_num ?? 0));
    return list;
  }, [index, query, fuse]);

  const totalPages = Math.max(1, Math.ceil(tools.length / PAGE_SIZE));
  const pageTools = useMemo(
    () => tools.slice((currentPage - 1) * PAGE_SIZE, currentPage * PAGE_SIZE),
    [tools, currentPage]
  );

  useEffect(() => {
    setCurrentPage(1);
  }, [query]);

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
      <section className="mb-12">
        <h1 className="text-3xl md:text-4xl font-bold tracking-tight mb-2">
          MCPs & Skills
        </h1>
        <p className="text-[var(--muted)] max-w-2xl mb-4">
          Discover and download SKILL.md and MCPs (CWL definitions) for CLI tools.
        </p>
        {index && (
          <div className="flex flex-wrap gap-4">
            <span className="inline-flex items-center gap-2 px-3 py-1.5 rounded-lg bg-[var(--toolname)]/20 text-[var(--toolname)] font-semibold">
              <span className="text-xl tabular-nums">{totalCwls}</span>
              MCPs
            </span>
            <span className="inline-flex items-center gap-2 px-3 py-1.5 rounded-lg bg-[var(--success)]/15 text-[var(--success)] font-semibold">
              <span className="text-xl tabular-nums">{totalSkills}</span>
              skills
            </span>
          </div>
        )}
      </section>

      <section className="mb-8">
        <div className="flex flex-col sm:flex-row gap-4 items-stretch sm:items-center">
          <div className="relative flex-1">
            <span className="absolute left-3 top-1/2 -translate-y-1/2 text-[var(--muted)] text-sm">
              search
            </span>
            <input
              type="search"
              placeholder="Search tools..."
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              className="w-full pl-20 pr-4 py-2.5 rounded-lg bg-[var(--surface)] border border-[var(--border)] text-[var(--text)] placeholder:text-[var(--muted)] focus:outline-none focus:ring-2 focus:ring-[var(--accent)]/50 focus:border-[var(--accent)] text-sm"
            />
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
                  {tool.name}
                </h2>
                <p className="text-sm text-[var(--muted)] line-clamp-3 mb-3 flex-1">
                  {tool.overview || tool.description}
                </p>
                <div className="flex flex-wrap gap-2 text-xs text-[var(--muted)] mt-auto justify-between items-center">
                  <div className="flex flex-wrap gap-2">
                    {tool.has_skill && (
                      <span className="px-2 py-0.5 rounded bg-[var(--surface)] border border-[var(--border)]">
                        skill
                      </span>
                    )}
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
