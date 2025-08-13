
import 'package:flutter/material.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Today')),
        body: const Center(child: Text('Next 12 hours, priorities, quick add')),
      ),
    );
  }
}
