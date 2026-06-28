import Image from "next/image";
import type { Content, Lang } from "@/lib/content";
import { LanguageToggle } from "@/components/ui/LanguageToggle";

export function Header({
  t,
  lang,
  setLang,
}: {
  t: Content;
  lang: Lang;
  setLang: (l: Lang) => void;
}) {
  return (
    <header className="sticky top-0 z-50 border-b border-border bg-canvas/80 backdrop-blur">
      <div className="mx-auto flex max-w-6xl items-center justify-between px-5 py-3">
        <a href="#top" className="flex items-center gap-2">
          <Image
            src="/skapka-logo-black.png"
            alt="Skapka"
            width={36}
            height={36}
            className="h-9 w-9"
            priority
          />
          <span className="font-display text-xl font-bold tracking-tight">
            Skapka
          </span>
        </a>

        <nav className="hidden items-center gap-8 text-sm font-bold text-muted md:flex">
          <a href="#features" className="transition hover:text-ink">
            {t.nav.features}
          </a>
          <a href="#how" className="transition hover:text-ink">
            {t.nav.how}
          </a>
          <a href="#download" className="transition hover:text-ink">
            {t.nav.download}
          </a>
        </nav>

        <div className="flex items-center gap-3">
          <LanguageToggle lang={lang} setLang={setLang} />
          <a
            href="#download"
            className="hidden rounded-full bg-primary-light px-4 py-2 text-sm font-bold text-white shadow-soft transition hover:bg-primary-dark sm:inline-block"
          >
            {t.nav.download}
          </a>
        </div>
      </div>
    </header>
  );
}
