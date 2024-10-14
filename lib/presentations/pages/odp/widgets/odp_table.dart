import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telkom_ticket_manager/domain/entities/data_table_source_odp.dart';
import 'package:telkom_ticket_manager/presentations/blocs/odp_bloc/odp_bloc.dart';
import 'package:telkom_ticket_manager/utils/responsivennes.dart';
import 'package:telkom_ticket_manager/utils/style.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class OdpTable extends StatelessWidget {
  const OdpTable({super.key});

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
                  text: "ODP Table", color: lightGrey, weight: FontWeight.bold),
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
                  onChanged: (value) =>
                      context.read<OdpBloc>().add(SearchOdp(query: value)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: BlocBuilder<OdpBloc, OdpState>(
              builder: (context, state) {
                if (state.status == OdpStatus.empty) {
                  return const Center(
                    child: CustomText(text: 'Data Kosong!'),
                  );
                } else if (state.status == OdpStatus.loaded) {
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
                      // minWidth: 1500,
                      showCheckboxColumn: false,
                      sortColumnIndex: state.sortColumnIndex,
                      sortAscending: state.sortAscending,
                      columns: [
                        DataColumn2(
                          label: const CustomText(
                              text: 'ID ODP',
                              textAlign: TextAlign.center,
                              weight: FontWeight.bold),
                          onSort: (columnIndex, ascending) => context
                              .read<OdpBloc>()
                              .add(SortOdp(columnIndex, ascending)),
                        ),
                        DataColumn2(
                          label: const CustomText(
                              text: 'CreatedAt',
                              textAlign: TextAlign.center,
                              weight: FontWeight.bold),
                          onSort: (columnIndex, ascending) => context
                              .read<OdpBloc>()
                              .add(SortOdp(columnIndex, ascending)),
                        ),
                        DataColumn2(
                          label: const CustomText(
                              text: 'UpdatedAt',
                              textAlign: TextAlign.center,
                              weight: FontWeight.bold),
                          onSort: (columnIndex, ascending) => context
                              .read<OdpBloc>()
                              .add(SortOdp(columnIndex, ascending)),
                        ),
                      ],
                      source: state.isFiltered
                          ? DataTableSourceOdp(
                              context,
                              state.filteredResult,
                            )
                          : DataTableSourceOdp(
                              context,
                              state.result,
                            ),
                    ),
                  );
                } else if (state.status == OdpStatus.empty) {
                  return const Center(
                    child: CustomText(text: 'Data Kosong'),
                  );
                } else if (state.status == OdpStatus.error) {
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
                              context.read<OdpBloc>().add(FetchOdp());
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
