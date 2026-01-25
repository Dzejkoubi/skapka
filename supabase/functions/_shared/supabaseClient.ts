import { createClient } from "supabase";
import { createBadRequestResponse } from "./response.ts";
import { Database } from "../../database.types.ts";

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

  return createClient<Database>(supabaseUrl, supabaseAnonKey, options);
};

export const getSupabaseAdminClient = () => {
  const supabaseUrl = Deno.env.get("SUPABASE_URL") ?? "";
  const supabaseServiceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ??
    "";

  if (!supabaseUrl || !supabaseServiceRoleKey) {
    createBadRequestResponse("Supabase environment variables are not set", 500);
  }

  return createClient<Database>(supabaseUrl, supabaseServiceRoleKey);
};
