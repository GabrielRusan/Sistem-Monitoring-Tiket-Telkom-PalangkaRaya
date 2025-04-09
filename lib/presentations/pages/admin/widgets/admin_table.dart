import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_ticket_manager/domain/entities/data_table_source_admin.dart';
import 'package:telkom_ticket_manager/injection.dart';
import 'package:telkom_ticket_manager/presentations/blocs/admin_bloc/admin_bloc.dart';
import 'package:telkom_ticket_manager/presentations/widgets/styled_paginataed_table.dart';
import 'package:telkom_ticket_manager/utils/responsivennes.dart';
import 'package:telkom_ticket_manager/utils/style.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class AdminTable extends StatelessWidget {
  const AdminTable({super.key});

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
                text: "Admin Table",
                color: lightGrey,
                weight: FontWeight.w700,
                size: 13,
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
                  onChanged: (value) =>
                      context.read<AdminBloc>().add(SearchAdmin(query: value)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                if (state.status == AdminStatus.empty) {
                  return const Center(
                    child: CustomText(text: 'Data Kosong!'),
                  );
                } else if (state.status == AdminStatus.loaded) {
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
                    child: StyledPaginataedTable(
                      minWidth: 0,
                      sortColumnIndex: state.sortColumnIndex,
                      sortAscending: state.sortAscending,
                      columns: [
                        DataColumn2(
                          fixedWidth: 100,
                          label: const CustomText(
                            text: 'Id',
                            textAlign: TextAlign.center,
                            weight: FontWeight.w700,
                            size: 13,
                          ),
                          onSort: (columnIndex, ascending) => context
                              .read<AdminBloc>()
                              .add(SortAdminEvent(columnIndex, ascending)),
                        ),
                        DataColumn2(
                          label: const CustomText(
                            text: 'Username',
                            textAlign: TextAlign.center,
                            weight: FontWeight.w700,
                            size: 13,
                          ),
                          onSort: (columnIndex, ascending) => context
                              .read<AdminBloc>()
                              .add(SortAdminEvent(columnIndex, ascending)),
                        ),
                        DataColumn2(
                          label: const CustomText(
                            text: 'Nama',
                            textAlign: TextAlign.center,
                            weight: FontWeight.w700,
                            size: 13,
                          ),
                          onSort: (columnIndex, ascending) => context
                              .read<AdminBloc>()
                              .add(SortAdminEvent(columnIndex, ascending)),
                        ),
                        const DataColumn2(
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'Action',
                                weight: FontWeight.w700,
                                size: 13,
                              ),
                            ],
                          ),
                        ),
                      ],
                      source: state.isFiltered
                          ? DataTableSourceAdmin(context, state.filteredResult,
                              locator.get<SharedPreferences>())
                          : DataTableSourceAdmin(context, state.result,
                              locator.get<SharedPreferences>()),
                    ),
                  );
                } else if (state.status == AdminStatus.empty) {
                  return const Center(
                    child: CustomText(text: 'Data Kosong'),
                  );
                } else if (state.status == AdminStatus.error) {
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
                              context.read<AdminBloc>().add(FetchAllAdmin());
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
