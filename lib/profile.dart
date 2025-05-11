import 'package:google_sign_in/google_sign_in.dart';

class Profile {
  late String name;
  late String phoneNumber; // Changed to String to handle phone number formats
  late String email;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile', 'openid'],
    clientId: '',
  );
  Map<String, int> skills = <String, int>{};

  Profile({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.skills,
  });

  Profile of() {
    return Profile(
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      skills: skills,
    );
  }

  Future<Map<String, dynamic>> signIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        print(account.email);
        final GoogleSignInAuthentication auth = await account.authentication;
        name = account.displayName ?? '';
        email = account.email;
        phoneNumber = 'Not Provided'; // Default until provided manually
        return {
          'id': account.id,
          'email': account.email,
          'name': account.displayName,
          'photoUrl': account.photoUrl,
          'idToken': auth.idToken,
          'accessToken': auth.accessToken,
        };
      }
      print('User not signed in');
    } catch (e) {
      print('Error signing in: $e');
    }
    return {};
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
