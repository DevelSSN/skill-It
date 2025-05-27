import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

const String baseUrl = "https://qlppxbkef898.share.zrok.io";

class ApiService {
  static Future<UserModel?> fetchUser(String id) async {
    final res = await http.get(Uri.parse('$baseUrl/api/user/$id'));
    if (res.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(res.body));
    }
    return null;
  }

  static Future<void> updatePhone(String email, String phone) async {
    await http.post(
      Uri.parse('$baseUrl/api/user/phone'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'phone': phone}),
    );
  }
}
