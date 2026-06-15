class AreaModel {
  final int id;
  final String name;

  AreaModel({required this.id, required this.name});

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      id: json['id'] ?? json['Id'] ?? 0,
      name: json['name'] ?? json['Name'] ?? '',
    );
  }
}
