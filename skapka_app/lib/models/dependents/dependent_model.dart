import 'package:skapka_app/models/dependents/dependent_notes_model.dart';

enum SexEnum { male, female, other }

class DependentModel {
  final String name;
  final String surname;
  final String? nickname;
  final DateTime? born;
  final SexEnum sex;
  final String? parent1Email;
  final String? parent1Phone;
  final String? parent2Email;
  final String? parent2Phone;
  final String? troopId;
  final String? patrolId;
  final bool isArchived;
  final String secretCode;
  final DateTime createdAt;
  final DependentNotesModel? notes;

  DependentModel({
    required this.name,
    required this.surname,
    this.nickname,
    this.born,
    required this.sex,
    this.parent1Email,
    this.parent1Phone,
    this.parent2Email,
    this.parent2Phone,
    this.troopId,
    this.patrolId,
    required this.isArchived,
    required this.secretCode,
    required this.createdAt,
    this.notes,
  });

  factory DependentModel.fromJson(Map<String, dynamic> json) {
    return DependentModel(
      name: json['name'] as String,
      surname: json['surname'] as String,
      nickname: json['nickname'] as String?,
      born: json['born'] != null
          ? DateTime.parse(json['born'] as String)
          : null,
      sex: SexEnum.values.firstWhere(
        (e) => e.name == json['sex'],
        orElse: () => SexEnum.other,
      ),
      parent1Email: json['parent1_email'] as String?,
      parent1Phone: json['parent1_phone'] as String?,
      parent2Email: json['parent2_email'] as String?,
      parent2Phone: json['parent2_phone'] as String?,
      troopId: json['troop_id'] as String?,
      patrolId: json['patrol_id'] as String?,
      isArchived: json['is_archived'] as bool? ?? false,
      secretCode: json['secret_code'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      notes: json['notes'] != null
          ? DependentNotesModel.fromJson(json['notes'] as Map<String, dynamic>)
          : null,
    );
  }

  DependentModel copyWith({
    String? name,
    String? surname,
    String? nickname,
    DateTime? born,
    SexEnum? sex,
    String? parent1Email,
    String? parent1Phone,
    String? parent2Email,
    String? parent2Phone,
    String? troopId,
    String? patrolId,
    bool? isArchived,
    String? secretCode,
    DateTime? createdAt,
    DependentNotesModel? notes,
  }) {
    return DependentModel(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      nickname: nickname ?? this.nickname,
      born: born ?? this.born,
      sex: sex ?? this.sex,
      parent1Email: parent1Email ?? this.parent1Email,
      parent1Phone: parent1Phone ?? this.parent1Phone,
      parent2Email: parent2Email ?? this.parent2Email,
      parent2Phone: parent2Phone ?? this.parent2Phone,
      troopId: troopId ?? this.troopId,
      patrolId: patrolId ?? this.patrolId,
      isArchived: isArchived ?? this.isArchived,
      secretCode: secretCode ?? this.secretCode,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
    );
  }
}
