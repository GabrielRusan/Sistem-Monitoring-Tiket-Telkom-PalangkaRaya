import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telkom_ticket_manager/data/models/detail_tiket_model.dart';
import 'package:telkom_ticket_manager/domain/entities/detail_tiket.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';
import 'package:telkom_ticket_manager/utils/constants.dart';
import 'package:telkom_ticket_manager/utils/routes.dart';
import 'package:telkom_ticket_manager/utils/style.dart';

class DetailTiketPage extends StatelessWidget {
  final List<DetailTiket>? detailTiket;
  final String choosenIdTeknisi;
  const DetailTiketPage(
      {super.key, required this.detailTiket, required this.choosenIdTeknisi});

  @override
  Widget build(BuildContext context) {
    if (detailTiket == null) {
      Future.microtask(() => Get.offNamed(rootRoute));
      return const Scaffold();
    }

    int index = detailTiket!.indexWhere((e) => e.idTeknisi == choosenIdTeknisi);
    if (index != -1) {
      detailTiket!.insert(0, detailTiket!.removeAt(index));
    }

    return LayoutBuilder(
      builder: (context, constaint) {
        double width = constaint.maxWidth;

        bool isLargeLaptop = width >= largeLaptopSize - 32;
        bool isLaptop = width >= laptopSize;
        bool isTablet = width >= tabletSize;
        bool isCustom = width >= 625;
        bool isMobileS = width >= mobileS;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Detail Perhitungan Pemilihan Teknisi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              left: 16,
              right: 16,
            ),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isLargeLaptop
                    ? 4
                    : isLaptop
                        ? 3
                        : isTablet || isCustom
                            ? 2
                            : 1, // Jumlah item per baris
                crossAxisSpacing: 10.0, // Jarak horizontal antar item
                mainAxisSpacing: 10.0, // Jarak vertikal antar item
                mainAxisExtent: 285,
              ),
              itemBuilder: (context, index) {
                final detail = detailTiket![index];
                bool isTerpilih = index == 0;
                return buildDetailTiketCard(detail, isTerpilih, isMobileS);
              },
              itemCount: detailTiket!.length,
            ),
          ),
        );
      },
    );
  }

  Widget buildDetailTiketCard(
      DetailTiket detail, bool isTerpilih, bool isSmall) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border, width: 1)),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [buildLabel(isTerpilih)],
          ),
          buildInfo('ID Teknisi', detail.idTeknisi, 'start'),
          const SizedBox(
            height: 8,
          ),
          buildInfo('Nama Teknisi', detail.namaTeknisi, 'start'),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                  child: buildInfo(
                      'Tiket Aktif', detail.tiketAktif.toString(), 'start')),
              Expanded(
                  child: Row(
                mainAxisAlignment: isSmall
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  buildInfo(
                      'Total Tiket', detail.totalTiket.toString(), 'start'),
                ],
              )),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildInfo('Durasi (Menit)', detail.durasi, 'start'),
                ],
              )),
              // Expanded(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       buildInfo('Nama Teknisi',
              //           'Yaadlfkjalfjladfjalsdfjlajsdflhya', 'start'),
              //     ],
              //   ),
              // )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          buildInfo('WP', detail.wp.toString(), 'start'),
          const SizedBox(
            height: 8,
          ),
          buildInfo('Normalized WP', detail.normalizedWp.toString(), 'start'),
        ],
      ),
    );
  }

  Widget buildInfo(String title, String subTitle, String crossAlignment) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: crossAlignment == 'end'
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          overflow: TextOverflow.ellipsis,
          weight: FontWeight.w600,
          size: 14,
        ),
        CustomText(
          text: subTitle,
          overflow: TextOverflow.ellipsis,
          size: 13,
        ),
      ],
    );
  }

  Widget buildLabel(bool isTerpilih) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isTerpilih ? hijauBg : merahBg),
      child: CustomText(
        size: 14,
        text: isTerpilih ? 'Terpilih' : 'Tidak Terpilih',
        color: isTerpilih ? hijau : merah,
      ),
    );
  }
}

List<dynamic> dummyDataDirty = [
  {
    "id_detailtiket": "DT-34350",
    "tiketaktif": "0",
    "totaltiket": "0",
    "wp": "2.9153065396408633",
    "normalized_wp": "0.3333333333333333",
    "durasi": "0",
    "idteknisi": "TK-92689",
    "namateknisi": "Teknisi"
  },
  {
    "id_detailtiket": "DT-56625",
    "tiketaktif": "0",
    "totaltiket": "0",
    "wp": "2.9153065396408633",
    "normalized_wp": "0.3333333333333333",
    "durasi": "0",
    "idteknisi": "TK-70125",
    "namateknisi": "Teknisi2"
  },
  {
    "id_detailtiket": "DT-60164",
    "tiketaktif": "0",
    "totaltiket": "0",
    "wp": "2.9153065396408633",
    "normalized_wp": "0.3333333333333333",
    "durasi": "0",
    "idteknisi": "TK-88410",
    "namateknisi": "Teknisi3"
  },
  {
    "id_detailtiket": "DT-60164",
    "tiketaktif": "0",
    "totaltiket": "0",
    "wp": "2.9153065396408633",
    "normalized_wp": "0.3333333333333333",
    "durasi": "0",
    "idteknisi": "TK-88410",
    "namateknisi": "Teknisi3"
  },
  {
    "id_detailtiket": "DT-60164",
    "tiketaktif": "0",
    "totaltiket": "0",
    "wp": "2.9153065396408633",
    "normalized_wp": "0.3333333333333333",
    "durasi": "0",
    "idteknisi": "TK-88410",
    "namateknisi": "Teknisi3"
  },
];

List<DetailTiket> dummy = dummyDataDirty
    .map<DetailTiket>((e) => DetailTiketModel.fromJson(e).toEntity())
    .toList();
