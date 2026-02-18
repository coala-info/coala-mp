'use client';

import { useEffect, useState, useMemo } from 'react';
import Link from 'next/link';
import Fuse from 'fuse.js';

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
};

type IndexData = {
  tools: ToolEntry[];
  total: number;
};

export default function HomePage() {
  const [index, setIndex] = useState<IndexData | null>(null);
  const [query, setQuery] = useState('');
  const [loading, setLoading] = useState(true);

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
    if (!query.trim()) return index.tools;
    if (!fuse) return [];
    return fuse.search(query).map((r) => r.item);
  }, [index, query, fuse]);

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
            <span className="inline-flex items-center gap-2 px-3 py-1.5 rounded-lg bg-[var(--toolname)]/20 text-[var(--toolname)] font-mono font-semibold">
              <span className="text-xl tabular-nums">{totalCwls}</span>
              MCPs
            </span>
            <span className="inline-flex items-center gap-2 px-3 py-1.5 rounded-lg bg-[var(--success)]/15 text-[var(--success)] font-mono font-semibold">
              <span className="text-xl tabular-nums">{totalSkills}</span>
              skills
            </span>
          </div>
        )}
      </section>

      <section className="mb-8">
        <div className="flex flex-col sm:flex-row gap-4 items-stretch sm:items-center">
          <div className="relative flex-1">
            <span className="absolute left-3 top-1/2 -translate-y-1/2 text-[var(--muted)] font-mono text-sm">
              search
            </span>
            <input
              type="search"
              placeholder="Search tools..."
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              className="w-full pl-20 pr-4 py-2.5 rounded-lg bg-[var(--surface)] border border-[var(--border)] text-[var(--text)] placeholder:text-[var(--muted)] focus:outline-none focus:ring-2 focus:ring-[var(--accent)]/50 focus:border-[var(--accent)] font-mono text-sm"
            />
          </div>
        </div>
      </section>

      {loading && (
        <p className="text-[var(--muted)] font-mono">Loading index...</p>
      )}

      {!loading && index && (
        <section>
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {tools.map((tool) => (
              <Link
                key={tool.id}
                href={`/tool/${tool.id}/`}
                className="flex flex-col p-4 rounded-xl border border-[var(--border)] bg-[var(--surface)] hover:bg-[var(--card-hover)] hover:border-[var(--muted)]/50 transition-colors"
              >
                <h2 className="font-semibold font-mono text-[var(--toolname)] pb-2 mb-2 border-b border-[var(--border)]">
                  {tool.name}
                </h2>
                <p className="text-sm text-[var(--muted)] line-clamp-3 mb-3 flex-1">
                  {tool.overview || tool.description}
                </p>
                <div className="flex flex-wrap gap-2 text-xs font-mono text-[var(--muted)] mt-auto">
                  {tool.has_skill && (
                    <span className="px-2 py-0.5 rounded bg-[var(--surface)] border border-[var(--border)]">
                      skill
                    </span>
                  )}
                  <span className="px-2 py-0.5 rounded bg-[var(--surface)] border border-[var(--border)]">
                    {tool.cwl_count} CWL{tool.cwl_count !== 1 ? 's' : ''}
                  </span>
                </div>
              </Link>
            ))}
          </div>
          {tools.length === 0 && (
            <p className="text-[var(--muted)]">No tools match your search.</p>
          )}
        </section>
      )}
    </>
  );
}
