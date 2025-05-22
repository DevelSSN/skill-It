import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup_screen.dart';
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
      _errorMessage = '';
    });

    try {
      // Call backend to authenticate
      final data = await AuthService.signInWithEmailPassword(email, password);

      final jwt = data['jwt']; // Correct variable name
      final user = data['user'];

      // Store JWT locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', jwt);

      // Navigate to profile screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ProfileScreen()),
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
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
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
