import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/presentations/blocs/active_tiket_bloc/active_tiket_bloc.dart';
import 'package:telkom_ticket_manager/utils/style.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class TicketTable extends StatefulWidget {
  const TicketTable({super.key});

  @override
  State<TicketTable> createState() => _TicketTableState();
}

class _TicketTableState extends State<TicketTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
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
            children: [
              const SizedBox(width: 10),
              CustomText(
                  text: "Ticket Table",
                  color: lightGrey,
                  weight: FontWeight.bold),
            ],
          ),
          SizedBox(
            height: 440,
            child: BlocBuilder<ActiveTiketBloc, ActiveTiketState>(
              builder: (context, state) {
                return DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 1500,
                  sortAscending: state.sortAscending,
                  sortColumnIndex: state.sortColumnIndex,
                  columns: [
                    DataColumn2(
                      fixedWidth: 100,
                      label: const CustomText(
                          text: 'No. Tiket',
                          textAlign: TextAlign.center,
                          weight: FontWeight.bold),
                      onSort: (columnIndex, ascending) => context
                          .read<ActiveTiketBloc>()
                          .add(SortActiveTiket(columnIndex, ascending)),
                    ),
                    DataColumn2(
                      label: const CustomText(
                          text: 'Nama Pelanggan',
                          textAlign: TextAlign.center,
                          weight: FontWeight.bold),
                      onSort: (columnIndex, ascending) => context
                          .read<ActiveTiketBloc>()
                          .add(SortActiveTiket(columnIndex, ascending)),
                    ),
                    DataColumn2(
                      size: ColumnSize.L,
                      label: const CustomText(
                          text: 'Alamat',
                          textAlign: TextAlign.center,
                          weight: FontWeight.bold),
                      onSort: (columnIndex, ascending) => context
                          .read<ActiveTiketBloc>()
                          .add(SortActiveTiket(columnIndex, ascending)),
                    ),
                    DataColumn2(
                      size: ColumnSize.L,
                      label: const CustomText(
                          text: 'Keluhan',
                          textAlign: TextAlign.center,
                          weight: FontWeight.bold),
                      onSort: (columnIndex, ascending) => context
                          .read<ActiveTiketBloc>()
                          .add(SortActiveTiket(columnIndex, ascending)),
                    ),
                    DataColumn2(
                      size: ColumnSize.L,
                      label: const CustomText(
                          text: 'Odp',
                          textAlign: TextAlign.center,
                          weight: FontWeight.bold),
                      onSort: (columnIndex, ascending) => context
                          .read<ActiveTiketBloc>()
                          .add(SortActiveTiket(columnIndex, ascending)),
                    ),
                    DataColumn2(
                      label: const CustomText(
                          text: 'Start Time',
                          textAlign: TextAlign.center,
                          weight: FontWeight.bold),
                      onSort: (columnIndex, ascending) => context
                          .read<ActiveTiketBloc>()
                          .add(SortActiveTiket(columnIndex, ascending)),
                    ),
                    DataColumn2(
                      label: const CustomText(
                          text: 'Teknisi',
                          textAlign: TextAlign.center,
                          weight: FontWeight.bold),
                      onSort: (columnIndex, ascending) => context
                          .read<ActiveTiketBloc>()
                          .add(SortActiveTiket(columnIndex, ascending)),
                    ),
                    DataColumn2(
                      label: const CustomText(
                          text: 'Tipe',
                          textAlign: TextAlign.center,
                          weight: FontWeight.bold),
                      onSort: (columnIndex, ascending) => context
                          .read<ActiveTiketBloc>()
                          .add(SortActiveTiket(columnIndex, ascending)),
                    ),
                    DataColumn2(
                      label: const CustomText(
                          text: 'Status',
                          textAlign: TextAlign.center,
                          weight: FontWeight.bold),
                      onSort: (columnIndex, ascending) => context
                          .read<ActiveTiketBloc>()
                          .add(SortActiveTiket(columnIndex, ascending)),
                    ),
                  ],
                  rows: state.result
                      .map((data) => DataRow(
                            cells: [
                              DataCell(CustomText(text: data.nomorTiket)),
                              DataCell(CustomText(text: data.pelanggan.nama)),
                              DataCell(CustomText(text: data.pelanggan.alamat)),
                              DataCell(CustomText(text: data.keluhan)),
                              DataCell(CustomText(text: data.idOdp)),
                              DataCell(
                                  CustomText(text: data.createdAt.toString())),
                              DataCell(CustomText(text: data.namaTeknisi)),
                              DataCell(CustomText(text: data.type)),
                              DataCell(CustomText(text: data.status)),
                            ],
                          ))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
