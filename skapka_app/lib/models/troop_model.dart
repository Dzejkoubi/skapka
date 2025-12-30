class TroopModel {
  final String troopId;
  final String name;
  final int number;
  final String? groupId;

  TroopModel({
    required this.troopId,
    required this.name,
    required this.number,
    this.groupId,
  });

  factory TroopModel.fromJson(Map<String, dynamic> json) {
    return TroopModel(
      troopId: json['troop_id'] as String,
      name: json['name'] as String,
      number: json['number'] as int,
      groupId: json['group_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'troop_id': troopId,
      'name': name,
      'number': number,
      'group_id': groupId,
    };
  }

  factory TroopModel.copyWith(
    TroopModel troop, {
    String? troopId,
    String? name,
    int? number,
    String? groupId,
  }) {
    return TroopModel(
      troopId: troopId ?? troop.troopId,
      name: name ?? troop.name,
      number: number ?? troop.number,
      groupId: groupId ?? troop.groupId,
    );
  }
}
