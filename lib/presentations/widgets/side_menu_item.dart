import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/utils/responsivennes.dart';
import 'package:telkom_ticket_manager/presentations/widgets/horizontal_menu_item.dart';
import 'package:telkom_ticket_manager/presentations/widgets/vertical_menu_item.dart';

// tergantung ukuran device, antara mereturn horizontal atau vertical menu item
class SideMenuItem extends StatelessWidget {
  final String itemName;
  final Function()? onTap;
  const SideMenuItem({super.key, required this.itemName, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomScreen(context)) {
      return VerticalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    }

    return HorizontalMenuItem(
      itemName: itemName,
      onTap: onTap,
    );
  }
}
