import Image from "next/image";
import type { Content } from "@/lib/content";
import { StoreBadges } from "@/components/ui/StoreBadges";

export function Hero({ t }: { t: Content }) {
  return (
    <section className="relative overflow-hidden">
      <div
        aria-hidden
        className="pointer-events-none absolute -right-24 -top-24 h-96 w-96 rounded-full bg-accent/20 blur-3xl"
      />
      <div
        aria-hidden
        className="pointer-events-none absolute -bottom-32 -left-24 h-80 w-80 rounded-full bg-primary/10 blur-3xl"
      />
      <div className="relative mx-auto grid max-w-6xl items-center gap-12 px-5 py-16 md:grid-cols-2 md:py-24">
        <div>
          <span className="inline-flex items-center gap-2 rounded-full bg-accent/15 px-3 py-1 text-sm font-bold text-accent-dark">
            <span className="h-2 w-2 rounded-full bg-accent" />
            {t.hero.eyebrow}
          </span>
          <h1 className="mt-5 font-display text-4xl font-bold leading-[1.15] tracking-tight sm:text-5xl">
            {t.hero.title}
            <br />
            <span className="text-primary">{t.hero.titleAccent}</span>
          </h1>
          <p className="mt-5 max-w-md text-lg text-muted">{t.hero.subtitle}</p>
          <StoreBadges badges={t.badges} className="mt-8" />
          <p className="mt-4 text-sm text-muted">{t.hero.note}</p>
        </div>

        <div className="flex justify-center">
          <Image
            src="/screenshots/mockup-portrait.png"
            alt="Skapka"
            width={1570}
            height={2932}
            priority
            className="h-auto w-[260px] drop-shadow-2xl sm:w-[300px]"
          />
        </div>
      </div>
    </section>
  );
}
