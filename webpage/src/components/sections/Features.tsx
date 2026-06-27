import type { Content } from "@/lib/content";
import { iconMap } from "@/components/ui/Icons";

export function Features({ t }: { t: Content }) {
  return (
    <section id="features" className="mx-auto max-w-6xl px-5 py-20">
      <div className="mx-auto max-w-2xl text-center">
        <h2 className="font-display text-3xl font-bold leading-[1.32] tracking-tight sm:text-4xl">
          {t.featuresSection.title}
        </h2>
        <p className="mt-3 text-lg text-muted">{t.featuresSection.subtitle}</p>
      </div>

      <div className="mt-12 grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
        {t.features.map((f, i) => {
          const Icon = iconMap[f.icon];
          return (
            <div
              key={i}
              className="rounded-xl border border-border bg-surface p-6 shadow-card transition hover:-translate-y-1 hover:shadow-elevated"
            >
              <div className="flex h-12 w-12 items-center justify-center rounded-lg bg-accent/15 text-accent-dark">
                <Icon className="h-6 w-6" />
              </div>
              <h3 className="mt-4 text-lg font-bold">{f.title}</h3>
              <p className="mt-2 text-muted">{f.desc}</p>
            </div>
          );
        })}
      </div>
    </section>
  );
}
