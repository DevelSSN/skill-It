import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillit/services/api_service.dart';
import 'main_navigation_screen.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen({super.key});

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  final List<Map<String, TextEditingController>> _skillControllers = [];

  @override
  void initState() {
    super.initState();
    _addSkill(); // Start with one skill input
  }

  @override
  void dispose() {
    for (var pair in _skillControllers) {
      pair['skill']?.dispose();
      pair['years']?.dispose();
    }
    super.dispose();
  }

  void _addSkill() {
    setState(() {
      _skillControllers.add({
        'skill': TextEditingController(),
        'years': TextEditingController(),
      });
    });
  }

  void _removeSkill(int index) {
    setState(() {
      _skillControllers[index]['skill']?.dispose();
      _skillControllers[index]['years']?.dispose();
      _skillControllers.removeAt(index);
    });
  }

  Future<void> _submitApplication() async {
    final List<Map<String, dynamic>> skillEntries = [];

    for (var pair in _skillControllers) {
      final skill = pair['skill']?.text.trim() ?? '';
      final yearsStr = pair['years']?.text.trim() ?? '';

      if (skill.isEmpty || yearsStr.isEmpty) continue;

      final years = int.tryParse(yearsStr);
      if (years == null) {
        _showError('Years of proficiency must be a valid number.');
        return;
      }

      skillEntries.add({'skill': skill, 'years': years});
    }

    if (skillEntries.isEmpty) {
      _showError('Please add at least one skill with years of proficiency.');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('jwt');
    if (jwt == null || jwt.isEmpty) {
      _showError('User not authenticated.');
      return;
    }

    final payload = {
      'skills': skillEntries, // Could be adapted to UserModel.skills if needed
      'jwt': jwt,
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/user/apply'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainNavigationScreen(initialIndex: 0),
          ),
        );
      } else {
        _showError('Failed to submit application. Please try again.');
      }
    } catch (e) {
      _showError('Error submitting application: $e');
    }
  }

  void _cancelApplication() {
    Navigator.of(context).pop();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildSkillField(int index) {
    final skillController = _skillControllers[index]['skill']!;
    final yearsController = _skillControllers[index]['years']!;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            controller: skillController,
            decoration: InputDecoration(labelText: 'Skill ${index + 1}'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 1,
          child: TextField(
            controller: yearsController,
            decoration: const InputDecoration(labelText: 'Years'),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.red),
          onPressed: () => _removeSkill(index),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apply')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...List.generate(
              _skillControllers.length,
              (index) => _buildSkillField(index),
            ),
            TextButton.icon(
              onPressed: _addSkill,
              icon: const Icon(Icons.add),
              label: const Text('Add Skill'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitApplication,
              child: const Text('APPLY'),
            ),
            TextButton(
              onPressed: _cancelApplication,
              child: const Text('CANCEL'),
            ),
          ],
        ),
      ),
    );
  }
}
