import 'package:flutter/material.dart';

class ContactEditScreen extends StatefulWidget {
  const ContactEditScreen({super.key});

  @override
  State<ContactEditScreen> createState() => _ContactEditScreenState();
}

class _ContactEditScreenState extends State<ContactEditScreen> {
  final _phoneController = TextEditingController();
  final _altEmailController = TextEditingController();

  void _saveContact() {
    // Save to backend (not implemented)
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _altEmailController.dispose();
    super.dispose();
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
