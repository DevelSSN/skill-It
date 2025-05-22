import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skillit/screens/user_detail_screen.dart';

import 'package:http/http.dart' as http;
import 'package:skillit/services/api_service.dart';
import '../models/user_model.dart';
import '../widgets/user_list_tile.dart';

class HireScreen extends StatefulWidget {
  const HireScreen({super.key});

  @override
  State<HireScreen> createState() => _HireScreenState();
}

class _HireScreenState extends State<HireScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<UserModel> _allUsers = [];
  List<UserModel> _filteredUsers = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _searchController.addListener(_filterUsers);
  }

  Future<void> _fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/user'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);

        // Convert JSON list to List<UserModel>
        _allUsers =
            jsonList.map((jsonItem) => UserModel.fromJson(jsonItem)).toList();

        setState(() {
          _filteredUsers = _allUsers;
          _isLoading = false;
          _errorMessage = null;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to fetch users: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching users: $e';
        _isLoading = false;
      });
    }
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

  void _navigateToProfilePage(UserModel user) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => UserDetailScreen(user: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hire (Search)'),
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
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage != null
                    ? Center(
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                    : _filteredUsers.isEmpty
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
