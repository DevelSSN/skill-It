import 'package:flutter/material.dart';

class SkillTile extends StatelessWidget {
  final String skill;

  const SkillTile({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(skill), backgroundColor: Colors.blue.shade100);
  }
}
