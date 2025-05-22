import 'package:flutter/material.dart';
import 'package:skillit/screens/user_detail_screen.dart';

import '../models/user_model.dart';
// The project architect specified a 'user_list_tile.dart' widget.
// Assuming it will be in 'lib/widgets/user_list_tile.dart'
// If it's not created yet, this import will temporarily cause an error,
// but per instructions, we assume it will be correctly generated.
import '../widgets/user_list_tile.dart';

class HireScreen extends StatefulWidget {
  const HireScreen({super.key});

  @override
  State<HireScreen> createState() => _HireScreenState();
}

class _HireScreenState extends State<HireScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<UserModel> _allUsers =
      []; // This would typically be fetched from a service
  List<UserModel> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    // Initialize with some mock data until a service is implemented
    _allUsers = [
      const UserModel(
        id: '1',
        name: 'Alice Wonderland',
        contact: '123-456-7890',
        email: 'alice@example.com',
        skills: ['Flutter', 'Dart', 'UI/UX'],
        profilePictureUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
      ),
      const UserModel(
        id: '2',
        name: 'Bob The Builder',
        contact: '987-654-3210',
        email: 'bob@example.com',
        skills: ['Project Management', 'Construction', 'Leadership'],
        profilePictureUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
      ),
      const UserModel(
        id: '3',
        name: 'Charlie Brown',
        contact: '555-123-4567',
        email: 'charlie@example.com',
        skills: ['Graphic Design', 'Illustration', 'Adobe Suite'],
        profilePictureUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
      ),
      const UserModel(
        id: '4',
        name: 'Diana Prince',
        contact: '555-987-6543',
        email: 'diana@example.com',
        skills: ['Java', 'Spring Boot', 'AWS'],
        profilePictureUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
      ),
      const UserModel(
        id: '5',
        name: 'Edward Scissorhands',
        contact: '555-555-5555',
        email: 'edward@example.com',
        skills: ['Art', 'Gardening', 'Hairstyling'],
        profilePictureUrl: 'https://randomuser.me/api/portraits/men/5.jpg',
      ),
    ];
    _filteredUsers = _allUsers;
    _searchController.addListener(_filterUsers);
  }

  void _filterUsers() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _filteredUsers = _allUsers;
      });
    } else {
      setState(() {
        _filteredUsers =
            _allUsers.where((user) {
              final nameMatches = user.name.toLowerCase().contains(query);
              final skillMatches = user.skills.any(
                (skill) => skill.toLowerCase().contains(query),
              );
              return nameMatches || skillMatches;
            }).toList();
      });
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterUsers);
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToProfilePage(UserModel user2) {
    // The description says "Tapping a user opens Apply Page."
    // This implies pushing the ApplyScreen onto the navigation stack.
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => UserDetailScreen(user: user2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar might be part of MainNavigationScreen if this is a tab.
      // For simplicity, let's assume it's managed here for now or that
      // MainNavigationScreen provides an AppBar that this screen can influence.
      // If this screen is a primary tab, the AppBar title would likely be static "Hire" or "Search".
      // For the purpose of this file, we'll include a basic AppBar.
      appBar: AppBar(
        title: const Text('Hire (Search)'),
        // No leading back button if this is a root tab screen
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name or skill...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child:
                _filteredUsers.isEmpty
                    ? Center(
                      child: Text(
                        'No users found.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                    : ListView.builder(
                      itemCount: _filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = _filteredUsers[index];
                        // Use the custom UserListTile widget
                        return UserListTile(
                          user: user,
                          onTap: () => _navigateToProfilePage(user),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
