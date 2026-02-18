import { readFileSync, existsSync } from 'fs';
import path from 'path';
import Link from 'next/link';
import ReactMarkdown from 'react-markdown';

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
    skill_generated: boolean;
    validation_run: 'pass' | 'ongoing' | 'not_done';
  };
  cwl_files: string[];
  cwl_zip: string | null;
  skill_file: string | null;
  skills_zip: string | null;
  skill_markdown: string | null;
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

  const baseUrl = '/files/' + encodeURIComponent(data.id);

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
          <h1 className="text-2xl md:text-3xl font-bold font-mono text-[var(--toolname)]">
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
        {/* Main content: SKILL.md card */}
        <div className="min-w-0 space-y-6">
          {data.skill_markdown && (
            <section className={cardClass}>
              <h2 className="text-base font-semibold mb-3 pb-3 border-b border-[var(--border)]">SKILL.md</h2>
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
                    pre: ({ children }) => <pre className="p-3 rounded bg-[var(--bg)] overflow-x-auto text-xs mb-2">{children}</pre>,
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
                  <dt className="text-[var(--muted)] font-mono">Docker image</dt>
                  <dd className="font-mono break-all">{data.report.docker_image}</dd>
                </>
              )}
              <dt className="text-[var(--muted)] font-mono">Validation</dt>
              <dd>
                <span
                  className={`inline-block font-mono text-xs px-2 py-1 rounded ${
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
              <dt className="text-[var(--muted)] font-mono">Commands / CWLs</dt>
              <dd className="font-mono">{data.report.tool_names?.length ?? data.cwl_count}</dd>
            </dl>
          </section>

          <section className={cardClass}>
            <h2 className="text-base font-semibold pb-2 mb-3 border-b border-[var(--border)]">Download</h2>
            <div className="flex flex-col gap-2">
              {data.skills_zip && (
                <a
                  href={`${baseUrl}/${encodeURIComponent(data.skills_zip)}`}
                  download
                  className="inline-flex items-center justify-center gap-2 px-4 py-2 rounded-lg border border-[var(--border)] hover:bg-[var(--card-hover)] font-mono text-sm"
                >
                  Skills
                </a>
              )}
              {data.cwl_zip && (
                <a
                  href={`${baseUrl}/${encodeURIComponent(data.cwl_zip)}`}
                  download
                  className="inline-flex items-center justify-center gap-2 px-4 py-2 rounded-lg border border-[var(--border)] hover:bg-[var(--card-hover)] font-mono text-sm"
                >
                  All CWLs
                </a>
              )}
            </div>
          </section>

          <section className={cardClass}>
            <h2 className="text-base font-semibold pb-2 mb-3 border-b border-[var(--border)]">Install</h2>
            <div className="space-y-3 text-sm">
              <div>
                <p className="text-[var(--muted)] text-xs mb-1">MCP install</p>
                <code className="block px-3 py-2 rounded bg-[var(--bg)] border border-[var(--border)] font-mono text-xs break-all">
                  coala mcp {data.id}
                </code>
              </div>
              <div>
                <p className="text-[var(--muted)] text-xs mb-1">Skill install</p>
                <code className="block px-3 py-2 rounded bg-[var(--bg)] border border-[var(--border)] font-mono text-xs break-all">
                  coala skill {data.id}
                </code>
              </div>
            </div>
          </section>
        </aside>
      </div>
    </article>
  );
}
