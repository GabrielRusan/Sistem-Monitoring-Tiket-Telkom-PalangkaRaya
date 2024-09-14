import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_ticket_manager/date_converter.dart';
import 'package:telkom_ticket_manager/domain/entities/admin.dart';
import 'package:telkom_ticket_manager/presentations/blocs/update_admin_bloc/update_admin_bloc.dart';
import 'package:telkom_ticket_manager/presentations/pages/admin/widgets/edit_admin_form.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class DataTableSourceAdmin extends DataTableSource {
  final BuildContext context;
  final List<Admin> adminList;
  final SharedPreferences sharedPreferences;

  DataTableSourceAdmin(this.context, this.adminList, this.sharedPreferences);

  @override
  DataRow? getRow(int index) {
    if (index >= adminList.length) return null;
    final data = adminList[index];
    final thisAdminId = sharedPreferences.getString('id');
    return DataRow(cells: [
      DataCell(CustomText(text: data.idadmin.toString())),
      DataCell(CustomText(text: data.username)),
      DataCell(CustomText(text: data.nama)),
      DataCell(CustomText(text: dateToStringLengkap(data.createdAt))),
      DataCell(thisAdminId == data.idadmin.toString()
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          context
                              .read<UpdateAdminBloc>()
                              .add(InitialEventAdmin(admin: data));
                          return EditAdminForm(admin: data);
                        });
                  },
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Colors.orangeAccent,
                  ),
                ),
              ],
            )
          : const SizedBox())
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => adminList.length;

  @override
  int get selectedRowCount => 0;
}
