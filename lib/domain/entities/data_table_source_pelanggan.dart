import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:telkom_ticket_manager/domain/entities/pelanggan.dart';
import 'package:telkom_ticket_manager/presentations/blocs/update_pelanggan_bloc/update_pelanggan_bloc.dart';
import 'package:telkom_ticket_manager/presentations/pages/clients/widgets/edit_pelanggan_form.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';
import 'package:telkom_ticket_manager/utils/routes.dart';

class DataTableSourcePelanggan extends DataTableSource {
  final BuildContext context;
  final List<Pelanggan> pelangganList;

  DataTableSourcePelanggan(
    this.context,
    this.pelangganList,
  );

  @override
  DataRow? getRow(int index) {
    if (index >= pelangganList.length) return null;
    final data = pelangganList[index];
    return DataRow(
      cells: [
        DataCell(CustomText(text: data.idpelanggan.toString())),
        DataCell(CustomText(text: data.nama)),
        DataCell(CustomText(text: data.alamat)),
        DataCell(CustomText(text: data.nohp)),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        context
                            .read<UpdatePelangganBloc>()
                            .add(InitialEventPelanggan(pelanggan: data));
                        return EditPelangganForm(pelanggan: data);
                      });
                },
                child: const Icon(
                  Icons.edit_outlined,
                  color: Colors.orangeAccent,
                ),
              ),
            ],
          ),
        ),
      ],
      onSelectChanged: (value) {
        Get.toNamed(detailRoute, arguments: data, preventDuplicates: true);
      },
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => pelangganList.length;

  @override
  int get selectedRowCount => 0;
}
