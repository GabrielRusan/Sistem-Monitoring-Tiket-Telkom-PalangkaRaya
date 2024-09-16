import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/detail_all_tiket_bloc/detail_all_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/detail_last_month_count_info.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/detail_last_week_count_info.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/detail_last_year_count_info.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/detail_today_count_info.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/bar_chart.dart';
import 'package:telkom_ticket_manager/utils/style.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class DetailTicketGangguanSectionSmall extends StatelessWidget {
  const DetailTicketGangguanSectionSmall({super.key});

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
      child: Column(
        children: [
          SizedBox(
            height: 260,
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
                  child: BlocBuilder<DetailAllTiketBloc, DetailAllTiketState>(
                    builder: (context, state) {
                      return BarChartSample3(
                        tickets: state.result,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 120,
            height: 1,
            color: lightGrey,
          ),
          const SizedBox(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [DetailTodayCountInfo(), DetailLastWeekCountInfo()],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    DetailLastMonthCountInfo(),
                    DetailLastYearCountInfo()
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
