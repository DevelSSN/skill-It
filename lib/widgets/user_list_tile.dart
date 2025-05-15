import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserListTile extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;

  const UserListTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          user.profilePictureUrl ?? 'https://via.placeholder.com/150',
        ),
      ),
      title: Text(user.name),
      subtitle: Text(user.skills.join(', ')),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
