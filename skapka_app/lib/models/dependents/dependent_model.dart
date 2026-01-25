import 'package:freezed_annotation/freezed_annotation.dart';

part 'dependent_model.freezed.dart';
part 'dependent_model.g.dart';

enum SexEnum { male, female, other }

@freezed
abstract class DependentModel with _$DependentModel {
  const DependentModel._(); // Required for custom methods/getters

  @JsonSerializable(fieldRename: FieldRename.snake)
  factory DependentModel({
    required String dependentId,
    required bool isLeader,
    required String name,
    required String surname,
    String? nickname,
    DateTime? born,
    required SexEnum sex,
    String? parent1Email,
    String? parent1Phone,
    String? parent2Email,
    String? parent2Phone,
    String? contactEmail,
    String? contactPhone,
    String? troopId,
    String? patrolId,
    required bool isArchived,
    String? secretCode,
    required DateTime createdAt,
    required String groupId,
    required int skautisId,
  }) = _DependentModel;

  //dependent_id: 7cc315ce-4f66-4c4a-8fd0-c3e0432e6ed7,
  //is_leader: true,
  //name: Jakub,
  //surname: Kraus,
  //nickname: Jack,
  //born: 2006-01-01,
  //sex: male,
  //parent1_email: null,
  //parent1_phone: null,
  //parent2_email: null,
  //parent2_phone: null,
  //contact_email: null,
  //contact_phone: null,
  //troop_id: cebdc244-3556-4301-9625-d94cd467a06e,
  //patrol_id: null,
  //is_archived: false,
  //secret_code: 6d0359,
  //created_at: 2025-12-10T13:08:53.578556+00:00,
  //skautis_id: 1
  //group_id: a0e10271-a919-4e9d-91d7-013c0fe6a625,

  factory DependentModel.fromJson(Map<String, dynamic> json) =>
      _$DependentModelFromJson(json);

  bool get is18plus {
    if (born == null) return false;
    final now = DateTime.now();
    int age = now.year - born!.year;
    int month = now.month - born!.month;
    int day = now.day - born!.day;
    if (month < 0 || (month == 0 && day < 0)) {
      age--;
    }
    return age >= 18;
  }
}
