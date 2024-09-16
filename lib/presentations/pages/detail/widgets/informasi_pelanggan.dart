import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/domain/entities/pelanggan.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';
import 'package:telkom_ticket_manager/utils/responsivennes.dart';
import 'package:telkom_ticket_manager/utils/style.dart';

class InformasiPelanggan extends StatelessWidget {
  final Pelanggan pelanggan;
  const InformasiPelanggan({super.key, required this.pelanggan});

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
              text: 'Informasi Pelanggan',
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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1521566652839-697aa473761a?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')),
                    ),
                    // child: ,
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
                        text: 'Alamat',
                        color: lightGrey,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: 'No HP',
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
                      CustomText(text: ':  ${pelanggan.nama}'),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(text: ':  ${pelanggan.alamat}'),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomText(text: ':  ${pelanggan.nohp}'),
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
                                  'https://images.unsplash.com/photo-1521566652839-697aa473761a?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')),
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
