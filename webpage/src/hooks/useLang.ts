"use client";

import { useCallback, useSyncExternalStore } from "react";
import type { Lang } from "@/lib/content";

const LANG_KEY = "skapka-lang";

function isLang(value: string | null): value is Lang {
  return value === "cs" || value === "en";
}

// Same-tab subscribers (the `storage` event only fires in *other* tabs).
const listeners = new Set<() => void>();

function subscribe(callback: () => void) {
  listeners.add(callback);
  window.addEventListener("storage", callback);
  return () => {
    listeners.delete(callback);
    window.removeEventListener("storage", callback);
  };
}

function getSnapshot(): Lang {
  const stored = localStorage.getItem(LANG_KEY);
  return isLang(stored) ? stored : "cs";
}

// Used during SSR and the first hydration pass so server/client markup match.
function getServerSnapshot(): Lang {
  return "cs";
}

/**
 * Language state backed by localStorage. Uses useSyncExternalStore so the
 * persisted value is read without a setState-in-effect and without a
 * hydration mismatch (server renders "cs", then re-syncs on the client).
 */
export function useLang(): readonly [Lang, (lang: Lang) => void] {
  const lang = useSyncExternalStore(subscribe, getSnapshot, getServerSnapshot);

  const setLang = useCallback((next: Lang) => {
    localStorage.setItem(LANG_KEY, next);
    listeners.forEach((notify) => notify());
  }, []);

  return [lang, setLang] as const;
}
