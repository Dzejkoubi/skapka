import 'package:skapka_app/models/dependents/dependent_model.dart';

class LeaderDependentModel extends DependentModel {
  final List<String>? leaderOfPatrolId;

  LeaderDependentModel({
    required DependentModel dependent,
    this.leaderOfPatrolId,
  }) : super(
         dependentId: dependent.dependentId,
         name: dependent.name,
         surname: dependent.surname,
         nickname: dependent.nickname,
         born: dependent.born,
         sex: dependent.sex,
         parent1Email: dependent.parent1Email,
         parent1Phone: dependent.parent1Phone,
         parent2Email: dependent.parent2Email,
         parent2Phone: dependent.parent2Phone,
         contactEmail: dependent.contactEmail,
         contactPhone: dependent.contactPhone,
         groupId: dependent.groupId,
         troopId: dependent.troopId,
         patrolId: dependent.patrolId,
         isArchived: dependent.isArchived,
         secretCode: dependent.secretCode,
         createdAt: dependent.createdAt,
         notes: dependent.notes,
       );
}
