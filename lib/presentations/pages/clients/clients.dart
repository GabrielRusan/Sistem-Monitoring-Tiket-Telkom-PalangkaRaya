import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telkom_ticket_manager/presentations/pages/clients/widgets/pelanggan_table.dart';
import 'package:telkom_ticket_manager/utils/controllers.dart';
import 'package:telkom_ticket_manager/utils/responsivennes.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 16),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                )
              ],
            )),
        Expanded(
            child: ListView(
          children: const [PelangganTable()],
        ))
      ],
    );
  }
}
