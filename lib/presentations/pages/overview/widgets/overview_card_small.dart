import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/belum_diperbaiki_card.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/sedang_diperbaiki_card.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/selesai_diperbaiki_card.dart';

class OverviewCardSmallScreen extends StatelessWidget {
  const OverviewCardSmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 400,
      child: Column(children: [
        const SedangDiperbaikiCard(
          isSmall: true,
        ),
        SizedBox(
          height: width / 64,
        ),
        const BelumDiperbaikiCard(
          isSmall: true,
        ),
        SizedBox(
          height: width / 64,
        ),
        const SelesaiDiperbaikiCard(
          isSmall: true,
        ),
        SizedBox(
          height: width / 64,
        ),
      ]),
    );
  }
}
