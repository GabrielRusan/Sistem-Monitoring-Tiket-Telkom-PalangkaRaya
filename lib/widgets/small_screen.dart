import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/helpers/local_navigator.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: localNavigator(),
    );
  }
}
