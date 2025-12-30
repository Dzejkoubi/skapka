class LeaderModel {
  final String dependentId;
  final String? patrolId;
  final String groupId;

  LeaderModel({
    required this.dependentId,
    required this.patrolId,
    required this.groupId,
  });

  factory LeaderModel.fromJson(Map<String, dynamic> json) {
    return LeaderModel(
      dependentId: json['dependent_id'] as String,
      patrolId: json['patrol_id'] as String?,
      groupId: json['group_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dependent_id': dependentId,
      'patrol_id': patrolId,
      'group_id': groupId,
    };
  }

  factory LeaderModel.copyWith(
    LeaderModel leader, {
    String? dependentId,
    String? patrolId,
    String? groupId,
  }) {
    return LeaderModel(
      dependentId: dependentId ?? leader.dependentId,
      patrolId: patrolId ?? leader.patrolId,
      groupId: groupId ?? leader.groupId,
    );
  }
}
