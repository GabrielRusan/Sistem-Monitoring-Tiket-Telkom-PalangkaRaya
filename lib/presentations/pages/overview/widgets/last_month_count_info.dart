import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/active_tiket_bloc/active_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/ticket_gangguan_info.dart';

class LastMonthCountInfo extends StatelessWidget {
  const LastMonthCountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveTiketBloc, ActiveTiketState>(
      builder: (context, state) {
        return TicketGangguanInfo(
          title: "30 hari terakhir",
          amount: state.lastMonthCount == null
              ? '--'
              : state.lastMonthCount.toString(),
        );
      },
    );
  }
}
