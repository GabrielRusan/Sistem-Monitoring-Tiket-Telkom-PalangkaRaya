import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telkom_ticket_manager/data/models/rekap_model.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class DataTableSourceAbsence extends DataTableSource {
  final BuildContext context;
  final List<Absen> absenceList;
  // final SharedPreferences sharedPreferences;

  DataTableSourceAbsence(this.context, this.absenceList);

  String splitTime(String time) {
    List<String> splitted = time.split(":");

    return '${splitted[0]}:${splitted[1]}';
  }

  @override
  DataRow? getRow(int index) {
    if (index >= absenceList.length) return null;
    final data = absenceList[index];
    return DataRow(cells: [
      DataCell(CustomText(text: data.id)),
      DataCell(CustomText(text: data.idTeknisi)),
      DataCell(CustomText(text: data.nama)),
      DataCell(CustomText(
          text: DateFormat('d MMMM yyyy', 'id_ID').format(data.tanggal))),
      DataCell(CustomText(text: splitTime(data.jamMasuk))),
      DataCell(CustomText(text: splitTime(data.jamKeluar))),
      DataCell(CustomText(text: data.totalWaktuKerja)),
      DataCell(CustomText(text: data.totalTiket)),
      DataCell(CustomText(text: data.rataRataPenyelesaian)),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        // margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: data.statusKehadiran == 'Hadir'
                ? Colors.green.shade50
                : Colors.red.shade50,
            borderRadius: BorderRadius.circular(50)),
        child: CustomText(
          text: data.statusKehadiran,
          size: 12,
          color: data.statusKehadiran == 'Hadir' ? Colors.green : Colors.red,
          weight: FontWeight.bold,
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => absenceList.length;

  @override
  int get selectedRowCount => 0;
}
