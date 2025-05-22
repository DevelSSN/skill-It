import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillit/screens/main_navigation_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final userJson = prefs.getString('user');

    if (token == null || userJson == null) {
      setState(() {
        isLoggedIn = false;
        isLoading = false;
      });
      return;
    }

    try {
      final userMap = jsonDecode(userJson);
      setState(() {
        name = userMap['name'];
        email = userMap['email'];
        photoUrl =
            userMap['profilePhoto'] ?? 'https://placehold.co/150x150/png';
        isLoggedIn = true;
        isLoading = false;
      });
    } catch (e) {
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
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt');
    prefs.remove('user');
    setState(() {
      isLoggedIn = false;
    });
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) => MainNavigationScreen(initialIndex: 3), // 3 = Login tab
      ),
    );
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
