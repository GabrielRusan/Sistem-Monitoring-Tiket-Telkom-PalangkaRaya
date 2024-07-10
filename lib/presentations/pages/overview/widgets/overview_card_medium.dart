import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/presentations/pages/overview/widgets/info_card.dart';

class OverviewCardMediumScreen extends StatelessWidget {
  const OverviewCardMediumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InfoCard(
              title: "Sedang diperbaiki",
              value: "5",
              onTap: () {},
              topColor: Colors.orange,
            ),
            SizedBox(
              width: width / 64,
            ),
            InfoCard(
              title: "Selesai diperbaiki",
              value: "10",
              onTap: () {},
              topColor: Colors.lightGreen,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            InfoCard(
              title: "Belum diperbaiki",
              value: "7",
              onTap: () {},
              topColor: Colors.redAccent,
            ),
          ],
        )
      ],
    );
  }
}
