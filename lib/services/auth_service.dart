import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_service.dart';

class AuthService {
  static Future<Map<String, dynamic>> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login'), // Assuming POST endpoint for login
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Assuming the backend returns a JSON object with 'jwt' and 'user'
      return json.decode(response.body);
    } else {
      // Handle error response
      throw Exception('Failed to sign in: ${response.statusCode}');
    }
  }

  static Future<String> signUp(
    String name,
    String email,
    String password,
    String profilePhoto,
    String phoneNumber,
    List<Map<String, String?>> skills,
  ) async {
    final response = await http.post(
      Uri.parse(
        '$baseUrl/api/auth/signup',
      ), // Assuming POST endpoint for sign-up
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'profilePhoto': profilePhoto,
        'skills': skills,
      }),
    );

    if (response.statusCode == 201) {
      final body = jsonDecode(response.body);
      final token = body['token'];
      if (token == null) {
        throw Exception("JWT token not found in response");
      }
      return token;
    } else if (response.statusCode == 409) {
      throw Exception("Email already in use");
    } else {
      throw Exception("Failed to sign up (${response.statusCode})");
    }
  }
}
