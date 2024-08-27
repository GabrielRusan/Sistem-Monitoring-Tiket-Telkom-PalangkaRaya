import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/teknisi_bloc/teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/widgets/add_button.dart';
import 'package:telkom_ticket_manager/utils/style.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class TeknisiTable extends StatelessWidget {
  const TeknisiTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 625,
      padding: const EdgeInsets.only(bottom: 8, top: 16, left: 16, right: 16),
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            color: lightGrey.withOpacity(.1),
            blurRadius: 12,
          )
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: "Teknisi Table",
                  color: lightGrey,
                  weight: FontWeight.bold),
              AddButton(onTap: () {}),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 540,
            child: BlocBuilder<TeknisiBloc, TeknisiState>(
              builder: (context, state) {
                if (state.status == TeknisiStatus.loaded) {
                  return DataTable2(
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 1500,
                      columns: [
                        DataColumn2(
                          fixedWidth: 100,
                          label: const CustomText(
                              text: 'Id',
                              textAlign: TextAlign.center,
                              weight: FontWeight.bold),
                          onSort: (columnIndex, ascending) => context
                              .read<TeknisiBloc>()
                              .add(SortTeknisiEvent(columnIndex, ascending)),
                        ),
                        DataColumn2(
                          label: const CustomText(
                              text: 'Username',
                              textAlign: TextAlign.center,
                              weight: FontWeight.bold),
                          onSort: (columnIndex, ascending) => context
                              .read<TeknisiBloc>()
                              .add(SortTeknisiEvent(columnIndex, ascending)),
                        ),
                        DataColumn2(
                          label: const CustomText(
                              text: 'Nama',
                              textAlign: TextAlign.center,
                              weight: FontWeight.bold),
                          onSort: (columnIndex, ascending) => context
                              .read<TeknisiBloc>()
                              .add(SortTeknisiEvent(columnIndex, ascending)),
                        ),
                        DataColumn2(
                          // fixedWidth: 120,
                          label: const CustomText(
                              text: 'Sektor',
                              textAlign: TextAlign.center,
                              weight: FontWeight.bold),
                          onSort: (columnIndex, ascending) => context
                              .read<TeknisiBloc>()
                              .add(SortTeknisiEvent(columnIndex, ascending)),
                        ),
                        DataColumn2(
                          label: const CustomText(
                              text: 'Keterangan',
                              textAlign: TextAlign.center,
                              weight: FontWeight.bold),
                          onSort: (columnIndex, ascending) => context
                              .read<TeknisiBloc>()
                              .add(SortTeknisiEvent(columnIndex, ascending)),
                        ),
                        DataColumn2(
                          label: const CustomText(
                              text: 'CreatedAt',
                              textAlign: TextAlign.center,
                              weight: FontWeight.bold),
                          onSort: (columnIndex, ascending) => context
                              .read<TeknisiBloc>()
                              .add(SortTeknisiEvent(columnIndex, ascending)),
                        ),
                      ],
                      sortColumnIndex: state.sortColumnIndex,
                      sortAscending: state.sortAscending,
                      rows: state.result
                          .map((data) => DataRow(cells: [
                                DataCell(CustomText(
                                    text: data.idteknisi.toString())),
                                DataCell(CustomText(text: data.username)),
                                DataCell(CustomText(text: data.nama)),
                                DataCell(CustomText(text: data.sektor)),
                                DataCell(CustomText(text: data.ket)),
                                DataCell(CustomText(
                                    text: data.createdAt.toString())),
                              ]))
                          .toList());
                } else if (state.status == TeknisiStatus.empty) {
                  return const Center(
                    child: CustomText(text: 'Data Kosong'),
                  );
                } else if (state.status == TeknisiStatus.error) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText(text: 'Terjadi Kesalahan!'),
                        const SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<TeknisiBloc>()
                                  .add(FetchAllTeknisi());
                            },
                            child: const CustomText(text: 'Coba Lagi'))
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
