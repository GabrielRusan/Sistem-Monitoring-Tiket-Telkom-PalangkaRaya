import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/constants/style.dart';
import 'package:telkom_ticket_manager/pages/overview/widgets/bar_chart.dart';
import 'package:telkom_ticket_manager/pages/overview/widgets/ticket_gangguan_info.dart';
import 'package:telkom_ticket_manager/widgets/custom_text.dart';

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
                SizedBox(
                  width: 600,
                  height: 200,
                  child: SimpleBarChart.withSampleData(),
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
                  children: [
                    TicketGangguanInfo(
                      title: "Hari ini",
                      amount: "5",
                    ),
                    TicketGangguanInfo(
                      title: "7 hari terakhir",
                      amount: "44",
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    TicketGangguanInfo(
                      title: "30 hari terakhir",
                      amount: "173",
                    ),
                    TicketGangguanInfo(
                      title: "1 tahun terakhir",
                      amount: "1370",
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
