import { SKAUTIS_ORGANIZATION_UNIT_API, SKAUTIS_URL } from "./constants.ts";
import { SkautisAPI, SkautisRequest, SkautisResponse, SkautisResponseData } from "./types.ts";

// e.g. "UnitAllUnit" -> "unitAllUnitInput"
function transformOperationToInput(op: string) {
	return `${op[0].toLowerCase() + op.slice(1)}Input`;
}

export async function skautisLogin(username: string, password: string) {

	if (!username || !password) {
		throw new Error("Username and password are required");
	}

	const formData = new URLSearchParams();
	formData.append("__VIEWSTATE", Deno.env.get("VIEW_STATE") || "");
	formData.append("ctl00$Content$txtUserName", username);
	formData.append("ctl00$Content$txtPassword", password);
	// The button name and value to simulate form submission
	formData.append("ctl00$Content$BtnLogin", "Login");

	const loginResponse = await fetch(`${SKAUTIS_URL}/Login/`, {
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
		throw new Error("Authentication failed: No token found in response");
	}

	return tokenMatch[1];
}

export async function skautisRequest<K extends keyof SkautisAPI>(op: K, payload: SkautisRequest<K>): Promise<SkautisResponseData<K>> {	
	const res = await fetch(`${SKAUTIS_ORGANIZATION_UNIT_API}/${op}`, {
		method: "POST",
		headers: {
			"Content-Type": "application/json",
		},
		body: JSON.stringify({
			[transformOperationToInput(op)]: payload,
		}),
	});
	if(!res.ok) {
		throw new Error(`SkautIS API request failed with status ${res.status}`);
	}
	const json = await res.json() as SkautisResponse<K>;
	return json.d;
}

// const units = await skautisRequest('UnitAllUnit', {
// 	ID_Login: '22cbd031-0fa4-4e47-9e70-c026892e5026',
// 	ID_Unit: 25784,
// })

// console.log(units);

// console.log(await skautisLogin('kraj.vary', 'kvKraj.Web7'));
