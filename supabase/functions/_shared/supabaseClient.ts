import { createClient } from "npm:@supabase/supabase-js@2";

export const getSupabaseClient = (req?: Request) => {
  const supabaseUrl = Deno.env.get("SUPABASE_URL") ?? "";
  const supabaseAnonKey = Deno.env.get("SUPABASE_PUBLISHABLE_KEY") ?? "";

  const options = req
    ? {
      global: {
        headers: { Authorization: req.headers.get("Authorization")! },
      },
    }
    : {};

  return createClient(supabaseUrl, supabaseAnonKey, options);
};

export const getSupabaseAdminClient = () => {
  const supabaseUrl = Deno.env.get("SUPABASE_URL") ?? "";
  const supabaseServiceRoleKey = Deno.env.get("SUPABASE_SECRET_KEY") ??
    "";

  return createClient(supabaseUrl, supabaseServiceRoleKey);
};
