import { createClient } from "supabase";
import {
  corsHeaders,
  createErrorResponse,
  createSuccessResponse,
} from "@shared/response.ts";

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const body = await req.json().catch(() => null);

    if (!body || !body.account_id) {
      console.error("Missing account_id in request");
      return createErrorResponse("Missing account_id in request body", 400);
    }

    const { account_id } = body;
    console.log(
      `Starting account deletion process for account_id: ${account_id}`,
    );

    const supabaseUrl = Deno.env.get("SUPABASE_URL") ?? "";
    const supabaseServiceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ??
      "";

    if (!supabaseUrl || !supabaseServiceRoleKey) {
      console.error("Missing Supabase environment variables");
      return createErrorResponse("Server configuration error", 500);
    }

    // Initialize Supabase Admin Client
    const supabaseAdmin = createClient(supabaseUrl, supabaseServiceRoleKey);

    // 1. Delete rows from account_dependents
    console.log(`Deleting dependents for account_id: ${account_id}`);
    const { error: dependentsError } = await supabaseAdmin
      .from("account_dependents")
      .delete()
      .eq("account_id", account_id);

    if (dependentsError) {
      console.error("Error deleting account dependents:", dependentsError);
      return createErrorResponse("Failed to delete account dependents", 500);
    }
    console.log("Dependents deleted successfully.");

    // 2. Delete rows from accounts
    console.log(`Deleting account record for account_id: ${account_id}`);
    const { error: accountsError } = await supabaseAdmin
      .from("accounts")
      .delete()
      .eq("account_id", account_id);

    if (accountsError) {
      console.error("Error deleting account record:", accountsError);
      return createErrorResponse("Failed to delete account record", 500);
    }
    console.log("Account record deleted successfully.");

    // 3. Delete user from Supabase Auth
    console.log(
      `Deleting user from Supabase Auth for account_id: ${account_id}`,
    );
    const { error: authError } = await supabaseAdmin.auth.admin.deleteUser(
      account_id,
    );

    if (authError) {
      console.error("Error deleting user from Auth:", authError);
      return createErrorResponse("Failed to delete user from Auth", 500);
    }
    console.log("User deleted from Auth successfully.");

    return createSuccessResponse({
      message: "Account and associated data deleted successfully.",
    });
  } catch (error) {
    console.error("Unexpected error during account deletion:", error);
    return createErrorResponse("Internal Server Error", 500);
  }
});

