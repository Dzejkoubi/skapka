import type { Content } from "@/lib/content";

export function HowItWorks({ t }: { t: Content }) {
  return (
    <section id="how" className="bg-surface py-20">
      <div className="mx-auto max-w-6xl px-5">
        <div className="mx-auto max-w-2xl text-center">
          <h2 className="font-display text-3xl font-bold leading-[1.32] tracking-tight sm:text-4xl">
            {t.howSection.title}
          </h2>
          <p className="mt-3 text-lg text-muted">{t.howSection.subtitle}</p>
        </div>

        <div className="mt-12 grid gap-10 md:grid-cols-3">
          {t.steps.map((s, i) => (
            <div key={i} className="text-center">
              <div className="mx-auto flex h-14 w-14 items-center justify-center rounded-full bg-primary text-xl font-bold text-white shadow-soft">
                {i + 1}
              </div>
              <h3 className="mt-4 text-lg font-bold">{s.title}</h3>
              <p className="mt-2 text-muted">{s.desc}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
