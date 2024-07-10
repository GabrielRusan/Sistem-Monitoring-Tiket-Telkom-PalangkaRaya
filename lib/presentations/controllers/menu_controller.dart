import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telkom_ticket_manager/utils/style.dart';
import 'package:telkom_ticket_manager/utils/routes.dart';

// logic untuk control active dan hovering menu side bar
class MyMenuController extends GetxController {
  static MyMenuController instance = Get.find();

  // variabel yang harus di pantau terus
  var activeItem = overviewPageDisplayName.obs; // kasih nilai awal
  var hoverItem = "".obs; // kasih nilai awal

  void changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  void onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  bool isActive(String itemName) => activeItem.value == itemName;

  bool isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case overviewPageDisplayName:
        return customIcon(Icons.trending_up, itemName);
      case teknisiPageDisplayName:
        return customIcon(Icons.drive_eta, itemName);
      case clientPageDisplayName:
        return customIcon(Icons.people_alt_outlined, itemName);
      case authenticationPageDisplayName:
        return customIcon(Icons.exit_to_app, itemName);
      default:
        return customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) return Icon(icon, size: 22, color: dark);

    return Icon(icon, color: isHovering(itemName) ? dark : lightGrey);
  }
}
