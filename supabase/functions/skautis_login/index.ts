import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import {
  corsHeaders,
  createBadRequestResponse,
  createErrorResponse,
  createInternalServerErrorResponse,
  createSuccessResponse,
} from "@shared/response.ts";

console.log("Function started executing");

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  // Only allow GET requests after check for OPTIONS
  if (!req.method || req.method !== "GET") {
    return new Response("Method not allowed", { status: 405 });
  }

  try {
    const url = new URL(req.url);
    const username = url.searchParams.get("username");
    const password = url.searchParams.get("password");

    if (!username || !password) {
      return createBadRequestResponse("Username and password are required");
    }
    const skautisApiBaseUrl = Deno.env.get("SKAUTIS_API_BASE_URL");

    if (!skautisApiBaseUrl) {
      return createInternalServerErrorResponse(
        "SKAUTIS_API_BASE_URL is not defined",
      );
    }

    const formData = new URLSearchParams();
    formData.append("__VIEWSTATE", Deno.env.get("VIEW_STATE") || "");
    formData.append("ctl00$Content$txtUserName", username);
    formData.append("ctl00$Content$txtPassword", password);
    // The button name and value to simulate form submission
    formData.append("ctl00$Content$BtnLogin", "Login");

    const loginResponse = await fetch(`${skautisApiBaseUrl}Login/`, {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: formData,
    });

    const htmlText = await loginResponse.text();

    const tokenMatch = htmlText.match(
      /name="skautIS_Token"[^>]*value="([^"]+)"/,
    );

    if (!tokenMatch) {
      return createErrorResponse(
        "Authentication failed: No token found in response",
        401,
      );
    }

    return createSuccessResponse({
      token: tokenMatch[1],
      message: "Login successful",
    });
  } catch (error) {
    return createBadRequestResponse(
      "Invalid request body or connection error",
      error,
    );
  }
});
