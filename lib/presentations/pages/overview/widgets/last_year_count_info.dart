import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/all_tiket_bloc/all_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/ticket_gangguan_info.dart';

class LastYearCountInfo extends StatelessWidget {
  const LastYearCountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllTiketBloc, AllTiketState>(
      builder: (context, state) {
        return TicketGangguanInfo(
          title: "1 tahun terakhir",
          amount: state.lastYearCount == null
              ? '--'
              : state.lastYearCount.toString(),
        );
      },
    );
  }
}
