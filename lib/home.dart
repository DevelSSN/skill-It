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

  @override
  void initState() {
    super.initState();
    _profile = Profile(name: '', phoneNumber: '', email: '', skills: {});
  }

  // Handle the click on the Google logo
  void _handleLogoClick() async {
    if (_profile?.name == null || _profile?.name == '') {
      // If not signed in, trigger Google Sign-In
      final result = await _profile?.signIn();
      if (result?.isNotEmpty ?? false) {
        setState(() {});
      }
    } else {
      // If signed in, navigate to edit profile or logout
      _showProfileOptions();
    }
  }

  // Show options for editing the profile or logging out
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
                  // Navigate to the profile editing page here
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
                        ? NetworkImage(
                          _profile!.email,
                        ) // You can replace it with the user's profile picture
                        : AssetImage('images/Person_Logo.png') as ImageProvider,
              ),
            ),
          ),
        ],
      ),
      body:
          _profile?.name == null || _profile?.name == ''
              ? Center(
                child: ElevatedButton(
                  onPressed: _handleLogoClick,
                  child: Text('Sign in with Google'),
                ),
              )
              : ProfileScreen(user: _profile!),
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
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              user.email,
            ), // Profile picture URL here
          ),
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
