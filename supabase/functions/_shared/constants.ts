

export const SKAUTIS_URL = Deno.env.get('SKAUTIS_API_BASE_URL') ?? '';
export const SKAUTIS_ORGANIZATION_UNIT_API = SKAUTIS_URL + '/JunakWebservice/OrganizationUnit.asmx';
