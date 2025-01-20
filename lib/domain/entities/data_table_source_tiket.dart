import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telkom_ticket_manager/date_converter.dart';
import 'package:telkom_ticket_manager/domain/entities/tiket.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';
import 'package:telkom_ticket_manager/utils/routes.dart';

class DataTableSourceTiket extends DataTableSource {
  final bool isHistory;
  final List<Tiket> tiketList;

  DataTableSourceTiket(this.tiketList, {this.isHistory = false});

  @override
  DataRow? getRow(int index) {
    if (index >= tiketList.length) return null;
    final data = tiketList[index];
    return isHistory
        ? DataRow(
            cells: [
                DataCell(CustomText(text: data.nomorTiket)),
                DataCell(CustomText(text: data.pelanggan.nama)),
                DataCell(CustomText(text: data.pelanggan.alamat)),
                DataCell(CustomText(text: data.keluhan)),
                DataCell(CustomText(text: data.idOdp)),
                DataCell(CustomText(text: dateToStringLengkap(data.createdAt))),
                DataCell(CustomText(text: dateToStringLengkap(data.updatedAt))),
                DataCell(CustomText(
                    text: calculateDurasi(data.createdAt, data.updatedAt))),
                DataCell(CustomText(text: data.namaTeknisi)),
                DataCell(CustomText(text: data.type)),
                DataCell(CustomText(text: data.status)),
              ],
            onSelectChanged: (value) {
              Get.toNamed(detailTiketRoute,
                  arguments: {
                    'detail_tiket': data.detailTiket,
                    'choosen_id_teknisi': data.idTeknisi
                  },
                  preventDuplicates: true);
            })
        : DataRow(
            cells: [
              DataCell(CustomText(text: data.nomorTiket)),
              DataCell(CustomText(text: data.pelanggan.nama)),
              DataCell(CustomText(text: data.pelanggan.alamat)),
              DataCell(CustomText(text: data.keluhan)),
              DataCell(CustomText(text: data.idOdp)),
              DataCell(CustomText(text: dateToStringLengkap(data.createdAt))),
              DataCell(CustomText(text: data.namaTeknisi)),
              DataCell(CustomText(text: data.type)),
              DataCell(CustomText(text: data.status)),
            ],
            onSelectChanged: (value) {
              Get.toNamed(detailTiketRoute,
                  arguments: {
                    'detail_tiket': data.detailTiket,
                    'choosen_id_teknisi': data.idTeknisi
                  },
                  preventDuplicates: true);
            },
          );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tiketList.length;

  @override
  int get selectedRowCount => 0;
}
