import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Column(
        children: [
          const TextField(decoration: InputDecoration(labelText: 'Name')),
          const TextField(decoration: InputDecoration(labelText: 'Skills')),
          ElevatedButton(onPressed: () {}, child: const Text('Save')),
          TextButton(
            onPressed: () async {
              await GoogleSignIn().signOut();
              Navigator.pop(context);
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
