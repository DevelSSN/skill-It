import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final storage = const FlutterSecureStorage();

  String? name;
  String? email;
  String? photoUrl;
  bool isLoading = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final token = await storage.read(key: 'jwt');
    if (token == null) {
      setState(() {
        isLoggedIn = false;
        isLoading = false;
      });
      return;
    }

    final response = await http.get(
      Uri.parse('http://<YOUR_BACKEND_URL>/api/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        name = data['name'];
        email = data['email'];
        photoUrl = data['profilePhoto'] ?? 'https://placehold.co/150x150/png';
        isLoggedIn = true;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoggedIn = false;
        isLoading = false;
      });
    }
  }

  void _editContact() {
    Navigator.pushNamed(context, '/contact-edit');
  }

  void _logout() async {
    await storage.delete(key: 'jwt');
    setState(() {
      isLoggedIn = false;
    });
  }

  void _goToLogin() {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child:
              isLoggedIn
                  ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(photoUrl!),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        name ?? '',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        email ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _editContact,
                        child: const Text('Edit Contact Info'),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: _logout,
                        child: const Text('Logout'),
                      ),
                    ],
                  )
                  : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'You are not signed in.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _goToLogin,
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
