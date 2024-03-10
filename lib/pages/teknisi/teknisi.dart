import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:telkom_ticket_manager/constants/controllers.dart';
import 'package:telkom_ticket_manager/helpers/responsivennes.dart';
import 'package:telkom_ticket_manager/pages/teknisi/widgets/teknisi_table.dart';
import 'package:telkom_ticket_manager/widgets/custom_text.dart';

class TeknisiPage extends StatelessWidget {
  const TeknisiPage({super.key});

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
          children: const [TeknisiTable()],
        ))
      ],
    );
  }
}
