import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/data/models/odp_model.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class DataTableSourceOdp extends DataTableSource {
  final BuildContext context;
  final List<OdpModel> odpList;

  DataTableSourceOdp(
    this.context,
    this.odpList,
  );

  @override
  DataRow? getRow(int index) {
    if (index >= odpList.length) return null;
    final data = odpList[index];
    return DataRow(
      cells: [
        DataCell(CustomText(text: data.idodp)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => odpList.length;

  @override
  int get selectedRowCount => 0;
}
