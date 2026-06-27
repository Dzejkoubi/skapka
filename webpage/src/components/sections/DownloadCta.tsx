import type { Content } from "@/lib/content";
import { StoreBadges } from "@/components/ui/StoreBadges";

export function DownloadCta({ t }: { t: Content }) {
  return (
    <section id="download" className="px-5 py-20">
      <div className="mx-auto max-w-5xl overflow-hidden rounded-2xl bg-[linear-gradient(135deg,#2a67b2,#204f88)] px-8 py-14 text-center shadow-elevated">
        <h2 className="font-display text-3xl font-bold leading-[1.32] tracking-tight text-white sm:text-4xl">
          {t.cta.title}
        </h2>
        <p className="mt-3 text-lg font-medium text-white/80">
          {t.cta.subtitle}
        </p>
        <StoreBadges badges={t.badges} className="mt-8 justify-center" />
      </div>
    </section>
  );
}
