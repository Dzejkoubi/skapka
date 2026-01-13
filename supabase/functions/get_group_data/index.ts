import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import {
  corsHeaders,
  createBadRequestResponse,
  createErrorResponse,
  createInternalServerErrorResponse,
  createSuccessResponse,
} from "@shared/response.ts";

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", {
      headers: corsHeaders,
    });
  }
  // Only allow GET requests after check for OPTIONS
  if (!req.method || req.method !== "GET") {
    return new Response("Method not allowed", {
      status: 405,
    });
  }
  try {
    const url = new URL(req.url);
    const groupId = url.searchParams.get("groupId");
    const loginToken = url.searchParams.get("loginToken");
    if (!groupId || !loginToken) {
      return createBadRequestResponse("groupId and loginToken are required");
    }
    const skautisApiBaseUrl = Deno.env.get("SKAUTIS_API_BASE_URL");
    const skautisWSApiUrl = Deno.env.get("WS_PATH");
    if (!skautisApiBaseUrl || !skautisWSApiUrl) {
      return createInternalServerErrorResponse(
        "SKAUTIS_API_BASE_URL or WS_PATH is not defined",
      );
    }
    // First get all troops and patrols in the group from SkautIS API UnitAllUnit endpoint
    const { data: groupData, error: groupError } = await fetch(
      `${skautisApiBaseUrl}${skautisWSApiUrl}UnitAllUnit`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          "unitAllUnitInput": {
            "ID_Login": loginToken,
            "ID_Unit": parseInt(groupId),
          },
        }),
      },
    ).then((res) => res.json());
    if (groupError) {
      return createErrorResponse("Error fetching group data", groupError);
    }
    return createSuccessResponse({
      groupData,
    });
  } catch (error) {
    return createBadRequestResponse(
      "Invalid request body or connection error",
      error,
    );
  }
});
