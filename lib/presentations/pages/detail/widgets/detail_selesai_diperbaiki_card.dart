import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/detail_historic_tiket_bloc/detail_historic_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/info_card.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/info_card_small.dart';

class DetailSelesaiDiperbaikiCard extends StatelessWidget {
  final bool isSmall;
  const DetailSelesaiDiperbaikiCard({super.key, this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailHistoricTiketBloc, DetailHistoricTiketState>(
      builder: (context, state) {
        return isSmall
            ? InfoCardSmall(
                title: 'Selesai diperbaiki',
                value: state.selesaiCount == null
                    ? '--'
                    : state.selesaiCount.toString(),
                onTap: () {})
            : InfoCard(
                title: 'Selesai diperbaiki',
                value: state.selesaiCount == null
                    ? '--'
                    : state.selesaiCount.toString(),
                topColor: Colors.lightGreen,
                onTap: () {});
      },
    );
  }
}
