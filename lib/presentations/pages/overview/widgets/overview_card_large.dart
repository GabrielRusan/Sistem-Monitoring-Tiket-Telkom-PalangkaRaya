import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/belum_diperbaiki_card.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/sedang_diperbaiki_card.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/selesai_diperbaiki_card.dart';

class OverviewCardLargeScreen extends StatelessWidget {
  const OverviewCardLargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        const SedangDiperbaikiCard(),
        SizedBox(
          width: width / 64,
        ),
        const BelumDiperbaikiCard(),
        SizedBox(
          width: width / 64,
        ),
        const SelesaiDiperbaikiCard(),
      ],
    );
  }
}
