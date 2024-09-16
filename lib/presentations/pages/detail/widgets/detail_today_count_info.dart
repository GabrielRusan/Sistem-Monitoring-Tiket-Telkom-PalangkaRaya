import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/detail_all_tiket_bloc/detail_all_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/ticket_gangguan_info.dart';

class DetailTodayCountInfo extends StatelessWidget {
  const DetailTodayCountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailAllTiketBloc, DetailAllTiketState>(
      builder: (context, state) {
        return TicketGangguanInfo(
          title: "Hari ini",
          amount: state.todayCount == null ? '--' : state.todayCount.toString(),
        );
      },
    );
  }
}
