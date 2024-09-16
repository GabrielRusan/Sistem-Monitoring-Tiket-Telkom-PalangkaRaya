import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/detail_active_tiket_bloc/detail_active_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/info_card.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/info_card_small.dart';

class DetailBelumDiperbaikiCard extends StatelessWidget {
  final bool isSmall;
  const DetailBelumDiperbaikiCard({super.key, this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailActiveTiketBloc, DetailActiveTiketState>(
      builder: (context, state) {
        return isSmall
            ? InfoCardSmall(
                title: 'Belum diperbaiki',
                value: state.ditugaskanCount == null
                    ? '--'
                    : state.ditugaskanCount.toString(),
                onTap: () {})
            : InfoCard(
                title: 'Belum diperbaiki',
                value: state.ditugaskanCount == null
                    ? '--'
                    : state.ditugaskanCount.toString(),
                topColor: Colors.redAccent,
                onTap: () {});
      },
    );
  }
}
