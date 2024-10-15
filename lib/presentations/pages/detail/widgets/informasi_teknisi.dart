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
                      shape: BoxShape.circle, color: Colors.grey.shade500,
                      // image: DecorationImage(
                      //     fit: BoxFit.cover,
                      //     image: NetworkImage(
                      //         'https://plus.unsplash.com/premium_photo-1661657662067-3a9db81248d4?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')),
                    ),
                    child: Center(
                      child: Icon(
                        size: 50,
                        Icons.person_outline,
                        color: Colors.grey.shade200,
                      ),
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
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://plus.unsplash.com/premium_photo-1661657662067-3a9db81248d4?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')),
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
