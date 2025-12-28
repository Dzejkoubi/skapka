import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import {
  corsHeaders,
  createErrorResponse,
  createSuccessResponse,
} from "@shared/response.ts";
import { getSupabaseClient } from "@shared/supabaseClient.ts";

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    // Parse variables from the request and initialize the Supabase client
    const body = await req.json();
    const { account_id } = body;
    const supabase = getSupabaseClient(req);

    const { data, error } = await supabase.from("accounts").select(
      "is_approved",
    ).eq("account_id", account_id).single();

    if (error) {
      return createErrorResponse(
        "Failed to fetch account approval status",
        500,
        error,
      );
    }

    if (!data) {
      return createErrorResponse("Account not found", 404);
    }

    return createSuccessResponse({ is_approved: data.is_approved });
  } catch (error) {
    const errorMessage = error instanceof Error
      ? error.message
      : "Internal Server Error";
    return createErrorResponse(errorMessage, 500, error);
  }
});
