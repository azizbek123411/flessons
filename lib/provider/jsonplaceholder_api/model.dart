class UserModel {
  final String id;
  final String name;
  final Map<String, dynamic> data;

  UserModel({
    required this.id,
    required this.name,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      data: json['data'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'data': data,
    };
  }
}
