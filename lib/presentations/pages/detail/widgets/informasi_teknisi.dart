import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/date_converter.dart';
import 'package:telkom_ticket_manager/domain/entities/teknisi.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';
import 'package:telkom_ticket_manager/utils/responsivennes.dart';
import 'package:telkom_ticket_manager/utils/style.dart';

class InformasiTeknisi extends StatelessWidget {
  final Teknisi teknisi;
  const InformasiTeknisi({super.key, required this.teknisi});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 6),
                  color: lightGrey.withOpacity(.1),
                  blurRadius: 12)
            ],
            border: Border.all(color: lightGrey, width: .5)),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Informasi Teknisi',
              size: 20,
              weight: FontWeight.w600,
            ),
            const SizedBox(
              height: 16,
            ),
            ResponsiveWidget.isSmallScreen(context)
                ? Container(
                    height: 220,
                    width: 220,
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade500,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(teknisi.imageUrl)),
                    ),
                  )
                : const SizedBox(),
            Row(
              children: [
                Expanded(
                  flex: ResponsiveWidget.isSmallScreen(context) ? 2 : 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Nama',
                        color: lightGrey,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: 'Username',
                        color: lightGrey,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: 'Password',
                        color: lightGrey,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: 'Kehadiran',
                        color: lightGrey,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: 'Status',
                        color: lightGrey,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: 'Tanggal Dibuat',
                        color: lightGrey,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: ':  ${teknisi.nama}'),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(text: ':  ${teknisi.username}'),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(text: ':  ${teknisi.pass}'),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(text: ':  ${teknisi.kehadiran}'),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(text: ':  ${teknisi.ket}'),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(
                          text: ':  ${dateToStringLengkap(teknisi.createdAt)}'),
                    ],
                  ),
                ),
                !ResponsiveWidget.isSmallScreen(context)
                    ? Expanded(
                        child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(teknisi.imageUrl)),
                        ),
                        // child: ,
                      ))
                    : const SizedBox()
              ],
            ),
          ],
        ));
  }
}
