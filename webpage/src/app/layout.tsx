import type { Metadata, Viewport } from "next";
import { Nunito } from "next/font/google";
import "./globals.css";

const nunito = Nunito({
  subsets: ["latin", "latin-ext"],
  variable: "--font-nunito",
  display: "swap",
});

export const metadata: Metadata = {
  title: "Skapka — skautská aplikace pro rodiče a vedoucí",
  description:
    "Skapka spojuje rodiče i vedoucí na jednom místě – přihlašování dětí na akce, přehled účasti a oznámení o novinkách. Zdarma pro iOS i Android.",
  icons: { icon: "/skapka-logo-black", apple: "/skapka-logo-black" },
  openGraph: {
    title: "Skapka — skautská aplikace pro rodiče a vedoucí",
    description:
      "Přihlašování na akce, přehled účasti a oznámení. Zdarma pro iOS i Android.",
    type: "website",
  },
};

export const viewport: Viewport = {
  themeColor: "#f9b200",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html
      lang="cs"
      suppressHydrationWarning
      className={`${nunito.variable} h-full antialiased`}
    >
      <body className="min-h-full bg-canvas font-sans text-ink">
        {children}
      </body>
    </html>
  );
}
