import { createClient, type SupabaseClient } from "@supabase/supabase-js";

let client: SupabaseClient | undefined;

/**
 * Returns the browser Supabase client, created lazily on first use and reused
 * afterwards. Sharing a single instance avoids the "Multiple GoTrueClient
 * instances detected" warning.
 */
export function getSupabase(): SupabaseClient {
  if (!client) {
    client = createClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY!,
      { auth: { detectSessionInUrl: true, flowType: "pkce" } },
    );
  }
  return client;
}
