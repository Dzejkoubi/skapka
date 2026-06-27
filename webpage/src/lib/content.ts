export type Lang = "cs" | "en";

export type IconKey = "calendar" | "check" | "users" | "sync" | "bell" | "crown";

export type Content = {
  nav: { features: string; how: string; download: string };
  hero: {
    eyebrow: string;
    title: string;
    titleAccent: string;
    subtitle: string;
    note: string;
  };
  badges: {
    appStoreTop: string;
    appStoreBig: string;
    playTop: string;
    playBig: string;
  };
  featuresSection: { title: string; subtitle: string };
  features: { icon: IconKey; title: string; desc: string }[];
  howSection: { title: string; subtitle: string };
  steps: { title: string; desc: string }[];
  cta: { title: string; subtitle: string };
  footer: {
    tagline: string;
    privacy: string;
    contact: string;
    rights: string;
    createdBy: string;
  };
};

export const content: Record<Lang, Content> = {
  cs: {
    nav: { features: "Funkce", how: "Jak to funguje", download: "Stáhnout" },
    hero: {
      eyebrow: "Skautská aplikace",
      title: "Skautské akce,",
      titleAccent: "konečně přehledně",
      subtitle:
        "Skapka spojuje rodiče i vedoucí na jednom místě – přihlašování dětí na akce, přehled o tom, kdo dorazí, a oznámení o novinkách.",
      note: "Zdarma pro iOS i Android.",
    },
    badges: {
      appStoreTop: "Stáhnout v",
      appStoreBig: "App Store",
      playTop: "Stáhnout z",
      playBig: "Google Play",
    },
    featuresSection: {
      title: "Vše pro skautský oddíl",
      subtitle: "Jedna aplikace, která ušetří čas rodičům i vedoucím.",
    },
    features: [
      {
        icon: "calendar",
        title: "Přihlašování na akce",
        desc: "Přihlaste dítě na výpravu nebo tábor jediným klepnutím.",
      },
      {
        icon: "check",
        title: "Přehled účasti",
        desc: "Vedoucí i rodiče okamžitě vidí, kdo na akci dorazí.",
      },
      {
        icon: "bell",
        title: "Oznámení",
        desc: "Upozornění na nové akce a změny rovnou do telefonu.",
      },
      {
        icon: "crown",
        title: "Pro rodiče i vedoucí",
        desc: "Jedna aplikace pro celé středisko – od rodičů až po vedoucí.",
      },
    ],
    howSection: {
      title: "Začněte ve třech krocích",
      subtitle: "Od stažení k první přihlášce za pár minut.",
    },
    steps: [
      { title: "Stáhněte Skapku", desc: "Zdarma pro iOS i Android." },
      {
        title: "Zaregistrujte se",
        desc: "Vytvořte si účet pomocí e-mailu.",
      },
      {
        title: "Počkejte na schválení",
        desc: "Správce oddílu schválí vaši registraci a pak můžete přihlašovat děti na akce.",
      },
    ],
    cta: {
      title: "Stáhněte si Skapku ještě dnes",
      subtitle: "Zdarma pro iOS i Android.",
    },
    footer: {
      tagline: "Skautská aplikace pro rodiče a vedoucí.",
      privacy: "Ochrana soukromí",
      contact: "Kontakt",
      rights: "Všechna práva vyhrazena.",
      createdBy: "Vytvořeno",
    },
  },
  en: {
    nav: { features: "Features", how: "How it works", download: "Download" },
    hero: {
      eyebrow: "The scouting app",
      title: "Scout events,",
      titleAccent: "finally organised",
      subtitle:
        "Skapka brings parents and leaders together in one place – sign your kids up for events, see who's coming, and get notified about what's new.",
      note: "Free for iOS and Android.",
    },
    badges: {
      appStoreTop: "Download on the",
      appStoreBig: "App Store",
      playTop: "GET IT ON",
      playBig: "Google Play",
    },
    featuresSection: {
      title: "Everything your scout group needs",
      subtitle: "One app that saves time for parents and leaders alike.",
    },
    features: [
      {
        icon: "calendar",
        title: "Event sign-ups",
        desc: "Sign your child up for a trip or camp in a single tap.",
      },
      {
        icon: "check",
        title: "Attendance overview",
        desc: "Leaders and parents instantly see who's coming.",
      },
      {
        icon: "bell",
        title: "Notifications",
        desc: "Get alerts about new events and changes right on your phone.",
      },
      {
        icon: "crown",
        title: "Parents & leaders",
        desc: "One app for the whole group — from parents to leaders.",
      },
    ],
    howSection: {
      title: "Get started in three steps",
      subtitle: "From download to your first sign-up in minutes.",
    },
    steps: [
      { title: "Download Skapka", desc: "Free for iOS and Android." },
      {
        title: "Create an account",
        desc: "Sign up with your email.",
      },
      {
        title: "Wait for approval",
        desc: "Your troop admin approves your registration, then you can sign your kids up for events.",
      },
    ],
    cta: {
      title: "Get Skapka today",
      subtitle: "Free for iOS and Android.",
    },
    footer: {
      tagline: "A scouting app for parents and leaders.",
      privacy: "Privacy",
      contact: "Contact",
      rights: "All rights reserved.",
      createdBy: "Created by",
    },
  },
};
