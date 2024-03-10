import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telkom_ticket_manager/constants/controllers.dart';
import 'package:telkom_ticket_manager/constants/style.dart';
import 'package:telkom_ticket_manager/helpers/responsivennes.dart';
import 'package:telkom_ticket_manager/routing/routes.dart';
import 'package:telkom_ticket_manager/widgets/custom_text.dart';
import 'package:telkom_ticket_manager/widgets/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: light,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(mainAxisSize: MainAxisSize.min, children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width / 48,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Image.asset(
                      "assets/icons/logo_telkom_lite.png",
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const Flexible(
                      child: CustomText(
                    text: "Telkom Indonesia",
                    size: 20,
                    weight: FontWeight.bold,
                    // color: active,
                  )),
                  SizedBox(
                    width: width / 48,
                  ),
                ],
              ),
              Divider(
                color: lightGrey.withOpacity(.1),
              ),
            ]),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map((item) => SideMenuItem(
                      itemName: item.name,
                      onTap: () {
                        if (item.route == authenticationPageRoute) {
                          Get.offAllNamed(authenticationPageRoute);
                          menuController
                              .changeActiveItemTo(overviewPageDisplayName);
                          return;
                        }

                        if (!menuController.isActive(item.name)) {
                          menuController.changeActiveItemTo(item.name);
                          if (ResponsiveWidget.isSmallScreen(context)) {
                            Get.back();
                          }
                          navigationController.navigateTo(item.route);
                        }
                      },
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
