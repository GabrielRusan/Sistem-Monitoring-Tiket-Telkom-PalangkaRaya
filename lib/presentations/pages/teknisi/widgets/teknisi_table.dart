import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/domain/entities/data_table_source_teknisi.dart';
import 'package:telkom_ticket_manager/presentations/blocs/teknisi_bloc/teknisi_bloc.dart';
import 'package:telkom_ticket_manager/presentations/widgets/add_button.dart';
import 'package:telkom_ticket_manager/utils/responsivennes.dart';
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
              Row(
                children: [
                  CustomText(
                      text: "Teknisi Table",
                      color: lightGrey,
                      weight: FontWeight.bold),
                  const SizedBox(
                    width: 16,
                  ),
                  AddButton(onTap: () {}),
                ],
              ),
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
                      .read<TeknisiBloc>()
                      .add(SearchTeknisi(query: value)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: BlocBuilder<TeknisiBloc, TeknisiState>(
              builder: (context, state) {
                if (state.status == TeknisiStatus.empty) {
                  return const Center(
                    child: CustomText(text: 'Data Kosong!'),
                  );
                } else if (state.status == TeknisiStatus.loaded) {
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
                      wrapInCard: false,
                      renderEmptyRowsInTheEnd: false,
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 1500,
                      showCheckboxColumn: false,
                      sortColumnIndex: state.sortColumnIndex,
                      sortAscending: state.sortAscending,
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
                              text: 'Password',
                              textAlign: TextAlign.center,
                              weight: FontWeight.bold),
                          onSort: (columnIndex, ascending) => context
                              .read<TeknisiBloc>()
                              .add(SortTeknisiEvent(columnIndex, ascending)),
                        ),
                        DataColumn2(
                          fixedWidth: 100,
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
                        const DataColumn2(
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  text: 'Action', weight: FontWeight.bold),
                            ],
                          ),
                        ),
                      ],
                      source: state.isFiltered
                          ? DataTableSourceTeknisi(
                              context, state.filteredResult)
                          : DataTableSourceTeknisi(context, state.result),
                    ),
                  );
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
