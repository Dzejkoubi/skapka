import Image from "next/image";
import Link from "next/link";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Skapka — už brzy",
  robots: { index: false },
};

export default function AppPage() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center gap-6 px-5 text-center">
      <Image
        src="/skapka-logo-black.png"
        alt="Skapka"
        width={64}
        height={64}
        className="h-16 w-16"
        priority
      />
      <div>
        <h1 className="font-display text-4xl font-bold">Už brzy</h1>
        <p className="mt-2 text-muted">
          Na této části webu pracujeme. Brzy ji spustíme.
        </p>
      </div>
      <Link
        href="/"
        className="rounded-full bg-primary-light px-5 py-2.5 text-sm font-bold text-white shadow-soft transition hover:bg-primary-dark"
      >
        Zpět na úvod
      </Link>
    </main>
  );
}
