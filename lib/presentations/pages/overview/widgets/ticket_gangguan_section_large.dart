import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/bar_chart.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/last_month_count_info.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/last_week_count_info.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/last_year_count_info.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/today_count_info.dart';
import 'package:telkom_ticket_manager/utils/style.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class TicketGangguanSectionLarge extends StatelessWidget {
  const TicketGangguanSectionLarge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12)
          ],
          border: Border.all(color: lightGrey, width: .5)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Ticket Gangguan Chart",
                  size: 20,
                  weight: FontWeight.bold,
                  color: lightGrey,
                ),
                const SizedBox(
                  width: 600,
                  height: 200,
                  child: BarChartSample3(),
                ),
              ],
            ),
          ),
          Container(
            height: 120,
            width: 1,
            color: lightGrey,
          ),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [TodayCountInfo(), LastWeekCountInfo()],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [LastMonthCountInfo(), LastYearCountInfo()],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
