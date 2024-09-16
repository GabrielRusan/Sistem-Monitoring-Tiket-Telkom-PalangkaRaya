import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/detail_belum_diperbaiki_card.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/detail_sedang_diperbaiki_card.dart';
import 'package:telkom_ticket_manager/presentations/pages/detail/widgets/detail_selesai_diperbaiki_card.dart';

class DetailOverviewCardLargeScreen extends StatelessWidget {
  const DetailOverviewCardLargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        const DetailSedangDiperbaikiCard(),
        SizedBox(
          width: width / 64,
        ),
        const DetailBelumDiperbaikiCard(),
        SizedBox(
          width: width / 64,
        ),
        const DetailSelesaiDiperbaikiCard(),
      ],
    );
  }
}
