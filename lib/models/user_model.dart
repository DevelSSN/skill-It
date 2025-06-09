class UserModel {
  final String id;
  final String name;
  final String contact;
  final String email;
  final List<String> skills;
  final String profilePictureUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.contact,
    required this.email,
    required this.skills,
    required this.profilePictureUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<String> skillNames = [];
    if (json['skills'] != null) {
      skillNames =
          (json['skills'] as List)
              .map(
                (skillObj) => skillObj['skill']?['skillName']?.toString() ?? '',
              )
              .where((skill) => skill.isNotEmpty)
              .toList();
    }

    return UserModel(
      id: json['userId'].toString(),
      name: json['name'] ?? '',
      contact: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      skills: skillNames,
      profilePictureUrl:
          json['profilePhoto'] ?? 'https://placehold.co/150x150/png',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'name': name,
      'phoneNumber': contact,
      'email': email,
      'skills': skills,
      'profilePhoto': profilePictureUrl,
    };
  }
}
