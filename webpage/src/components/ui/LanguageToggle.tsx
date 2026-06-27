import type { Lang } from "@/lib/content";

export function LanguageToggle({
  lang,
  setLang,
}: {
  lang: Lang;
  setLang: (l: Lang) => void;
}) {
  const options: { value: Lang; label: string }[] = [
    { value: "cs", label: "CZ" },
    { value: "en", label: "EN" },
  ];
  return (
    <div className="flex items-center rounded-full border border-border bg-surface p-0.5 text-xs font-bold">
      {options.map((o) => (
        <button
          key={o.value}
          type="button"
          onClick={() => setLang(o.value)}
          aria-pressed={lang === o.value}
          className={`rounded-full px-2.5 py-1 transition ${
            lang === o.value ? "bg-primary text-white" : "text-muted hover:text-ink"
          }`}
        >
          {o.label}
        </button>
      ))}
    </div>
  );
}
