import 'package:flutter/material.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skill It',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/splash', // Optional, or use '/main'
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/main': (context) => const MainNavigationScreen(),
        '/hire': (context) => const HireScreen(),
        '/apply': (context) => const ApplyScreen(),
        '/profile': (context) => ProfileScreen(),
        '/landing': (context) => const LandingScreen(),
        '/contact-edit': (context) => const ContactEditScreen(),
        '/login': (context) => LoginScreen(),
        // Add more routes as needed
      },
      // If unknown route, fallback to main or splash
      onUnknownRoute: (settings) {
        if (settings.name == '/' || settings.name == '/main') {
          return MaterialPageRoute(
            builder: (_) => const MainNavigationScreen(),
          );
        } else if (settings.name == '/user-detail') {
          final user = settings.arguments as UserModel;
          return MaterialPageRoute(
            builder: (_) => UserDetailScreen(user: user), // No const here!
          );
        }
        return null;
      },
    );
  }
}

// Basic splash screen as a placeholder
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // For example, wait a moment then go to main
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/main');
    });

    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to Hire & Apply',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
