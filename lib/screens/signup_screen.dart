import 'package:flutter/material.dart';
import '../services/auth_service.dart'; // Assume this handles the backend call

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _profilePhotoController =
      TextEditingController(); // URL or file path for profile photo
  final List<Map<String, String>> _skills =
      []; // List to hold skill information
  bool _loading = false;
  String _errorMessage = '';

  void _handleSignUp() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final profilePhoto = _profilePhotoController.text;

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = "Passwords don't match!";
      });
      return;
    }

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        profilePhoto.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill all the fields.';
      });
      return;
    }

    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    try {
      // Prepare the data to be sent to the backend
      final skills =
          _skills
              .map(
                (skill) => {
                  'skill': skill['skill'],
                  'year_of_proficiency': skill['year_of_proficiency'],
                },
              )
              .toList();

      // Call AuthService to send the sign-up request
      final data = await AuthService.signUp(
        name,
        email,
        password,
        profilePhoto,
        skills,
      );

      // Handle success, maybe navigate to login screen
      Navigator.pop(
        context,
      ); // Assuming you go back to Login Screen after successful sign-up
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to sign up: $e';
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _profilePhotoController,
                decoration: const InputDecoration(
                  labelText: 'Profile Photo URL',
                ),
              ),
              const SizedBox(height: 16),
              // Add Skill List input section
              // Assuming the user can add multiple skills dynamically
              ListView.builder(
                shrinkWrap: true,
                itemCount: _skills.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_skills[index]['skill'] ?? 'Unknown Skill'),
                    subtitle: Text(
                      'Proficiency Year: ${_skills[index]['year_of_proficiency']}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _skills.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _skills.add({
                      'skill': 'Flutter',
                      'year_of_proficiency': '2023', // Example skill
                    });
                  });
                },
                child: const Text("Add Skill"),
              ),
              const SizedBox(height: 24),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: _handleSignUp,
                    child: const Text("Sign Up"),
                  ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
