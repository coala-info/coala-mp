import { readFileSync, existsSync } from 'fs';
import path from 'path';
import Link from 'next/link';
import ReactMarkdown from 'react-markdown';
import ToolStatsCard from './ToolStatsCard';

type ToolData = {
  id: string;
  name: string;
  description: string;
  homepage: string;
  validation: string;
  cwl_count: number;
  has_skill: boolean;
  runtime_summary: Array<Record<string, string>>;
  report: {
    runtime_summary_table: Array<Record<string, string>>;
    tool_names: string[];
    docker_image: string;
    homepage: string;
    validation: string;
    conda_downloads?: string;
    last_updated?: string;
    github?: string;
    skill_generated: boolean;
    validation_run: 'pass' | 'ongoing' | 'not_done';
  };
  cwl_files: string[];
  skill_file: string | null;
  skills_repo_link: string | null;
  cwls_repo_link: string | null;
  skill_markdown: string | null;
  skill_front_matter?: Record<string, string>;
};

function loadIndex(): { tools: Array<{ id: string }> } {
  const p = path.join(process.cwd(), 'public', 'tools-index.json');
  if (!existsSync(p)) return { tools: [] };
  return JSON.parse(readFileSync(p, 'utf-8'));
}

function loadTool(id: string): ToolData | null {
  const p = path.join(process.cwd(), 'public', 'tools', `${id}.json`);
  if (!existsSync(p)) return null;
  return JSON.parse(readFileSync(p, 'utf-8'));
}

// Data source repo for tool links (Skills / CWLs). Override with NEXT_PUBLIC_DATA_REPO (e.g. "org/repo") and optionally NEXT_PUBLIC_DATA_REPO_BRANCH.
const DATA_REPO =
  process.env.NEXT_PUBLIC_DATA_REPO || 'coala-info/coala-repo';
const DATA_REPO_BRANCH = process.env.NEXT_PUBLIC_DATA_REPO_BRANCH || 'main';
const DATA_REPO_DATA_PATH = process.env.NEXT_PUBLIC_DATA_REPO_DATA_PATH || 'data';

function dataRepoTreeUrl(toolId: string, subpath = '') {
  const pathPart = subpath ? `${DATA_REPO_DATA_PATH}/${toolId}/${subpath}` : `${DATA_REPO_DATA_PATH}/${toolId}`;
  return `https://github.com/${DATA_REPO}/tree/${DATA_REPO_BRANCH}/${pathPart}`;
}

export function generateStaticParams() {
  const { tools } = loadIndex();
  return tools.map((t) => ({ id: t.id }));
}

export default function ToolPage({ params }: { params: { id: string } }) {
  const id = params.id;
  const data = loadTool(id);

  if (!data) {
    return (
      <div className="py-12">
        <p className="text-red-400 mb-4">Tool not found.</p>
        <Link href="/" className="text-[var(--accent)] hover:underline">
          ← Back to browse
        </Link>
      </div>
    );
  }

  const skillsLink = data.skills_repo_link || (data.has_skill ? dataRepoTreeUrl(data.id, 'skills') : null);
  const cwlsLink = data.cwls_repo_link || (data.cwl_count > 0 ? dataRepoTreeUrl(data.id) : null);
  const reportIssueUrl = `https://github.com/${DATA_REPO}/issues/new?${new URLSearchParams({
    title: `Bug: ${data.name}`,
    type: 'bug',
  }).toString()}`;

  const cardClass = 'rounded-xl border border-[var(--border)] bg-[var(--surface)] p-4';

  return (
    <article>
      <div className="mb-6">
        <Link href="/" className="text-sm text-[var(--muted)] hover:text-[var(--accent)] transition-colors">
          ← Browse tools
        </Link>
      </div>

      <header className="mb-8">
        <div className="mb-2">
          <h1 className="text-2xl md:text-3xl font-bold text-[var(--toolname)]">
            {data.name}
          </h1>
        </div>
        {data.homepage && (
          <a
            href={data.homepage}
            target="_blank"
            rel="noopener noreferrer"
            className="text-sm text-[var(--accent)] hover:underline"
          >
            {data.homepage}
          </a>
        )}
      </header>

      <div className="grid grid-cols-1 lg:grid-cols-[1fr_280px] gap-8 lg:gap-10">
        {/* Main content: Stats card + SKILL.md card */}
        <div className="min-w-0 space-y-6">
          <ToolStatsCard
            conda_downloads={data.report.conda_downloads ?? ''}
            last_updated={data.report.last_updated ?? ''}
            github={data.report.github ?? null}
          />
          {data.skill_markdown && (
            <section className={cardClass}>
              <h2 className="text-base font-semibold mb-3 pb-3 border-b border-[var(--border)]">SKILL.md</h2>
              {data.skill_front_matter && Object.keys(data.skill_front_matter).length > 0 && (
                <div className="mb-4 overflow-x-auto">
                  <table className="w-full text-sm border-collapse">
                    <tbody>
                      {Object.entries(data.skill_front_matter).map(([key, value]) => (
                        <tr key={key} className="border-b border-[var(--border)] last:border-0">
                          <td className="py-2 pr-4 text-[var(--muted)] align-top font-medium w-32 shrink-0">{key}</td>
                          <td className="py-2 text-[var(--text)] break-words">{value}</td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}
              <div className="skill-markdown overflow-x-auto text-sm text-[var(--muted)]">
                <ReactMarkdown
                  components={{
                    h1: ({ children }) => <h1 className="text-lg font-semibold text-[var(--text)] mt-4 mb-2 first:mt-0">{children}</h1>,
                    h2: ({ children }) => <h2 className="text-base font-semibold text-[var(--text)] mt-3 mb-2">{children}</h2>,
                    h3: ({ children }) => <h3 className="text-sm font-semibold text-[var(--text)] mt-2 mb-1">{children}</h3>,
                    p: ({ children }) => <p className="mb-2">{children}</p>,
                    ul: ({ children }) => <ul className="list-disc pl-5 mb-2">{children}</ul>,
                    ol: ({ children }) => <ol className="list-decimal pl-5 mb-2">{children}</ol>,
                    li: ({ children }) => <li className="mb-0.5">{children}</li>,
                    code: ({ children }) => <code className="px-1.5 py-0.5 rounded bg-[var(--bg)] text-[var(--accent)] font-mono text-xs">{children}</code>,
                    pre: ({ children }) => <pre className="p-3 rounded bg-[var(--bg)] overflow-x-auto text-xs mb-2 font-mono">{children}</pre>,
                  }}
                >
                  {data.skill_markdown}
                </ReactMarkdown>
              </div>
            </section>
          )}
        </div>

        {/* Right sidebar: Metadata + Download + Install cards */}
        <aside className="space-y-4 lg:space-y-5">
          <section className={cardClass}>
            <h2 className="text-base font-semibold pb-2 mb-3 border-b border-[var(--border)]">Metadata</h2>
            <dl className="grid gap-2 text-sm">
              {data.report.docker_image && (
                <>
                  <dt className="text-[var(--muted)]">Docker image</dt>
                  <dd className="break-all font-mono text-xs">{data.report.docker_image}</dd>
                </>
              )}
              <dt className="text-[var(--muted)]">Validation</dt>
              <dd>
                <span
                  className={`inline-block text-xs px-2 py-1 rounded ${
                    data.report.validation_run === 'pass'
                      ? 'bg-[var(--success)]/20 text-[var(--success)]'
                      : data.report.validation_run === 'ongoing'
                        ? 'bg-[var(--warning)]/20 text-[var(--warning)]'
                        : 'bg-[var(--border)]/50 text-[var(--muted)]'
                  }`}
                >
                  {data.report.validation_run === 'pass'
                    ? 'Pass'
                    : data.report.validation_run === 'ongoing'
                      ? 'Ongoing'
                      : 'Not done'}
                </span>
              </dd>
              <dt className="text-[var(--muted)]">CWLs</dt>
              <dd>{data.cwl_count}</dd>
            </dl>
          </section>

          <section className={cardClass}>
            <h2 className="text-base font-semibold pb-2 mb-3 border-b border-[var(--border)]">Download</h2>
            <div className="flex flex-col gap-2">
              {skillsLink && (
                <a
                  href={skillsLink}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center justify-center gap-2 px-4 py-2 rounded-lg border border-[var(--border)] hover:bg-[var(--card-hover)] text-sm"
                >
                  Skills
                </a>
              )}
              {cwlsLink && (
                <a
                  href={cwlsLink}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="inline-flex items-center justify-center gap-2 px-4 py-2 rounded-lg border border-[var(--border)] hover:bg-[var(--card-hover)] text-sm"
                >
                  CWLs
                </a>
              )}
              <a
                href={reportIssueUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center justify-center gap-2 px-4 py-2 rounded-lg border border-[var(--border)] hover:bg-[var(--card-hover)] text-sm text-[var(--muted)]"
              >
                Report issue
              </a>
            </div>
          </section>

          {(data.cwl_count > 0 || data.has_skill) && (
            <section className={cardClass}>
              <h2 className="text-base font-semibold pb-2 mb-3 border-b border-[var(--border)]">Install</h2>
              <div className="space-y-3 text-sm">
                {data.cwl_count > 0 && (
                  <div>
                    <p className="text-[var(--muted)] text-xs mb-1">MCP install</p>
                    <code className="block px-3 py-2 rounded bg-[var(--bg)] border border-[var(--border)] font-mono text-xs break-all">
                      coala mcp {data.id}
                    </code>
                  </div>
                )}
                {data.has_skill && (
                  <div>
                    <p className="text-[var(--muted)] text-xs mb-1">Skill install</p>
                    <code className="block px-3 py-2 rounded bg-[var(--bg)] border border-[var(--border)] font-mono text-xs break-all">
                      coala skill {data.id}
                    </code>
                  </div>
                )}
              </div>
            </section>
          )}
        </aside>
      </div>
    </article>
  );
}
