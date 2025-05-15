import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:skillIt/services/auth_service.dart';

import 'profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;

  void _handleSignIn() async {
    setState(() => _loading = true);
    Map<String, dynamic> data = await AuthService.signInWithGoogle();
    try {
      final jwt = data['jwt'];
      final user = data['user'];

      // Optionally store JWT (e.g., with shared_preferences)

      // Navigate to ProfileScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) => ProfileScreen(
                name: user['name'],
                email: user['email'],
                photoUrl: user['profilePictureUrl'],
              ),
        ),
      );
    } catch (e) {
      print('Sign-in error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to sign in.')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child:
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
                  icon: Image.asset('assets/google_logo.png', height: 24),
                  label: const Text("Sign in with Google"),
                  onPressed: _handleSignIn,
                ),
      ),
    );
  }
}
