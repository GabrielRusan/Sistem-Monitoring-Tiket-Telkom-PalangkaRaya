import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/utils/style.dart';

class TicketGangguanInfo extends StatelessWidget {
  final String title;
  final String amount;
  const TicketGangguanInfo(
      {super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: "$title \n\n",
                style: TextStyle(color: lightGrey, fontSize: 16)),
            TextSpan(
                text: amount,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ])),
    );
  }
}
