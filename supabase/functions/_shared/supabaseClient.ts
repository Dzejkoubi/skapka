import { createClient } from "npm:@supabase/supabase-js@2";
import { createBadRequestResponse } from "./response.ts";

export const getSupabaseClient = (req?: Request) => {
  const supabaseUrl = Deno.env.get("SUPABASE_URL") ?? "";
  const supabaseAnonKey = Deno.env.get("SUPABASE_ANON_KEY") ?? "";

  if (!supabaseUrl || !supabaseAnonKey) {
    createBadRequestResponse("Supabase environment variables are not set", 500);
  }

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
  const supabaseServiceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ??
    "";

  if (!supabaseUrl || !supabaseServiceRoleKey) {
    createBadRequestResponse("Supabase environment variables are not set", 500);
  }

  return createClient(supabaseUrl, supabaseServiceRoleKey);
};
