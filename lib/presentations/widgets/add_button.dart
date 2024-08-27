import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class AddButton extends StatelessWidget {
  final void Function() onTap;
  const AddButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(32),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            SizedBox(
              width: 8,
            ),
            CustomText(
              text: "Tambah Data",
              size: 13,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
