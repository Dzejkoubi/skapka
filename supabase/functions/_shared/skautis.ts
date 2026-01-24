import { SKAUTIS_LOGIN_VIEWSTATE, SKAUTIS_ORGANIZATION_UNIT_API, SKAUTIS_URL } from "./constants.ts";
import { getSupabaseAdminClient } from "./supabaseClient.ts";
import { ParentContact, PersonDetail, SkautisAPI, SkautisRequest, SkautisResponse, SkautisResponseData, Unit, Membership } from "./types.ts";

// e.g. "UnitAllUnit" -> "unitAllUnitInput"
function transformOperationToInput(op: string) {
	return `${op[0].toLowerCase() + op.slice(1)}Input`;
}

function parseRegistrationNumber(registrationNumber: string): number {
	const part = registrationNumber.split('.').at(-1);
	return part ? parseInt(part) : parseInt(registrationNumber);
}

function parseSex(sexStr: string): 'male' | 'female' | 'other' {
	if(sexStr === 'male' || sexStr === 'female')
		return sexStr;
	return 'other';
}

function parseDate(dateStr: string): Date {
	const str = /\/Date\((-?\d+)\)\//.exec(dateStr)?.[1];
	return str ? new Date(parseInt(str)) : new Date(dateStr);
}

export async function skautisLogin(username: string, password: string) {

	if (!username || !password) {
		throw new Error("Username and password are required");
	}

	const formData = new URLSearchParams();
	formData.append("__VIEWSTATE", SKAUTIS_LOGIN_VIEWSTATE);
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
		throw new Error(`SkautIS API request '${op}' failed with status ${res.status}`);
	}
	const json = await res.json() as SkautisResponse<K>;
	return json.d;
}

// Creates a tree structure of units from Skautis data: groups -> troops -> patrols
// Also returns an array of errors encountered during processing
function createUnitTree(units: Unit[]) {

	const groups: {
		name: string;
		group_id?: string;
		skautis_id: number;
		number: number;
		troops: {
			name: string;
			troop_id?: string;
			skautis_id: number;
			number: number;
			patrols: {
				name: string;
				skautis_id: number;
				number: number;
			}[];
		}[];
	}[] = [];

	const errors: string[] = [];

	for(const group of units.filter(u => u.ID_UnitType === 'stredisko')) {
		groups.push({
			name: group.DisplayName,
			skautis_id: group.ID,
			//TODO: column should be changed to string
			number: parseRegistrationNumber(group.RegistrationNumber),
			troops: [],
		});
	}

	for(const troop of units.filter(u => u.ID_UnitType === 'oddil')) {
		const group = groups.find(g => g.skautis_id === troop.ID_UnitParent);
		if(!group) {
			errors.push(`Parent unit not found for troop '${troop.DisplayName}', ID: ${troop.ID}.`);
			continue;
		}
		group.troops.push({
			name: troop.DisplayName,
			skautis_id: troop.ID,
			//TODO: column should be changed to string
			number: parseRegistrationNumber(troop.RegistrationNumber),
			patrols: [],
		});
	}

	for(const patrol of units.filter(u => u.ID_UnitType === 'druzina')) {
		//O(n^2) but number of units should be small
		const group = groups.find(g =>
			g.troops.find(t =>
				t.skautis_id === patrol.ID_UnitParent)
		);
		const troop = group?.troops.find(t => t.skautis_id === patrol.ID_UnitParent);
		if(!troop) {
			errors.push(`Parent unit not found for patrol '${patrol.DisplayName}', ID: ${patrol.ID}.`);
			continue;
		}
		troop.patrols.push({
			name: patrol.DisplayName,
			skautis_id: patrol.ID,
			//TODO: column should be changed to string
			number: parseRegistrationNumber(patrol.RegistrationNumber),
		});
	}

	return {
		groups,
		errors
	};
}

export async function syncUnits(token: string, unitId: number) {

	const errors: string[] = [];

	const supabase = getSupabaseAdminClient();

	//this will throw on error and should be handled by upstream function
	const units = await skautisRequest('UnitAllUnit', {
		ID_Login: token,
		ID_Unit: unitId,
	});

	const { groups: groupsSkautis, errors: errorsSkautis } = createUnitTree(units);

	errors.push(...errorsSkautis);

	const { data: groupsDb, error: groupsError } = await supabase
		.from('groups')
		.select();
	
	const { data: troopsDb, error: troopsError } = await supabase
		.from('troops')
		.select();
	
	const { data: patrolsDb, error: patrolsError } = await supabase
		.from('patrols')
		.select();
	
	if(groupsError) errors.push(`Fetching groups from database failed: ${groupsError.message}`);
	if(troopsError) errors.push(`Fetching troops from database failed: ${troopsError.message}`);
	if(patrolsError) errors.push(`Fetching patrols from database failed: ${patrolsError.message}`);
	
	if(groupsDb === null || troopsDb === null || patrolsDb === null) {
		errors.forEach(e => console.warn(e));
		console.error('Error fetching data from database. Aborting sync.', groupsError, troopsError, patrolsError);
		return errors;
	}

	for(const group of groupsSkautis) {

		let groupDb = groupsDb.find(g => g.skautis_id === group.skautis_id);

		if(!groupDb) {
			console.log(`Inserting group '${group.name}', ID: ${group.skautis_id} into database`);
			groupDb = {
				name: group.name,
				skautis_id: group.skautis_id,
				number: group.number,
				group_id: crypto.randomUUID()
			};
			const { error } = await supabase
				.from('groups')
				.insert(groupDb);
			
			if(error)
				errors.push(`Inserting group '${group.name}', ID: ${group.skautis_id} into database failed: '${error.message}'`);
		}
		else {
			console.log(`Updating group '${group.name}', ID: ${group.skautis_id} in database`);
			//TODO: compare data before updating
			const { error } = await supabase
				.from('groups')
				.update({
					name: group.name,
					number: group.number,
				})
				.eq('skautis_id', group.skautis_id);
			
			if(error)
				errors.push(`Updating group '${group.name}', ID: ${group.skautis_id} in database failed: '${error.message}'`);
		}
		
		for(const troop of group.troops) {

			let troopDb = troopsDb.find(t => t.skautis_id === troop.skautis_id);

			if(!troopDb) {
				console.log(`Inserting troop '${troop.name}', ID: ${troop.skautis_id} into database`);
				troopDb = {
					troop_id: crypto.randomUUID(),
					name: troop.name,
					skautis_id: troop.skautis_id,
					number: troop.number,
					group_id: groupDb.group_id,
				};
				const { error } = await supabase
					.from('troops')
					.insert(troopDb);
				
				if(error)
					errors.push(`Inserting troop '${troop.name}', ID: ${troop.skautis_id} into database failed: '${error.message}'`);
			}
			else {
				console.log(`Updating troop '${troop.name}', ID: ${troop.skautis_id} in database`);
				//TODO: compare data before updating
				const { error } = await supabase
					.from('troops')
					.update({
						name: troop.name,
						number: troop.number,
						group_id: groupDb.group_id,
					})
					.eq('skautis_id', troop.skautis_id);
				
				if(error)
					errors.push(`Updating troop '${troop.name}', ID: ${troop.skautis_id} in database failed: '${error.message}'`);
			}

			for(const patrol of troop.patrols) {

				const patrolDb = patrolsDb.find(p => p.skautis_id === patrol.skautis_id);

				if(!patrolDb) {
					console.log(`Inserting patrol '${patrol.name}', ID: ${patrol.skautis_id} into database`);
					const { error } = await supabase
						.from('patrols')
						.insert({
							skautis_id: patrol.skautis_id,
							name: patrol.name,
							abbreviation: '',
							troop_id: troopDb.troop_id,
							group_id: groupDb.group_id,
						});
					
					if(error)
						errors.push(`Inserting patrol '${patrol.name}', ID: ${patrol.skautis_id} into database failed: '${error.message}'`);
				}
				else {
					console.log(`Updating patrol '${patrol.name}', ID: ${patrol.skautis_id} in database`);
					//TODO: compare data before updating
					const { error } = await supabase
						.from('patrols')
						.update({
							name: patrol.name,
							abbreviation: patrolDb.abbreviation,
							troop_id: troopDb.troop_id,
							group_id: groupDb.group_id,
						})
						.eq('skautis_id', patrol.skautis_id);
					
					if(error)
						errors.push(`Updating patrol '${patrol.name}', ID: ${patrol.skautis_id} in database failed: '${error.message}'`);
				}
			}
		}
		

		// switch(unit.ID_UnitType) {
		// 	case 'stredisko': {

		// 		const { data, error } = await supabase
		// 			.from('groups')
		// 			.select()
		// 			.eq('skautis_id', unit.ID)
		// 			.single();
				
		// 		if(!data) {
		// 			console.log('Inserting stredisko', unit.ID, unit.DisplayName);
		// 			const { error } = await supabase
		// 				.from('groups')
		// 				.insert({
		// 					name: unit.DisplayName,
		// 					skautis_id: unit.ID,
		// 					//TODO: column should be changed to string
		// 					number: parseInt(unit.RegistrationNumber),
		// 				});
		// 		}
		// 		else if(!objectCompare(data, unit)) {
		// 			console.log('Updating stredisko', unit.ID, unit.DisplayName);
		// 			// const { error: updateError } = await supabase
		// 			// 	.from('groups')
		// 			// 	.update({
		// 			// 		skautis_data: unit,
		// 			// 	})
		// 			// 	.eq('skautis_id', unit.ID);
		// 		}
				
		// 		break;
		// 	}
		// 	case 'oddil': {
				
		// 		const { data, error } = await supabase
		// 			.from('troops')
		// 			.select()
		// 			.eq('skautis_id', unit.ID)
		// 			.single();
				
		// 		if(!data) {
		// 			console.log('Inserting oddil', unit.ID, unit.DisplayName);
		// 			const { error } = await supabase
		// 				.from('troops')
		// 				.insert({
		// 					name: unit.DisplayName,
		// 					skautis_id: unit.ID,
		// 					number: parseInt(unit.RegistrationNumber),
		// 					group_id: unit.ParentID,
		// 				});
		// 		}
				
		// 		break;
		// 	}
		// 	case 'druzina':
		// }
	}
	errors.forEach(e => console.warn(e));
	return errors;
}


async function getParentUnits(unitId: number): Promise<{
	patrol_id: string | null;
	troop_id: string | null;
	group_id: string | null;
}> {

	const supabase = getSupabaseAdminClient();

	const { data: patrol } = await supabase
		.from('patrols')
		.select()
		.eq('skautis_id', unitId)
		.single();
	
	if(patrol) {
		return {
			patrol_id: patrol.patrol_id,
			troop_id: patrol.troop_id,
			group_id: patrol.group_id,
		}
	}

	const { data: troop } = await supabase
		.from('troops')
		.select()
		.eq('skautis_id', unitId)
		.single();
	
	if(troop) {
		return {
			patrol_id: null,
			troop_id: troop.troop_id,
			group_id: troop.group_id,
		}
	}

	const { data: group } = await supabase
		.from('groups')
		.select()
		.eq('skautis_id', unitId)
		.single();
	
	if(group) {
		return {
			patrol_id: null,
			troop_id: null,
			group_id: group.group_id,
		}
	}

	return {
		patrol_id: null,
		troop_id: null,
		group_id: null,
	};
}


function getParentsContacts(contacts: ParentContact[]): {
	email_father?: string;
	phone_father?: string;
	email_mother?: string;
	phone_mother?: string;
} {

	const contactResult = {
		email_father: contacts.find(c =>
			c.ID_ContactType === 'email_hlavni' && c.ID_ParentType === 'father')?.Value,
		phone_father: contacts.find(c =>
			c.ID_ContactType === 'telefon_hlavni' && c.ID_ParentType === 'father')?.Value,
		email_mother: contacts.find(c =>
			c.ID_ContactType === 'email_hlavni' && c.ID_ParentType === 'mother')?.Value,
		phone_mother: contacts.find(c =>
			c.ID_ContactType === 'telefon_hlavni' && c.ID_ParentType === 'mother')?.Value,
	}

	if(!contactResult.email_father && !contactResult.email_mother) {
		//case for ID_ParentType = 'other'
		const emailAny = contacts.find(c =>
			c.ID_ContactType === 'email_hlavni')?.Value;
		contactResult.email_father = emailAny;
	}

	if(!contactResult.phone_father && !contactResult.phone_mother) {
		//case for ID_ParentType = 'other'
		const phoneAny = contacts.find(c =>
			c.ID_ContactType === 'telefon_hlavni')?.Value;
		contactResult.phone_father = phoneAny;
	}

	return contactResult;
}

function isLeader(membershipCategory: string): boolean {
	return membershipCategory === 'rover' ||
		membershipCategory === 'ranger' ||
		membershipCategory === 'dospely';
}

export async function syncMembers(token: string, unitId: number) {

	const errors: string[] = [];

	const supabase = getSupabaseAdminClient();

	let members: Membership[];
	try {
		members = await skautisRequest('MembershipAll', {
			ID_Login: token,
			ID_Unit: unitId,
			ShowLowerUnits: true,
		});
	} catch(error) {
		errors.push(`Error: fetching members from SkautIS failed: '${error instanceof Error ? error.message : String(error)}'`);
		errors.forEach(e => console.warn(e));
		return errors;
	}

	const { data: membersDb, error: membersDbError } = await supabase
		.from('dependents')
		.select();
	
	if(membersDbError)
		errors.push(`Error: fetching members from database failed: '${membersDbError.message}'`);

	for(const member of members) {

		if(!member.ID_Person) {
			errors.push(`Warn: Membership ${member.ID} has no associated person.`);
			continue;
		}

		let personDetail: PersonDetail;
		let personContacts: ParentContact[] = [];

		try {
			personDetail = await skautisRequest('PersonDetail', {
				ID_Login: token,
				ID: member.ID_Person,
			});
		} catch(error) {
			errors.push(`Error: Fetching person details for member '${member.ID_Person}', ID: ${member.Person} failed: '${error instanceof Error ? error.message : String(error)}'. This member will be skipped.`);
			continue;
		}

		try {
			// the API is annoying and instead of returning an empty array 
			// if the person has no contacts, it fails with generic error message
			personContacts = await skautisRequest('PersonContactAllParent', {
				ID_Login: token,
				ID_Person: member.ID_Person,
			});
		} catch (_) {
			errors.push(`Warn: Fetching parents contacts for person '${member.Person}', ID: ${member.ID_Person} failed.`);
		}

		const units = member.ID_Unit ? await getParentUnits(member.ID_Unit) : {
			patrol_id: null,
			troop_id: null,
			group_id: null,
		};

		if(!units.group_id) {
			errors.push(`Error: Could not determine group for member '${personDetail.DisplayName}', ID: ${personDetail.ID}. This member will be skipped.`);
			continue;
		}

		const contacts = getParentsContacts(personContacts);

		const memberDb = membersDb?.find(d => d.skautis_id === member.ID_Person);

		const dependent = {
			skautis_id: member.ID_Person,
			name: personDetail.FirstName || memberDb?.name || '',
			surname: personDetail.LastName || memberDb?.surname || '',
			nickname: personDetail.NickName || memberDb?.nickname || null,
			born: personDetail.Birthday ? parseDate(personDetail.Birthday).toISOString() : (memberDb?.born || null),
			sex: parseSex(personDetail.ID_Sex),//maybe not necessary to parse

			//maybe parent1 and parent2 should be renamed
			parent1_email: contacts.email_father || memberDb?.parent1_email || null,
			parent1_phone: contacts.phone_father || memberDb?.parent1_phone || null,
			parent2_email: contacts.email_mother || memberDb?.parent2_email || null,
			parent2_phone: contacts.phone_mother || memberDb?.parent2_phone || null,

			contact_email: personDetail.Email || memberDb?.contact_email || null,
			contact_phone: personDetail.Phone || memberDb?.contact_phone || null,

			group_id: units.group_id,
			troop_id: units.troop_id || memberDb?.troop_id || null,
			patrol_id: units.patrol_id || memberDb?.patrol_id || null,

			//membership types: 'radne', 'hostovani', 'neclen', 'cestne' (member.ID_MembershipType != 'radne')
			is_archived: memberDb?.is_archived || false,
			//membership categories: 'benjaminek', 'vlce', 'svetluska', 'skaut', 'skautka', 'rover', 'ranger', 'dospely', 'ostatni'
			//todo: add option to determine leaders automatically to config
			is_leader: isLeader(member.ID_MembershipCategory || '') || memberDb?.is_leader || false,

			created_at: memberDb?.created_at || new Date().toISOString(),
		}

		if(!memberDb) {
			console.log(`Inserting dependent '${personDetail.DisplayName}', ID: ${personDetail.ID} into database.`);
			const { error } = await supabase
				.from('dependents')
				.insert(dependent);
			
			if(error)
				errors.push(`Inserting dependent ${personDetail.DisplayName}, ID: ${personDetail.ID} into database failed: '${error.message}'`);
		}
		else {
			console.log(`Updating dependent '${personDetail.DisplayName}', ID: ${personDetail.ID} in database.`);
			//TODO: compare data before updating
			const { error } = await supabase
				.from('dependents')
				.update(dependent)
				.eq('skautis_id', dependent.skautis_id);
			
			if(error)
				errors.push(`Updating dependent ${personDetail.DisplayName}, ID: ${personDetail.ID} in database failed: '${error.message}'`);
		}
	}

	membersDb?.filter(m =>
			!m.is_archived && !members.find(mem => mem.ID_Person === m.skautis_id))
		.forEach(async (removedMember) => {
			console.log(`Archiving dependent '${removedMember.name} ${removedMember.surname}', ID: ${removedMember.skautis_id}`);
			const { error } = await supabase
				.from('dependents')
				.update({
					is_archived: true,
				})
				.eq('skautis_id', removedMember.skautis_id);
			
			if(error)
				errors.push(`Archiving dependent '${removedMember.name} ${removedMember.surname}', ID: ${removedMember.skautis_id} in database failed: '${error.message}'`);
	});

	errors.forEach(e => console.warn(e));
	return errors;
}

// const units = await skautisRequest('UnitAllUnit', {
// 	ID_Login: '22cbd031-0fa4-4e47-9e70-c026892e5026',
// 	ID_Unit: 25784,
// })

// console.log(units);

// console.log(await skautisLogin('kraj.vary', 'kvKraj.Web7'));
