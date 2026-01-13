import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import {
	corsHeaders,
	createBadRequestResponse,
	createErrorResponse,
	createInternalServerErrorResponse,
	createSuccessResponse,
} from "@shared/response.ts";
import { skautisRequest } from "@shared/skautis.ts";

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

		const units = await skautisRequest('UnitAllUnit', {
			ID_Login: loginToken,
			ID_Unit: parseInt(groupId),
		})

		// if (groupError) {
		// 	return createErrorResponse("Error fetching group data", groupError);
		// }
		return createSuccessResponse({
			units,
		});
	} catch (error) {
		return createBadRequestResponse(
			"Invalid request body or connection error",
			error,
		);
	}
});
