import type { Metadata } from "next";
import { ResetPasswordForm } from "./ResetPasswordForm";

export const metadata: Metadata = {
  title: "Obnovení hesla — Skapka",
  robots: { index: false },
};

export default function ResetPasswordPage() {
  return <ResetPasswordForm />;
}
