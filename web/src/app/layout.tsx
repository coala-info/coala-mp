import type { Metadata } from 'next';
import Link from 'next/link';
import { JetBrains_Mono, Space_Grotesk } from 'next/font/google';
import './globals.css';
import ThemeSwitch from './ThemeSwitch';

const spaceGrotesk = Space_Grotesk({
  subsets: ['latin'],
  variable: '--font-sans',
});
const jetbrainsMono = JetBrains_Mono({
  subsets: ['latin'],
  variable: '--font-mono',
});

export const metadata: Metadata = {
  title: 'Agent MCPs & Skills',
  description: 'Discover and download SKILL.md and MCPs (CWL definitions) for CLI tools',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={`${spaceGrotesk.variable} ${jetbrainsMono.variable}`} suppressHydrationWarning>
      <head>
        <script
          dangerouslySetInnerHTML={{
            __html: `(function(){var t=localStorage.getItem('coala-mp-theme');var p=window.matchMedia('(prefers-color-scheme: light)').matches?'light':'dark';document.documentElement.setAttribute('data-theme',t==='light'||t==='dark'?t:p);})();`,
          }}
        />
      </head>
      <body className="min-h-screen font-sans antialiased bg-[var(--bg)] text-[var(--text)]">
        <header className="border-b border-[var(--border)] bg-[var(--surface)]/80 sticky top-0 z-10 backdrop-blur">
          <div className="max-w-6xl mx-auto px-4 h-14 flex items-center justify-between">
            <Link href="/" className="font-semibold text-lg tracking-tight hover:text-[var(--accent)] transition-colors">
              Agent MCPs & Skills
            </Link>
            <nav className="flex items-center gap-4 text-sm text-[var(--muted)]">
              <Link href="/" className="hover:text-[var(--text)] transition-colors">Browse</Link>
              <Link href="/about/" className="hover:text-[var(--text)] transition-colors">About</Link>
              <ThemeSwitch />
            </nav>
          </div>
        </header>
        <main className="max-w-6xl mx-auto px-4 py-8">
          {children}
        </main>
        <footer className="border-t border-[var(--border)] mt-16 py-8 text-center text-sm text-[var(--muted)] space-y-2">
          <p>MCPs and skills for CLI tools. Search and download.</p>
          <p>
            <Link href="/about/" className="text-[var(--accent)] hover:underline">
              About &amp; disclaimer
            </Link>
          </p>
        </footer>
      </body>
    </html>
  );
}
