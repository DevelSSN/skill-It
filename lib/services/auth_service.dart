import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:skillIt/main.dart';
import 'package:skillIt/services/api_service.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile', 'openid'],
  clientId:
      '71081266017-4500lhd48us31ha9h20q3ucfejut9102.apps.googleusercontent.com',
);

class AuthService {
  static Future<Map<String, dynamic>> signInWithGoogle() async {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account == null) return {};

    final GoogleSignInAuthentication auth = await account.authentication;
    final idToken = auth.idToken;

    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/google'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'idToken': idToken}),
    );

    return jsonDecode(response.body);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
