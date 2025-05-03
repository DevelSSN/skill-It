import 'package:flutter/material.dart';
import 'package:proj/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Profile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(children: <Widget>[Text("Name:"), Text(profile.getName())]),
        ],
      ),
    );
  }
}
