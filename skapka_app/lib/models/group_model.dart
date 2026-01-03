class GroupModel {
  final String name;
  final int number;
  GroupModel({required this.name, required this.number});

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      name: json['name'] as String,
      number: json['number'] as int,
    );
  }
}
