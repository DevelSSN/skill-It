import 'package:flutter/material.dart';
import 'profile.dart'; // Import your Profile model

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Profile? _profile;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _profile = Profile(name: '', phoneNumber: '', email: '', skills: {});
  }

  // Handle the click on the Google logo
  void _handleLogoClick() async {
    if (_profile?.name == null || _profile?.name == '') {
      final result = await _profile?.signIn();
      if (result?.isNotEmpty ?? false) {
        setState(() {});
      }
    } else {
      _showProfileOptions();
    }
  }

  void _showProfileOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Profile Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit Profile'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to the profile editing page
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  _profile?.signOut();
                  setState(() {
                    _profile = Profile(
                      name: '',
                      phoneNumber: '',
                      email: '',
                      skills: {},
                    );
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getSelectedPage() {
    if (_profile?.name == null || _profile?.name == '') {
      return Center(
        child: ElevatedButton(
          onPressed: _handleLogoClick,
          child: Text('Sign in with Google'),
        ),
      );
    }

    // Example placeholder content for each tab
    switch (_selectedIndex) {
      case 0:
        return ProfileScreen(user: _profile!);
      case 1:
        return Center(child: Text("🔍 Search"));
      case 2:
        return Center(child: Text("📝 Apply"));
      case 3:
        return Center(child: Text("📄 Details"));
      default:
        return ProfileScreen(user: _profile!);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          GestureDetector(
            onTap: _handleLogoClick,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CircleAvatar(
                backgroundImage:
                    _profile?.name != null && _profile?.name != ''
                        ? NetworkImage(_profile!.email)
                        : AssetImage('images/Person_Logo.png') as ImageProvider,
              ),
            ),
          ),
        ],
      ),
      body: _getSelectedPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Text("🏠", style: TextStyle(fontSize: 20)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Text("🔍", style: TextStyle(fontSize: 20)),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Text("📝", style: TextStyle(fontSize: 20)),
            label: 'Apply',
          ),
          BottomNavigationBarItem(
            icon: Text("📄", style: TextStyle(fontSize: 20)),
            label: 'Details',
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final Profile user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 50, backgroundImage: NetworkImage(user.email)),
          SizedBox(height: 16),
          Text(
            'Name: ${user.name}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Email: ${user.email}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('Phone: ${user.phoneNumber}', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
