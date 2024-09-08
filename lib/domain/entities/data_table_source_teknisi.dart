import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/date_converter.dart';
import 'package:telkom_ticket_manager/domain/entities/teknisi.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class DataTableSourceTeknisi extends DataTableSource {
  final List<Teknisi> teknisiList;

  DataTableSourceTeknisi(this.teknisiList);

  @override
  DataRow? getRow(int index) {
    if (index >= teknisiList.length) return null;
    final data = teknisiList[index];
    return DataRow(cells: [
      DataCell(CustomText(text: data.idteknisi.toString())),
      DataCell(CustomText(text: data.username)),
      DataCell(CustomText(text: data.pass)),
      DataCell(CustomText(text: data.nama)),
      DataCell(CustomText(text: data.sektor)),
      DataCell(CustomText(text: data.ket)),
      DataCell(CustomText(text: dateToStringLengkap(data.createdAt))),
      DataCell(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.edit_outlined,
              color: Colors.orangeAccent,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          InkWell(
              onTap: () {},
              child: const Icon(Icons.delete_outline, color: Colors.redAccent)),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => teknisiList.length;

  @override
  int get selectedRowCount => 0;
}
