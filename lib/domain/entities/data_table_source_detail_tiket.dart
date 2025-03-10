import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/domain/entities/detail_tiket.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';
import 'package:telkom_ticket_manager/utils/style.dart';

class DataTableSourceDetailTiket extends DataTableSource {
  final BuildContext context;
  final List<DetailTiket> detailTiketList;
  final String choosenIdTeknisi;
  DataTableSourceDetailTiket(
      this.context, this.detailTiketList, this.choosenIdTeknisi);

  @override
  DataRow? getRow(int index) {
    if (index >= detailTiketList.length) return null;
    final data = detailTiketList[index];
    return DataRow(cells: [
      DataCell(CustomText(text: data.idTeknisi)),
      DataCell(CustomText(text: data.namaTeknisi)),
      DataCell(CustomText(text: data.tiketAktif.toString())),
      DataCell(CustomText(text: data.totalTiket.toString())),
      DataCell(CustomText(text: data.durasi.toString())),
      DataCell(CustomText(text: data.keterangan)),
      DataCell(CustomText(text: data.wp.toString())),
      DataCell(CustomText(text: data.normalizedWp.toString())),
      DataCell(
        Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: choosenIdTeknisi == data.idTeknisi ? hijauBg : merahBg),
            child: CustomText(
              size: 14,
              text: choosenIdTeknisi == data.idTeknisi
                  ? 'Terpilih'
                  : 'Tidak Terpilih',
              color: choosenIdTeknisi == data.idTeknisi ? hijau : merah,
            )),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => detailTiketList.length;

  @override
  int get selectedRowCount => 0;
}
