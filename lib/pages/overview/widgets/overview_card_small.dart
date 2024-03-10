import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/pages/overview/widgets/info_card_small.dart';

class OverviewCardSmallScreen extends StatelessWidget {
  const OverviewCardSmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 400,
      child: Column(children: [
        InfoCardSmall(
          title: "Sedang diperbaiki",
          value: "5",
          isActive: true,
          onTap: () {},
        ),
        SizedBox(
          height: width / 64,
        ),
        InfoCardSmall(
          title: "Selesai diperbaiki",
          value: "10",
          onTap: () {},
        ),
        SizedBox(
          height: width / 64,
        ),
        InfoCardSmall(
          title: "Belum diperbaiki",
          value: "7",
          onTap: () {},
        ),
        SizedBox(
          height: width / 64,
        ),
      ]),
    );
  }
}
