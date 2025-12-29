class AccountModel {
  final String accountId;
  final DateTime createdAt;
  final int rights;
  final String groupId;
  final bool isApproved;
  final String? name;
  final String? surname;

  AccountModel({
    required this.accountId,
    required this.createdAt,
    required this.rights,
    required this.groupId,
    required this.isApproved,
    this.name,
    this.surname,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      accountId: json['account_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      rights: json['rights'] as int? ?? 0,
      groupId: json['group_id'] as String,
      isApproved: json['is_approved'] as bool? ?? false,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
    );
  }
}
