import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'apply_page.dart';
import 'details_page.dart';
import 'phone_input_page.dart';
import 'profile_edit_page.dart';
import '../services/auth_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool userSignedIn = false;
  String profileUrl = '';

  final pages = const [HomePage(), SearchPage(), ApplyPage(), DetailsPage()];

  @override
  void initState() {
    super.initState();
    // TODO: Check login state if needed
  }

  Future<void> _handleSignIn() async {
    final result = await AuthService.signInWithGoogle();
    if (result['isNewUser']) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PhoneInputPage()),
      );
    } else {
      setState(() {
        userSignedIn = true;
        profileUrl = result['profilePicture'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill-It'),
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage:
                  userSignedIn
                      ? NetworkImage(profileUrl)
                      : const AssetImage('assets/add_account.png')
                          as ImageProvider,
            ),
            onPressed: () {
              if (userSignedIn) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileEditPage()),
                );
              } else {
                _handleSignIn();
              }
            },
          ),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Apply'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Details'),
        ],
      ),
    );
  }
}
