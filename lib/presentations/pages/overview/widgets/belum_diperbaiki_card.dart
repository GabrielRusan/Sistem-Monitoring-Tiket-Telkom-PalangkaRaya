import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/active_tiket_bloc/active_tiket_bloc.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/info_card.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/info_card_small.dart';

class BelumDiperbaikiCard extends StatelessWidget {
  final bool isSmall;
  const BelumDiperbaikiCard({super.key, this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveTiketBloc, ActiveTiketState>(
      builder: (context, state) {
        if (state.status == ActiveTiketStatus.loaded) {
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
        }
        return isSmall
            ? InfoCardSmall(
                title: 'Belum diperbaiki',
                value: state.ditugaskanCount == null
                    ? '--'
                    : state.ditugaskanCount.toString(),
                onTap: () {})
            : InfoCard(
                title: 'Belum diperbaiki',
                value: '--',
                onTap: () {},
                topColor: Colors.redAccent,
              );
      },
    );
  }
}
