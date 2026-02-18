import type { Metadata } from 'next';
import { JetBrains_Mono, Space_Grotesk } from 'next/font/google';
import './globals.css';

const spaceGrotesk = Space_Grotesk({
  subsets: ['latin'],
  variable: '--font-sans',
});
const jetbrainsMono = JetBrains_Mono({
  subsets: ['latin'],
  variable: '--font-mono',
});

export const metadata: Metadata = {
  title: 'CLI MCPs & Skills',
  description: 'Discover and download SKILL.md and MCPs (CWL definitions) for CLI tools',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={`${spaceGrotesk.variable} ${jetbrainsMono.variable}`}>
      <body className="min-h-screen font-sans antialiased bg-[var(--bg)] text-[var(--text)]">
        <header className="border-b border-[var(--border)] bg-[var(--surface)]/80 sticky top-0 z-10 backdrop-blur">
          <div className="max-w-6xl mx-auto px-4 h-14 flex items-center justify-between">
            <a href="/" className="font-semibold text-lg tracking-tight hover:text-[var(--accent)] transition-colors">
              CLI MCPs & Skills
            </a>
            <nav className="flex items-center gap-6 text-sm text-[var(--muted)]">
              <a href="/" className="hover:text-[var(--text)] transition-colors">Browse</a>
            </nav>
          </div>
        </header>
        <main className="max-w-6xl mx-auto px-4 py-8">
          {children}
        </main>
        <footer className="border-t border-[var(--border)] mt-16 py-8 text-center text-sm text-[var(--muted)]">
          <p>MCPs and skills for CLI tools. Search and download.</p>
        </footer>
      </body>
    </html>
  );
}
