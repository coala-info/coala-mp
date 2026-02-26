'use client';

import { useEffect, useState } from 'react';

function parseGitHubRepo(url: string): { owner: string; repo: string } | null {
  if (!url?.trim()) return null;
  const m = url.match(/github\.com\/[\w.-]+\/[\w.-]+/i);
  if (!m) return null;
  const parts = m[0].replace(/^github\.com\//i, '').split('/').filter(Boolean);
  return parts.length >= 2 ? { owner: parts[0], repo: parts[1] } : null;
}

const iconClass = 'w-4 h-4 shrink-0';

function IconDownload() {
  return (
    <svg className={iconClass} fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden>
      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
    </svg>
  );
}

function IconStar() {
  return (
    <svg className={iconClass} fill="currentColor" viewBox="0 0 24 24" aria-hidden>
      <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" />
    </svg>
  );
}

function IconCalendar() {
  return (
    <svg className={iconClass} fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden>
      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
    </svg>
  );
}

type Props = {
  conda_downloads: string;
  last_updated: string;
  github: string | null;
};

export default function ToolStatsCard({ conda_downloads, last_updated, github }: Props) {
  const [stars, setStars] = useState<number | null>(null);
  const [starsError, setStarsError] = useState(false);

  useEffect(() => {
    const repo = parseGitHubRepo(github ?? '');
    if (!repo) {
      setStarsError(true);
      return;
    }
    fetch(`https://api.github.com/repos/${repo.owner}/${repo.repo}`, {
      headers: { Accept: 'application/vnd.github.v3+json' },
    })
      .then((r) => {
        if (!r.ok) throw new Error('Not found');
        return r.json();
      })
      .then((data) => setStars(data.stargazers_count ?? null))
      .catch(() => setStarsError(true));
  }, [github]);

  const hasAny = conda_downloads || last_updated || !!github;
  if (!hasAny) return null;

  const starDisplay = stars !== null ? stars.toLocaleString() : starsError ? '—' : '…';

  return (
    <section className="rounded-xl border border-[var(--border)] bg-[var(--surface)] px-4 py-3 mb-6">
      <div className="flex flex-wrap items-center gap-x-6 gap-y-2 text-sm">
        {conda_downloads && (
          <span className="inline-flex items-center gap-1.5">
            <span className="text-[var(--accent)]" aria-hidden>
              <IconDownload />
            </span>
            <span className="text-[var(--muted)]">downloads:</span>
            <span className="text-[var(--accent)]">{conda_downloads}</span>
          </span>
        )}
        {github && (
          <span className="inline-flex items-center gap-1.5">
            <span className="text-[var(--warning)]" aria-hidden>
              <IconStar />
            </span>
            <span className="text-[var(--muted)]">stars:</span>
            <span className="text-[var(--warning)]">{starDisplay}</span>
          </span>
        )}
        {last_updated && (
          <span className="inline-flex items-center gap-1.5">
            <span className="text-[var(--success)]" aria-hidden>
              <IconCalendar />
            </span>
            <span className="text-[var(--muted)]">updated:</span>
            <span className="text-[var(--success)]">{last_updated}</span>
          </span>
        )}
      </div>
    </section>
  );
}
