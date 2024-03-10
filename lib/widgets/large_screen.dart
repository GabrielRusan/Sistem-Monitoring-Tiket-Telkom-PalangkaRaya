import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/helpers/local_navigator.dart';
import 'package:telkom_ticket_manager/widgets/side_menu.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SideMenu()),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: localNavigator(),
          ),
        ),
      ],
    );
  }
}
