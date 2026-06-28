"use client";

import { useEffect, useRef, useState, type FormEvent } from "react";
import Image from "next/image";
import { getSupabase } from "@/lib/supabase";

const MIN_LENGTH = 8;
const inputClass =
  "w-full rounded-md border border-border bg-canvas px-4 py-2.5 text-ink outline-none transition focus:border-primary focus:ring-2 focus:ring-primary/30";

type LinkStatus = "verifying" | "valid" | "invalid";

export function ResetPasswordForm() {
  const [status, setStatus] = useState<LinkStatus>("verifying");
  const [password, setPassword] = useState("");
  const [confirm, setConfirm] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [done, setDone] = useState(false);
  const verifiedRef = useRef(false);

  useEffect(() => {
    // Guard against React StrictMode running the effect twice in dev: the
    // recovery token is single-use, so a second verifyOtp would always fail
    // and flip a valid link to "invalid".
    if (verifiedRef.current) return;
    verifiedRef.current = true;

    (async () => {
      const supabase = getSupabase(); // created here, browser-only

      const url = new URL(window.location.href);
      const tokenHash = url.searchParams.get("token_hash");
      const type = url.searchParams.get("type");

      if (!tokenHash || !type) {
        setStatus("invalid");
        return;
      }

      // verifyOtp is what establishes the recovery session. If it fails, the
      // link is invalid or expired, so there's no point showing the form.
      const { error: verifyError } = await supabase.auth.verifyOtp({
        type: type as "recovery",
        token_hash: tokenHash,
      });

      setStatus(verifyError ? "invalid" : "valid");
    })();
  }, []);

  async function handleSubmit(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();

    if (password.length < MIN_LENGTH) {
      setError(`Heslo musí mít alespoň ${MIN_LENGTH} znaků.`);
      return;
    }
    if (password !== confirm) {
      setError("Hesla se neshodují.");
      return;
    }

    setError(null);

    const supabase = getSupabase();
    const { error: updateError } = await supabase.auth.updateUser({ password });

    if (updateError) {
      setError(updateError.message);
      return;
    }

    await supabase.auth.signOut(); // invalidate the recovery session so the link can't be reused
    setDone(true);
  }

  return (
    <main className="flex min-h-screen items-center justify-center px-5 py-12">
      <div className="w-full max-w-md rounded-xl border border-border bg-surface p-8 shadow-card">
        <div className="flex flex-col items-center text-center">
          <Image
            src="/skapka-logo-black.png"
            alt="Skapka"
            width={56}
            height={56}
            className="h-14 w-14"
            priority
          />
          <h1 className="mt-4 font-display text-2xl font-bold">
            Nastavte si nové heslo
          </h1>
          {status === "valid" && !done && (
            <p className="mt-1 text-sm text-muted">
              Zadejte a potvrďte své nové heslo.
            </p>
          )}
        </div>

        {status === "verifying" && (
          <p className="mt-8 text-center text-sm text-muted">
            Ověřujeme odkaz…
          </p>
        )}

        {status === "invalid" && (
          <p className="mt-8 rounded-md bg-danger/10 px-4 py-3 text-center text-sm font-bold text-danger">
            Tento odkaz pro obnovení hesla je neplatný nebo jeho platnost
            vypršela. Vyžádejte si v aplikaci nový.
          </p>
        )}

        {status === "valid" &&
          (done ? (
            <p className="mt-8 rounded-md bg-success/10 px-4 py-3 text-center text-sm font-bold text-success-dark">
              Heslo bylo úspěšně změněno. Můžete se vrátit do aplikace.
            </p>
          ) : (
            <form onSubmit={handleSubmit} className="mt-8 space-y-4" noValidate>
              <div>
                <label
                  htmlFor="password"
                  className="mb-1 block text-sm font-bold"
                >
                  Nové heslo
                </label>
                <input
                  id="password"
                  type="password"
                  autoComplete="new-password"
                  required
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className={inputClass}
                />
              </div>

              <div>
                <label
                  htmlFor="confirm"
                  className="mb-1 block text-sm font-bold"
                >
                  Potvrďte nové heslo
                </label>
                <input
                  id="confirm"
                  type="password"
                  autoComplete="new-password"
                  required
                  value={confirm}
                  onChange={(e) => setConfirm(e.target.value)}
                  className={inputClass}
                />
              </div>

              {error && (
                <p className="text-sm font-bold text-danger">{error}</p>
              )}

              <button
                type="submit"
                className="w-full rounded-full bg-primary-light px-5 py-2.5 font-bold text-white shadow-soft transition hover:bg-primary-dark"
              >
                Uložit nové heslo
              </button>
            </form>
          ))}
      </div>
    </main>
  );
}
