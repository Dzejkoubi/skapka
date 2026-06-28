"use client";

import { useEffect } from "react";
import { getSupabase } from "@/lib/supabase";
import { useState, type FormEvent } from "react";
import Image from "next/image";

const MIN_LENGTH = 8;
const inputClass =
  "w-full rounded-md border border-border bg-canvas px-4 py-2.5 text-ink outline-none transition focus:border-primary focus:ring-2 focus:ring-primary/30";

export function ResetPasswordForm() {
  const [password, setPassword] = useState("");
  const [confirm, setConfirm] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [done, setDone] = useState(false);

  useEffect(() => {
    (async () => {
      const supabase = getSupabase(); // created here, browser-only
      console.log("Reset landing URL:", window.location.href);

      const url = new URL(window.location.href);
      const tokenHash = url.searchParams.get("token_hash");
      const type = url.searchParams.get("type");
      console.log("token_hash:", tokenHash, "type:", type);

      if (tokenHash && type) {
        const { data, error } = await supabase.auth.verifyOtp({
          type: type as "recovery",
          token_hash: tokenHash,
        });
        if (error) console.error("verifyOtp error:", error.message);
        else console.log("verifyOtp OK:", data.session?.user?.email);
      } else {
        console.warn("No token_hash/type in URL");
      }
    })();
  }, []);

  function handleSubmit(e: FormEvent<HTMLFormElement>) {
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
    // TODO: perform the actual password reset here once Supabase is wired up:
    //   await supabase.auth.updateUser({ password });
    // (The recovery session is established from the token in the email link.)
    setDone(true);
  }

  return (
    <main className="flex min-h-screen items-center justify-center px-5 py-12">
      <div className="w-full max-w-md rounded-xl border border-border bg-surface p-8 shadow-card">
        <div className="flex flex-col items-center text-center">
          <Image
            src="/skapka-logo-yellow.png"
            alt="Skapka"
            width={56}
            height={56}
            className="h-14 w-14"
            priority
          />
          <h1 className="mt-4 font-display text-2xl font-bold">
            Nastavte si nové heslo
          </h1>
          <p className="mt-1 text-sm text-muted">
            Zadejte a potvrďte své nové heslo.
          </p>
        </div>

        {done ? (
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
              <label htmlFor="confirm" className="mb-1 block text-sm font-bold">
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

            {error && <p className="text-sm font-bold text-danger">{error}</p>}

            <button
              type="submit"
              className="w-full rounded-full bg-primary-light px-5 py-2.5 font-bold text-white shadow-soft transition hover:bg-primary-dark"
            >
              Uložit nové heslo
            </button>
          </form>
        )}
      </div>
    </main>
  );
}
