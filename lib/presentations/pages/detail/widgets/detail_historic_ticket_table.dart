import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/domain/entities/data_table_source_tiket.dart';
import 'package:telkom_ticket_manager/presentations/blocs/detail_historic_tiket_bloc/detail_historic_tiket_bloc.dart';
import 'package:telkom_ticket_manager/utils/responsivennes.dart';
import 'package:telkom_ticket_manager/utils/style.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class DetailHistoricTicketTable extends StatefulWidget {
  const DetailHistoricTicketTable({super.key});

  @override
  State<DetailHistoricTicketTable> createState() =>
      _DetailHistoricTicketTableState();
}

class _DetailHistoricTicketTableState extends State<DetailHistoricTicketTable> {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: "History Ticket Table",
                  color: lightGrey,
                  weight: FontWeight.bold),
              SizedBox(
                width: ResponsiveWidget.isSmallScreen(context) ? 200 : 300,
                child: TextField(
                  style: const TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                      isDense: true,
                      labelStyle: const TextStyle(fontSize: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: const Icon(Icons.search_outlined),
                      labelText: "Search",
                      contentPadding: const EdgeInsets.all(12),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0))),
                  onChanged: (value) => context
                      .read<DetailHistoricTiketBloc>()
                      .add(SearchDetailHistoricTiket(query: value)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child:
                BlocBuilder<DetailHistoricTiketBloc, DetailHistoricTiketState>(
              builder: (context, state) {
                if (state.status == DetailHistoricTiketStatus.empty) {
                  return const Center(
                    child: CustomText(text: 'Data Kosong!'),
                  );
                }
                return Theme(
                  data: Theme.of(context).copyWith(
                    dataTableTheme: DataTableThemeData(
                      headingRowColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                        // Set color for data rows
                        return Colors.grey.shade200; // example color
                      }),
                    ),
                  ),
                  child: PaginatedDataTable2(
                    showCheckboxColumn: false,
                    wrapInCard: false,
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 2000,
                    renderEmptyRowsInTheEnd: false,
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
                            .read<DetailHistoricTiketBloc>()
                            .add(SortDetailHistoricTiket(
                                columnIndex, ascending)),
                      ),
                      DataColumn2(
                        fixedWidth: 200,
                        label: const CustomText(
                            text: 'Nama Pelanggan',
                            textAlign: TextAlign.center,
                            weight: FontWeight.bold),
                        onSort: (columnIndex, ascending) => context
                            .read<DetailHistoricTiketBloc>()
                            .add(SortDetailHistoricTiket(
                                columnIndex, ascending)),
                      ),
                      DataColumn2(
                        fixedWidth: 200,
                        label: const CustomText(
                            text: 'Alamat',
                            textAlign: TextAlign.center,
                            weight: FontWeight.bold),
                        onSort: (columnIndex, ascending) => context
                            .read<DetailHistoricTiketBloc>()
                            .add(SortDetailHistoricTiket(
                                columnIndex, ascending)),
                      ),
                      DataColumn2(
                        fixedWidth: 200,
                        label: const CustomText(
                            text: 'Keluhan',
                            textAlign: TextAlign.center,
                            weight: FontWeight.bold),
                        onSort: (columnIndex, ascending) => context
                            .read<DetailHistoricTiketBloc>()
                            .add(SortDetailHistoricTiket(
                                columnIndex, ascending)),
                      ),
                      DataColumn2(
                        fixedWidth: 200,
                        label: const CustomText(
                            text: 'ODP',
                            textAlign: TextAlign.center,
                            weight: FontWeight.bold),
                        onSort: (columnIndex, ascending) => context
                            .read<DetailHistoricTiketBloc>()
                            .add(SortDetailHistoricTiket(
                                columnIndex, ascending)),
                      ),
                      DataColumn2(
                        fixedWidth: 220,
                        label: const CustomText(
                            text: 'Waktu Mulai',
                            textAlign: TextAlign.center,
                            weight: FontWeight.bold),
                        onSort: (columnIndex, ascending) => context
                            .read<DetailHistoricTiketBloc>()
                            .add(SortDetailHistoricTiket(
                                columnIndex, ascending)),
                      ),
                      DataColumn2(
                        fixedWidth: 220,
                        label: const CustomText(
                            text: 'Waktu Selesai',
                            textAlign: TextAlign.center,
                            weight: FontWeight.bold),
                        onSort: (columnIndex, ascending) => context
                            .read<DetailHistoricTiketBloc>()
                            .add(SortDetailHistoricTiket(
                                columnIndex, ascending)),
                      ),
                      DataColumn2(
                        fixedWidth: 200,
                        label: const CustomText(
                            text: 'Durasi Pengerjaan',
                            textAlign: TextAlign.center,
                            weight: FontWeight.bold),
                        onSort: (columnIndex, ascending) => context
                            .read<DetailHistoricTiketBloc>()
                            .add(SortDetailHistoricTiket(
                                columnIndex, ascending)),
                      ),
                      DataColumn2(
                        label: const CustomText(
                            text: 'Teknisi',
                            textAlign: TextAlign.center,
                            weight: FontWeight.bold),
                        onSort: (columnIndex, ascending) => context
                            .read<DetailHistoricTiketBloc>()
                            .add(SortDetailHistoricTiket(
                                columnIndex, ascending)),
                      ),
                      DataColumn2(
                        label: const CustomText(
                            text: 'Tipe',
                            textAlign: TextAlign.center,
                            weight: FontWeight.bold),
                        onSort: (columnIndex, ascending) => context
                            .read<DetailHistoricTiketBloc>()
                            .add(SortDetailHistoricTiket(
                                columnIndex, ascending)),
                      ),
                      DataColumn2(
                        label: const CustomText(
                            text: 'Status',
                            textAlign: TextAlign.center,
                            weight: FontWeight.bold),
                        onSort: (columnIndex, ascending) => context
                            .read<DetailHistoricTiketBloc>()
                            .add(SortDetailHistoricTiket(
                                columnIndex, ascending)),
                      ),
                    ],
                    source: state.isFiltered
                        ? DataTableSourceTiket(state.filteredResult,
                            isHistory: true)
                        : DataTableSourceTiket(state.result, isHistory: true),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
