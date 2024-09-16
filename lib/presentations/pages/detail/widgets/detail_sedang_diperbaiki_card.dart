import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/detail_active_tiket_bloc/detail_active_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/info_card.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/info_card_small.dart';

class DetailSedangDiperbaikiCard extends StatelessWidget {
  final bool isSmall;
  const DetailSedangDiperbaikiCard({super.key, this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailActiveTiketBloc, DetailActiveTiketState>(
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
