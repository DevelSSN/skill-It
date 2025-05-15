import 'package:flutter/material.dart';
import 'package:skillIt/screens/apply_screen.dart';
import 'package:skillIt/screens/login_screen.dart';
import 'hire_screen.dart';
import 'profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    const ProfileScreen(),
    const HireScreen(),
    const ApplyScreen(),
    const LoginScreen(),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Hire'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business),
            label: 'Apply',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Log In'),
        ],
      ),
    );
  }
}
