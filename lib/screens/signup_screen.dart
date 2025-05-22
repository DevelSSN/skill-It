import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final _profilePhotoController = TextEditingController();
  final _phoneController =
      TextEditingController(); // <-- added phone controller
  final List<Map<String, String>> _skills = [];
  bool _loading = false;
  String _errorMessage = '';

  void _handleSignUp() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final profilePhoto = _profilePhotoController.text;
    final phoneNumber = _phoneController.text; // <-- get phone number

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = "Passwords don't match!";
      });
      return;
    }

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        profilePhoto.isEmpty ||
        phoneNumber.isEmpty) {
      // <-- check phone number not empty
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
      final skills =
          _skills
              .map(
                (skill) => {
                  'skill': skill['skill'],
                  'year_of_proficiency': skill['year_of_proficiency'],
                },
              )
              .toList();

      final token = await AuthService.signUp(
        name,
        email,
        password,
        profilePhoto,
        phoneNumber,
        skills,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', token);

      Navigator.pop(context);
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
          child: SingleChildScrollView(
            // <-- add scrolling if needed
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
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                // Your skills list and Add Skill button remain unchanged
                // Replace this existing skills ListView + Add Skill button part with below:

                // Dynamic skill + year input fields
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _skills.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Skill',
                              ),
                              onChanged:
                                  (value) => _skills[index]['skill'] = value,
                              controller: TextEditingController(
                                text: _skills[index]['skill'],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Year of Proficiency',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged:
                                  (value) =>
                                      _skills[index]['year_of_proficiency'] =
                                          value,
                              controller: TextEditingController(
                                text: _skills[index]['year_of_proficiency'],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _skills.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),

                TextButton(
                  onPressed: () {
                    setState(() {
                      _skills.add({'skill': '', 'year_of_proficiency': ''});
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
      ),
    );
  }
}
