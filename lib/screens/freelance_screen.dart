import 'package:flutter/material.dart';

class FreelanceScreen extends StatefulWidget {
  const FreelanceScreen({super.key});

  @override
  State<FreelanceScreen> createState() => _FreelanceScreenState();
}

class _FreelanceScreenState extends State<FreelanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Freelance Screen'),
      ),
      body: const Center(
        child: Text('Freelance Screen'),
      ),
    );
  }
}
