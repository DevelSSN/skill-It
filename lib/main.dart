import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillit/screens/login_screen.dart';
import 'models/user_model.dart';
import 'screens/contact_edit_screen.dart';
import 'screens/hire_screen.dart';
import 'screens/apply_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/landing_screen.dart';
import 'screens/main_navigation_screen.dart';
import 'screens/user_detail_screen.dart';

void main() {
  runApp(const MyAppWrapper());
}

class MyAppWrapper extends StatefulWidget {
  const MyAppWrapper({super.key});

  @override
  State<MyAppWrapper> createState() => _MyAppWrapperState();
}

class _MyAppWrapperState extends State<MyAppWrapper> {
  UserModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      setState(() {
        user = UserModel.fromJson(jsonDecode(userJson));
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }
    return MyApp(user: user);
  }
}

class MyApp extends StatelessWidget {
  final UserModel? user;

  const MyApp({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skill It',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const LandingScreen(),
        '/main': (context) => const MainNavigationScreen(),
        '/hire': (context) => const HireScreen(),
        '/apply': (context) => const ApplyScreen(),
        '/profile': (context) => ProfileScreen(),
        '/landing': (context) => const LandingScreen(),
        '/contact-edit':
            (context) =>
                ContactEditScreen(user: user!), // pass user here if needed
        '/login': (context) => LoginScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/user-detail') {
          final userArg = settings.arguments as UserModel;
          return MaterialPageRoute(
            builder: (_) => UserDetailScreen(user: userArg),
          );
        }
        return null;
      },
      onUnknownRoute:
          (settings) =>
              MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
    );
  }
}
