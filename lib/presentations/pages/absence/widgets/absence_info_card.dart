import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';
import 'package:telkom_ticket_manager/utils/style.dart';

class AbsenceInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool isUseChip;
  final String? chipValue;
  final bool isGreen;
  final bool isArrowUpward;
  final String subTitle;
  const AbsenceInfoCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.value,
      this.isUseChip = false,
      this.chipValue,
      this.isArrowUpward = true,
      this.isGreen = true,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12)
          ]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: lightActive,
                ),
                const SizedBox(
                  width: 8,
                ),
                CustomText(
                  text: title,
                  weight: FontWeight.w600,
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            CustomText(
              text: value,
              size: 28,
              weight: FontWeight.bold,
            ),
            const SizedBox(
              height: 4,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     isUseChip
            //         ? Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 6, vertical: 1),
            //             decoration: BoxDecoration(
            //                 color: isGreen
            //                     ? Colors.green.shade50
            //                     : Colors.red.shade50,
            //                 borderRadius: BorderRadius.circular(50)),
            //             child: Row(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 Icon(
            //                   isArrowUpward
            //                       ? Icons.arrow_upward_outlined
            //                       : Icons.arrow_downward_outlined,
            //                   size: 14,
            //                   color: isGreen ? Colors.green : Colors.red,
            //                 ),
            //                 const SizedBox(
            //                   width: 3,
            //                 ),
            //                 CustomText(
            //                   text: chipValue ?? '',
            //                   size: 14,
            //                   color: isGreen ? Colors.green : Colors.red,
            //                   weight: FontWeight.bold,
            //                 )
            //               ],
            //             ),
            //           )
            //         : const SizedBox(),
            //     isUseChip
            //         ? const SizedBox(
            //             width: 8,
            //           )
            //         : const SizedBox(),
            //     CustomText(
            //       text: subTitle,
            //       size: 14,
            //       color: const Color(0xff777777),
            //       weight: FontWeight.w500,
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
