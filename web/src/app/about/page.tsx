import type { Metadata } from 'next';
import Link from 'next/link';

export const metadata: Metadata = {
  title: 'About',
  description:
    'About Agent MCPs & Skills — important limitations and disclaimer for research use.',
};

export default function AboutPage() {
  return (
    <div className="max-w-3xl space-y-10">
      <div>
        <h1 className="text-3xl md:text-4xl font-bold tracking-tight mb-3">About</h1>
        <p className="text-[var(--muted)] leading-relaxed">
          This site is a catalogue for discovering and downloading SKILL.md files and MCP
          definitions (including CWL) for CLI tools and workflows used with the Coala ecosystem.
          It exists to support exploration and research workflows—not as a guarantee of fitness for
          any particular purpose.
        </p>
      </div>

      <section className="rounded-xl border border-[var(--border)] bg-[var(--surface)] p-4 md:p-5 space-y-3" aria-labelledby="install-heading">
        <h2 id="install-heading" className="text-sm font-semibold text-[var(--text)]">
          Install Coala
        </h2>
        <p className="text-sm text-[var(--muted)] leading-relaxed">
          Install the Coala client with pip, then use the CLI to search, fetch MCPs, and pull skills
          as shown on the home page.
        </p>
        <pre className="px-3 py-2 rounded bg-[var(--bg)] border border-[var(--border)] font-mono text-sm overflow-x-auto">
          <code>pip install coala-client</code>
        </pre>
      </section>

      <section
        className="rounded-xl border-2 border-[var(--warning)] bg-[var(--warning)]/10 p-6 md:p-8 space-y-5"
        aria-labelledby="disclaimer-heading"
      >
        <h2 id="disclaimer-heading" className="text-xl font-bold text-[var(--text)] tracking-tight">
          Disclaimer — read before use
        </h2>
        <p className="font-semibold text-[var(--warning)] leading-relaxed">
          For research and educational use only. Nothing on this site constitutes medical,
          diagnostic, legal, or regulatory advice.
        </p>
        <ul className="list-disc pl-5 space-y-3 text-[var(--text)] leading-relaxed">
          <li>
            <strong className="text-[var(--text)]">Not validated.</strong> Listings, metadata,
            generated or packaged workflows, CWL, MCP definitions, and skills have not been
            independently verified for correctness, completeness, reproducibility, or safety. They
            may be incomplete, outdated, or wrong for your environment.
          </li>
          <li>
            <strong className="text-[var(--text)]">Generated workflows may contain errors.</strong>{' '}
            Automatically produced or templated pipelines can include mistakes in parameters,
            data paths, tool versions, resource requirements, or scientific logic. You are solely
            responsible for reviewing, testing, and validating any workflow before relying on it.
          </li>
          <li>
            <strong className="text-[var(--text)]">No warranty.</strong> Materials are provided “as
            is” without warranty of any kind. To the fullest extent permitted by law, providers
            and contributors disclaim liability for any loss or damage arising from use of this site
            or downloaded artifacts.
          </li>
        </ul>
        <p className="text-sm text-[var(--muted)] leading-relaxed border-t border-[var(--warning)]/40 pt-5">
          If you use these tools or workflows in regulated, clinical, or production settings, you
          must follow your organization’s validation, quality, and compliance requirements. Do not
          use outputs from this catalogue as a substitute for expert review or domain-specific
          validation.
        </p>
      </section>

      <p className="text-sm text-[var(--muted)]">
        <Link href="/" className="text-[var(--accent)] hover:underline font-medium">
          ← Back to browse
        </Link>
      </p>
    </div>
  );
}
