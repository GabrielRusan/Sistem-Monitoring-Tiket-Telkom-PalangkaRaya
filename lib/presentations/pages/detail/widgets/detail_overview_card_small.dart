import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/detail_sedang_diperbaiki_card.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/detail_selesai_diperbaiki_card.dart';

class DetailOverviewCardSmallScreen extends StatelessWidget {
  const DetailOverviewCardSmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 400,
      child: Column(children: [
        const DetailSedangDiperbaikiCard(
          isSmall: true,
        ),
        SizedBox(
          height: width / 64,
        ),
        const DetailSelesaiDiperbaikiCard(
          isSmall: true,
        ),
        SizedBox(
          height: width / 64,
        ),
      ]),
    );
  }
}
