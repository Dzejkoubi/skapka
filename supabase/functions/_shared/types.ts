

export type SkautisAPI = {
	'UnitAllUnit': {
		req: {
			ID_Login: string;
			ID_Unit: number;
			SearchStredisko?: boolean;
		};
		res: Unit[];
	},
	'PersonAll': {
		req: {
			ID_Login: string;
			ID?: number;
			DisplayName?: string;
			ID_Sex?: string;
			IdentificationCode?: string;
			IdentificationCodeStartsWith?: string;
			FirstName?: string;
			LastName?: string;
			SecurityCode?: string;
			ID_Unit?: number;
			OnlyDirectMember?: boolean;
			ID_FunctionType?: number;
			ID_QualificationType?: number;
			RegistrationNumber?: string;
		},
		res: Person[],
	},
	'PersonDetail': {
		req: {
			ID_Login: string;
			ID: number;
		},
		res: Person;
	},
	'PersonContactAllParents': {
		req: {
			ID_Login: string;
			ID_Person: number;
		},
		res: ParentContact[];
	}
}

export interface Unit {
	ID: number;
	ID_UnitType: string;
	DisplayName: string;
	SortName: string;
	RegistrationNumber: string;
	ID_UnitParent: number | null;
}

export interface Person {
	Birthday?: string | null;
	ID?: number | null;
	ID_Group?: number | null;
	DisplayName: string;
	FirstName: string;
	LastName: string;
	NickName: string;
	ListName: string;
	Note: string;
	Street: string;
	City: string;
	Postcode: string;
	State: string;
	PostalFirstLine: string;
	PostalStreet: string;
	PostalCity: string;
	PostalPostcode: string;
	PostalState: string;
	ID_Sex: string;
	Sex: string;
}

export interface PersonDetail extends Person {
	ID_Login: string;
	DegreeInFrontOf?: string | null;
	DegreeBehind?: string | null;
	SecurityCode?: string | null;
	IdentificationCodeHasPermission: boolean | null;
	FullName?: string | null;
	PostalAddress?: string | null;
	BirthdayYear: number | null;
	IsForeign: boolean | null;
	YearFrom: number | null;
	RegistrationNumber?: string | null;
	ID_User: number | null;
	GenerateSecurityCode: boolean | null;
	OnlyValidate: boolean | null;
	PhotoExtension?: string | null;
	PhotoContent?: Uint8Array | null;
	PhotoUpdate: string | null;
	MaidenName?: string | null;
	ID_PersonType?: string | null;
	PersonType?: string | null;
	Email?: string | null;
	School?: string | null;
	DisplayAdress: boolean | null;
	DisplayBirthday: boolean | null;
	DisplayEducation: boolean | null;
	DisplayEducationSeminary: boolean | null;
	DisplayFunction: boolean | null;
	DisplayMembership: boolean | null;
	DisplayOffer: boolean | null;
	DisplayPostalAdress: boolean | null;
	DisplaySchool: boolean | null;
	DisplayQualification: boolean | null;
	DisplayYearFrom: boolean | null;
	CatalogDisplay: boolean | null;
	CatalogContactCount: number | null;
	ID_PersonContactGa: number | null;
	PersonContactGa?: string | null;
	ID_MemberCard: number | null;
	PhotoX: number | null;
	PhotoY: number | null;
	PhotoSize: number | null;
	IsPostalAuthenticated: boolean | null;
	IsAddressAuthenticated: boolean | null;
	AddressDistrict?: string | null;
	PostalDistrict?: string | null;
	UnitEnrollExtension?: string | null;
	UnitEnroll?: Uint8Array | null;
	RejectDataStorage: boolean | null;
	HasMembership: boolean | null;
	IsLegacyMemberRead: boolean | null;
	ID_PersonOther: number | null;
	HasEnroll: boolean | null;
	Phone?: string | null;
	Name?: string | null;
	ID_PersonPhotoBig: number | null;
	ID_PersonPhotoMedium: number | null;
	ID_PersonPhotoNormal: number | null;
	ID_PersonPhotoSmall: number | null;
	IsForeignAddress: boolean | null;
	ID_UnitEnrollTempFile: number | null;
	EmailParent?: string | null;
	DateParentAgreement: string | null;
	FirstNameParent?: string | null;
	LastNameParent?: string | null;
	NeedParentAgreement: boolean | null;
	IsTwoFactorEnabled: boolean | null;
	TwoFactorEnabled: string | null;
	ID_MembershipApplicationUnaccepted: number | null;
	ParentCode?: string | null;
	IsAdult: boolean | null;
	CanReadPersonBasic: boolean | null;
	Age: number | null;
	HasOldPhoto: boolean | null;
}

export interface ParentContact {
	ID?: number | null;
	ID_Person?: number | null;
	Person: string;
	PersonCivilName: string;
	ID_PersonParent?: number | null;
	ID_PersonPersonParent?: number | null;
	PersonPersonParent: string;
	ID_ContactType: string;
	ContactType: string;
	Value: string;
	DisplayValue: string;
	DisplayIcon: string;
	Icon: string;
	ID_ParentType: string;
	ParentType: string;
}

export type SkautisRequest<T extends keyof SkautisAPI> = SkautisAPI[T]['req'];

export type SkautisResponseData<T extends keyof SkautisAPI> = SkautisAPI[T]['res'];

export type SkautisResponse<T extends keyof SkautisAPI> = {
	d: SkautisResponseData<T>;
}