import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telkom_ticket_manager/utils/controllers.dart';
import 'package:telkom_ticket_manager/utils/style.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class HorizontalMenuItem extends StatelessWidget {
  final String itemName;
  final Function()? onTap;
  const HorizontalMenuItem({super.key, required this.itemName, this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(itemName)
            : menuController.onHover("not hovering");
      },
      child: Obx(() => Container(
            color: menuController.isHovering(itemName)
                ? lightGrey.withOpacity(.1)
                : Colors.transparent,
            child: Row(
              children: [
                Visibility(
                  visible: menuController.isHovering(itemName) ||
                      menuController.isActive(itemName),
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                  child: Container(
                    width: 6,
                    height: 40,
                    color: dark,
                  ),
                ),
                SizedBox(
                  width: width / 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: menuController.returnIconFor(itemName),
                ),

                // jika menu nya sedang tidak active dan lagi tidak di hover, kasih lightGrey
                if (!menuController.isActive(itemName))
                  Flexible(
                      child: CustomText(
                    text: itemName,
                    color:
                        menuController.isHovering(itemName) ? dark : lightGrey,
                  ))

                // jika menu nya sedang active, kasih warna hitam dan bold
                else
                  Flexible(
                      child: CustomText(
                    text: itemName,
                    color: dark,
                    size: 18,
                    weight: FontWeight.bold,
                  ))
              ],
            ),
          )),
    );
  }
}
