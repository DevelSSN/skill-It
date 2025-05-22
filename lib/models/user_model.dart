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
              .map((skillObj) => skillObj['skill']?.toString() ?? '')
              .toList();
    }

    return UserModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      contact: json['contact'] ?? '',
      email: json['email'] ?? '',
      skills: skillNames,
      profilePictureUrl:
          json['profilePictureUrl'] ?? 'https://placehold.co/150x150/png',
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
