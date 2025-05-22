import 'package:flutter/material.dart';
import 'apply_screen.dart';
import 'hire_screen.dart';
import 'login_screen.dart';
import 'profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;
  const MainNavigationScreen({Key? key, this.initialIndex = 0})
    : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _selectedIndex;

  static final List<Widget> _screens = <Widget>[
    const ProfileScreen(),
    const HireScreen(),
    const ApplyScreen(),
    const LoginScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

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
