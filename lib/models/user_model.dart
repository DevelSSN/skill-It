class UserModel {
  final String id;
  final String name;
  final String contact;
  final String email;
  final List<String> skills;
  final String? profilePictureUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.contact,
    required this.email,
    required this.skills,
    this.profilePictureUrl,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      contact: json['contact'] ?? '',
      email: json['email'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
      profilePictureUrl: json['profilePictureUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'email': email,
      'skills': skills,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
