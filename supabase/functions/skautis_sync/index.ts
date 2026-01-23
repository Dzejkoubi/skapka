import {
	corsHeaders,
	createBadRequestResponse,
	createInternalServerErrorResponse,
	createSuccessResponse,
} from "@shared/response.ts";
import { syncMembers, syncUnits } from "@shared/skautis.ts";
import { UNIT_ID } from "@shared/constants.ts";

Deno.serve(async (req) => {

	if(req.method === "OPTIONS") {
		return new Response("ok", { headers: corsHeaders });
	}

	// Only allow POST requests after check for OPTIONS
	if(!req.method || req.method !== "POST") {
		return new Response("Method not allowed", { status: 405 });
	}

	try {
		// const token = await skautisLogin('kraj.vary', 'kvKraj.Web7');
		// console.log('Logged in successfully, token:', token);

		if(!UNIT_ID) {
			return createInternalServerErrorResponse("Unit_ID is not set");
		}

		const url = new URL(req.url);
		const token = url.searchParams.get("token");

		if(!token) {
			return createBadRequestResponse("Skautis token is required");
		}

		const errors: string[] = [];
		errors.push(...await syncUnits(token, UNIT_ID));
		errors.push(...await syncMembers(token, UNIT_ID));

		return createSuccessResponse({
			message: "Sync completed",
			errors,
		});
	} catch (error) {
		return createInternalServerErrorResponse("Sync failed", error);
	}
});
