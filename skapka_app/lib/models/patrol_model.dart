class PatrolModel {
  final String patrolId;
  final String name;
  final String? abbreviation;
  final int number;
  final String? troopId;
  final String? groupId;

  PatrolModel({
    required this.patrolId,
    required this.name,
    this.abbreviation,
    required this.number,
    this.troopId,
    this.groupId,
  });

  factory PatrolModel.fromJson(Map<String, dynamic> json) {
    return PatrolModel(
      patrolId: json['patrol_id'] as String,
      name: json['name'] as String,
      abbreviation: json['abbreviation'] as String?,
      number: json['number'] as int,
      troopId: json['troop_id'] as String?,
      groupId: json['group_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patrol_id': patrolId,
      'name': name,
      'abbreviation': abbreviation,
      'number': number,
      'troop_id': troopId,
      'group_id': groupId,
    };
  }

  factory PatrolModel.copyWith(
    PatrolModel patrol, {
    String? patrolId,
    String? name,
    String? abbreviation,
    int? number,
    String? troopId,
    String? groupId,
  }) {
    return PatrolModel(
      patrolId: patrolId ?? patrol.patrolId,
      name: name ?? patrol.name,
      abbreviation: abbreviation ?? patrol.abbreviation,
      number: number ?? patrol.number,
      troopId: troopId ?? patrol.troopId,
      groupId: groupId ?? patrol.groupId,
    );
  }
}
