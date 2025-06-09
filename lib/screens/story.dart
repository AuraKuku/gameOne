import 'package:flutter/material.dart';

class StoryScreen extends StatelessWidget {
  final String name;

  const StoryScreen({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Story Screen with name: $name')),
    );
  }
}