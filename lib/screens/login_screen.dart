import 'package:flutter/material.dart';
import 'signup_screen.dart'; // Import the SignUpScreen
import '../services/auth_service.dart';
import 'profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String _errorMessage = '';

  void _handleSignIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Email and password cannot be empty.';
      });
      return;
    }

    setState(() {
      _loading = true;
      _errorMessage = ''; // Reset error message
    });

    try {
      // Sending POST request to the Spring Boot backend for authentication
      final data = await AuthService.signInWithEmailPassword(email, password);

      final jwt = data['jwt']; // Assuming your backend returns a JWT token
      final user = data['user']; // Assuming user details are returned

      // Optionally, store JWT (e.g., using shared_preferences)

      // Navigate to ProfileScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) => ProfileScreen(
                name: user['name'],
                email: user['email'],
                photoUrl:
                    user['profilePictureUrl'] ?? '', // Ensure it's not null
              ),
        ),
      );
    } catch (e) {
      print('Sign-in error: $e');
      setState(() {
        _errorMessage = 'Failed to sign in. Please check your credentials.';
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: _handleSignIn,
                    child: const Text('Sign in'),
                  ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              // Link to Sign Up Page
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                  );
                },
                child: const Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
