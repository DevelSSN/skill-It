import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ContactEditScreen extends StatefulWidget {
  final UserModel user;

  const ContactEditScreen({super.key, required this.user});

  @override
  State<ContactEditScreen> createState() => _ContactEditScreenState();
}

class _ContactEditScreenState extends State<ContactEditScreen> {
  late TextEditingController _phoneController;
  late TextEditingController _altEmailController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.user.contact);
    _altEmailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _altEmailController.dispose();
    super.dispose();
  }

  void _saveContact() {
    final updatedUser = UserModel(
      id: widget.user.id,
      name: widget.user.name,
      contact: _phoneController.text.trim(),
      email: _altEmailController.text.trim(),
      skills: widget.user.skills,
      profilePictureUrl: widget.user.profilePictureUrl,
    );

    // TODO: Save updatedUser to backend
    // e.g., ApiService.updateUser(updatedUser)

    Navigator.pop(context, updatedUser); // You could return the updated user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Contact Info')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: _altEmailController,
              decoration: const InputDecoration(labelText: 'Alt Email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _saveContact, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
