import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/date_converter.dart';
import 'package:telkom_ticket_manager/domain/entities/tiket.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class DataTableSourceTiket extends DataTableSource {
  final List<Tiket> tiketList;

  DataTableSourceTiket(this.tiketList);

  @override
  DataRow? getRow(int index) {
    if (index >= tiketList.length) return null;
    final data = tiketList[index];
    return DataRow(cells: [
      DataCell(CustomText(text: data.nomorTiket)),
      DataCell(CustomText(text: data.pelanggan.nama)),
      DataCell(CustomText(text: data.pelanggan.alamat)),
      DataCell(CustomText(text: data.keluhan)),
      DataCell(CustomText(text: data.idOdp)),
      DataCell(CustomText(text: dateToStringLengkap(data.createdAt))),
      DataCell(CustomText(text: data.namaTeknisi)),
      DataCell(CustomText(text: data.type)),
      DataCell(CustomText(text: data.status)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tiketList.length;

  @override
  int get selectedRowCount => 0;
}
