import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PhoneInputPage extends StatelessWidget {
  final controller = TextEditingController();

  PhoneInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Phone Number')),
      body: Column(
        children: [
          const Text('Please enter your phone number'),
          TextField(controller: controller, keyboardType: TextInputType.phone),
          ElevatedButton(
            onPressed: () async {
              await http.post(
                Uri.parse('https://your-api.com/api/user/phone'),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({'phone': controller.text}),
              );
              Navigator.pop(context);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
