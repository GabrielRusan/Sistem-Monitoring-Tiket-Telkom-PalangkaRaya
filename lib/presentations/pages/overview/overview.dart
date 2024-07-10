import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:telkom_ticket_manager/utils/controllers.dart';
import 'package:telkom_ticket_manager/utils/responsivennes.dart';
import 'package:telkom_ticket_manager/presentations/widgets/ticket_table.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/overview_card_large.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/overview_card_medium.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/overview_card_small.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/ticket_gangguan_section_large.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/ticket_gangguan_section_small.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
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
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            if (ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isMediumScreen(context))
              if (ResponsiveWidget.isCustomScreen(
                  context)) // custom screen size start dari medium screen size
                const OverviewCardMediumScreen()
              else
                const OverviewCardLargeScreen()
            else
              const OverviewCardSmallScreen(),
            //
            if (!ResponsiveWidget.isSmallScreen(context))
              const TicketGangguanSectionLarge()
            else
              const TicketGangguanSectionSmall(),

            const TicketTable()
          ],
        ))
      ],
    );
  }
}
