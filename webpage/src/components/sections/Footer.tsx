import Image from "next/image";
import type { Content } from "@/lib/content";
import { AUTHOR, CONTACT_EMAIL, GITHUB_REPO } from "@/config/site";

export function Footer({ t }: { t: Content }) {
  return (
    <footer className="bg-ink px-5 py-12 text-white/70">
      <div className="mx-auto flex max-w-6xl flex-col items-center gap-6 text-center md:flex-row md:justify-between md:text-left">
        <div className="flex items-center gap-3">
          <Image
            src="/skapka-logo-yellow.png"
            alt="Skapka"
            width={28}
            height={28}
            className="h-7 w-7"
          />
          <div>
            <p className="font-display font-bold text-white">Skapka</p>
            <p className="text-sm">{t.footer.tagline}</p>
          </div>
        </div>

        <div className="flex flex-wrap items-center justify-center gap-6 text-sm font-bold">
          <a href="#" className="transition hover:text-white">
            {t.footer.privacy}
          </a>
          <a
            href={`mailto:${CONTACT_EMAIL}`}
            className="transition hover:text-white"
          >
            {t.footer.contact}
          </a>
        </div>
      </div>

      <div className="mx-auto mt-8 max-w-6xl border-t border-white/10 pt-6 text-center text-sm">
        © {new Date().getFullYear()} Skapka. {t.footer.rights} ·{" "}
        {t.footer.createdBy}{" "}
        <a
          href={GITHUB_REPO}
          target="_blank"
          rel="noopener noreferrer"
          className="font-bold text-white/90 underline transition hover:text-white"
        >
          {AUTHOR}
        </a>
      </div>
    </footer>
  );
}
