import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String? name;
  final String? email;
  final String? photoUrl;

  const ProfileScreen({super.key, this.name, this.email, this.photoUrl});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String name;
  late String email;
  late String photoUrl;

  @override
  void initState() {
    super.initState();
    // Fallbacks in case info is not passed
    name = widget.name ?? 'Unknown';
    email = widget.email ?? 'No Email';
    photoUrl = widget.photoUrl ?? 'https://via.placeholder.com/150';
  }

  void _editContact() {
    Navigator.pushNamed(context, '/contact-edit');
  }

  void _logout() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(radius: 50, backgroundImage: NetworkImage(photoUrl)),
              const SizedBox(height: 16),
              Text(
                name,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _editContact,
                child: const Text('Edit Contact Info'),
              ),
              const SizedBox(height: 8),
              TextButton(onPressed: _logout, child: const Text('Logout')),
            ],
          ),
        ),
      ),
    );
  }
}
