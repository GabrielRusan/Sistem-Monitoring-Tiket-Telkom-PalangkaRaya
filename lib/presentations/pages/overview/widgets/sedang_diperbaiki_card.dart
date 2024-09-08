import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/active_tiket_bloc/active_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/info_card.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/info_card_small.dart';

class SedangDiperbaikiCard extends StatelessWidget {
  final bool isSmall;
  const SedangDiperbaikiCard({super.key, this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveTiketBloc, ActiveTiketState>(
      builder: (context, state) {
        return isSmall
            ? InfoCardSmall(
                title: 'Sedang diperbaiki',
                value: state.inProgressCount == null
                    ? '--'
                    : state.inProgressCount.toString(),
                isActive: true,
                onTap: () {})
            : InfoCard(
                title: 'Sedang diperbaiki',
                value: state.inProgressCount == null
                    ? '--'
                    : state.inProgressCount.toString(),
                topColor: Colors.orange,
                onTap: () {});
      },
    );
  }
}
