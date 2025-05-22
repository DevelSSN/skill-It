import 'package:flutter/material.dart';
import '../models/user_model.dart';

class LandingScreen extends StatelessWidget {
  final UserModel? user;
  const LandingScreen({super.key, this.user});

  static const _defaultUser = UserModel(
    id: '0',
    name: 'Skill It User',
    contact: '',
    email: 'contact@skillit.app',
    skills: [],
    profilePictureUrl: '',
  );

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name;
    final message = switch (routeName) {
      '/landing_after_apply' => 'Your application has been submitted!',
      '/landing_after_logout' => 'You have been logged out.',
      _ => 'Welcome to Skill It!',
    };

    final displayUser = user ?? _defaultUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill It'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(message, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              Text('User: ${displayUser.name}'),
              Text('Contact: ${displayUser.email}'),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed:
                    () => Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil('/main_nav', (_) => false),
                child: const Text('Return to App'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
