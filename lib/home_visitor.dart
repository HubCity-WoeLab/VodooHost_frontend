import 'package:flutter/material.dart';

class HomeVisitorPage extends StatelessWidget {
  const HomeVisitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Visitor'),
      ),
      body: const Center(
        child: Text('Welcome to the Visitor Home Page!'),
      ),
    );
  }
}