import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/user_list_tile.dart';

class HireScreen extends StatelessWidget {
  const HireScreen({super.key});

  final List<UserModel> users = const [
    UserModel(
      id: '1',
      name: 'Alice',
      email: 'alice@mail.com',
      contact: '1234567890',
      skills: ['Flutter'],
    ),
    UserModel(
      id: '2',
      name: 'Bob',
      email: 'bob@mail.com',
      contact: '9876543210',
      skills: ['Java'],
    ),
  ];

  void _navigateToDetail(BuildContext context, UserModel user) {
    Navigator.pushNamed(context, '/user-detail', arguments: user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hire')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return UserListTile(
            user: user,
            onTap: () => _navigateToDetail(context, user),
          );
        },
      ),
    );
  }
}
