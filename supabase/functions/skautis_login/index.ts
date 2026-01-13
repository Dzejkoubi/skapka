import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import {
	corsHeaders,
	createBadRequestResponse,
	createErrorResponse,
	createInternalServerErrorResponse,
	createSuccessResponse,
} from "@shared/response.ts";
import { skautisLogin } from "@shared/skautis.ts";

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
		
		const token = await skautisLogin(username, password);

		return createSuccessResponse({
			token: token,
			message: "Login successful",
		});
	} catch (error) {
		return createBadRequestResponse(
			"Invalid request body or connection error",
			String(error),
		);
	}
});
