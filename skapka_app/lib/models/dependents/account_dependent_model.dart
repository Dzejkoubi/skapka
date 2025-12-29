import 'package:skapka_app/models/dependents/dependent_model.dart';

class AccountDependentModel {
  final String dependentId;
  final bool isMainDependent;
  final DependentModel? dependentDetails;

  AccountDependentModel({
    required this.dependentId,
    required this.isMainDependent,
    this.dependentDetails,
  });

  factory AccountDependentModel.fromJson(Map<String, dynamic> json) {
    return AccountDependentModel(
      dependentId: json["dependent_id"] as String,
      isMainDependent: json["is_main_dependent"] as bool? ?? false,
      dependentDetails: json["dependent_details"] != null
          ? DependentModel.fromJson(
              json["dependent_details"] as Map<String, dynamic>,
            )
          : null,
    );
  }

  AccountDependentModel copyWith({
    String? dependentId,
    bool? isMainDependent,
    DependentModel? dependentDetails,
  }) {
    return AccountDependentModel(
      dependentId: dependentId ?? this.dependentId,
      isMainDependent: isMainDependent ?? this.isMainDependent,
      dependentDetails: dependentDetails ?? this.dependentDetails,
    );
  }
}
