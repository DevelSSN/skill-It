class UserModel {
  final String name;
  final String email;
  final String profilePicture;
  final String phone;
  final List<String> skills;

  UserModel({
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.phone,
    required this.skills,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      phone: json['phone'],
      skills: List<String>.from(json['skills'] ?? []),
    );
  }
}
