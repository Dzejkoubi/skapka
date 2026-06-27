"use client";

import { useEffect } from "react";
import { content } from "@/lib/content";
import { useLang } from "@/hooks/useLang";
import { Header } from "@/components/sections/Header";
import { Hero } from "@/components/sections/Hero";
import { Features } from "@/components/sections/Features";
import { HowItWorks } from "@/components/sections/HowItWorks";
import { DownloadCta } from "@/components/sections/DownloadCta";
import { Footer } from "@/components/sections/Footer";

export default function Home() {
  const [lang, setLang] = useLang();

  // Keep the document language in sync for accessibility (not state — DOM only).
  useEffect(() => {
    document.documentElement.lang = lang;
  }, [lang]);

  const t = content[lang];

  return (
    <div id="top">
      <Header t={t} lang={lang} setLang={setLang} />
      <Hero t={t} />
      <Features t={t} />
      <HowItWorks t={t} />
      <DownloadCta t={t} />
      <Footer t={t} />
    </div>
  );
}
