import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:telkom_ticket_manager/domain/entities/teknisi.dart';
import 'package:telkom_ticket_manager/presentations/blocs/delete_teknisi_bloc/delete_teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/update_teknisi_bloc/update_teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/pages/teknisi/widgets/edit_teknisi_form.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';
import 'package:telkom_ticket_manager/utils/routes.dart';

class DataTableSourceTeknisi extends DataTableSource {
  final BuildContext context;
  final List<Teknisi> teknisiList;

  DataTableSourceTeknisi(this.context, this.teknisiList);

  @override
  DataRow? getRow(int index) {
    if (index >= teknisiList.length) return null;
    final data = teknisiList[index];
    return DataRow(
        cells: [
          DataCell(CustomText(text: data.idteknisi.toString())),
          DataCell(CustomText(text: data.username)),
          DataCell(CustomText(text: data.pass)),
          DataCell(CustomText(text: data.nama)),
          DataCell(Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(text: data.kehadiran),
              const SizedBox(width: 24),
            ],
          )),
          DataCell(CustomText(text: data.ket)),
          DataCell(CustomText(text: data.status)),
          DataCell(Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        context
                            .read<UpdateTeknisiBloc>()
                            .add(InitialEventTeknisi(teknisi: data));
                        return EditTeknisiForm(teknisi: data);
                      });
                },
                child: const Icon(
                  Icons.edit_outlined,
                  color: Colors.orangeAccent,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              InkWell(
                  onTap: () {
                    context.read<DeleteTeknisiBloc>().add(
                        WarningDeleteTeknisiEvent(
                            idTeknisi: data.idteknisi, namaTeknisi: data.nama));
                  },
                  child: const Icon(Icons.delete_outline,
                      color: Colors.redAccent)),
            ],
          )),
        ],
        onSelectChanged: (value) {
          Get.toNamed(detailRoute, arguments: data, preventDuplicates: true);
        });
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => teknisiList.length;

  @override
  int get selectedRowCount => 0;
}
