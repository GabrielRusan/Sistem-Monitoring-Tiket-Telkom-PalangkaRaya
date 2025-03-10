import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:telkom_ticket_manager/domain/entities/data_table_source_absence.dart';
import 'package:telkom_ticket_manager/presentations/blocs/rekap_absen_bloc/rekap_absen_bloc.dart';
import 'package:telkom_ticket_manager/presentations/pages/absence/widgets/absence_filter_dropdown.dart';
import 'package:telkom_ticket_manager/presentations/pages/absence/widgets/absence_info_card.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';
import 'package:telkom_ticket_manager/utils/controllers.dart';
import 'package:telkom_ticket_manager/utils/responsivennes.dart';
import 'package:telkom_ticket_manager/utils/style.dart';

class AbsencePage extends StatelessWidget {
  const AbsencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 16),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                )
              ],
            )),
        const SizedBox(
          height: 16,
        ),
        BlocBuilder<RekapAbsenBloc, RekapAbsenState>(
          builder: (context, state) {
            if (state is RekapAbsenLoading) {
              return const Expanded(
                  child: Center(
                child: CircularProgressIndicator(),
              ));
            } else if (state is RekapAbsenError) {
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomText(text: 'Terjadi Kesalahan'),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context
                              .read<RekapAbsenBloc>()
                              .add(const FetchRekapAbsen(filter: 'today'));
                        },
                        child: const CustomText(
                          text: 'Try again',
                        ))
                  ],
                ),
              );
            } else if (state is RekapAbsenLoaded) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AbsenceFilterDropdown(
                            filter: state.filter,
                            tanggalRangeCustom: state.tanggalRangeCustom,
                          ),
                          // Container()
                          //   mouseCursor: SystemMouseCursors.click,
                          //   onTap: () {

                          //   },
                          //   child: Container(
                          //     padding: const EdgeInsets.all(10),
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(6),
                          //         border:
                          //             Border.all(color: Colors.grey.shade300)),
                          //     child: const Row(
                          //       children: [
                          //         Icon(
                          //           Icons.calendar_month_outlined,
                          //           // color: Colors.white,
                          //         ),
                          //         SizedBox(
                          //           width: 4,
                          //         ),
                          //         CustomText(
                          //           text: '16 Feb 2025',
                          //           // color: Colors.white,
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            mouseCursor: SystemMouseCursors.click,
                            onTap: () {
                              context.read<RekapAbsenBloc>().add(DownloadPdf(
                                    rekapAbsen: state.rekapAbsen,
                                    filter: state.filter,
                                    rangeTanggalCustom:
                                        state.tanggalRangeCustom,
                                  ));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: lightActive,
                                  borderRadius: BorderRadius.circular(6)),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.download,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  CustomText(
                                    text: 'Download data',
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: AbsenceInfoCard(
                            icon: Icons.check_circle_rounded,
                            title: 'Total Teknisi Hadir',
                            value:
                                state.rekapAbsen.summary.totalHadir.toString(),
                            isUseChip: true,
                            chipValue: '1 orang',
                            subTitle: 'dibanding kemarin',
                          )),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: AbsenceInfoCard(
                            icon: Icons.access_time,
                            title: 'Total Teknisi Tidak Hadir',
                            value: state.rekapAbsen.summary.totalTidakHadir
                                .toString(),
                            isUseChip: true,
                            chipValue: '1 orang',
                            isArrowUpward: false,
                            subTitle: 'dibanding kemarin',
                          )),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: AbsenceInfoCard(
                            icon: Icons.person_2_outlined,
                            title: 'Total Teknisi',
                            value: state.rekapAbsen.summary.totalTeknisi
                                .toString(),
                            isUseChip: false,
                            isArrowUpward: false,
                            subTitle: 'Tidak Ada Perubahan',
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: AbsenceInfoCard(
                            icon: Icons.confirmation_num_outlined,
                            title: 'Rata-rata Total Tiket',
                            value: state.rekapAbsen.summary.rataRataTotalTiket
                                .toString(),
                            isUseChip: true,
                            chipValue: '1 tiket',
                            isArrowUpward: false,
                            subTitle: 'dibanding kemarin',
                          )),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: AbsenceInfoCard(
                            icon: Icons.access_time_filled,
                            title: 'Rata-rata Waktu Kerja (menit)',
                            value: state.rekapAbsen.summary.rataRataWaktuKerja
                                .toString(),
                            isUseChip: true,
                            chipValue: '5.2 menit',
                            isArrowUpward: true,
                            subTitle: 'dibanding kemarin',
                          )),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: AbsenceInfoCard(
                            icon: Icons.access_time_filled,
                            title: 'Rata-rata Waktu Penyelesaian (menit)',
                            value: state
                                .rekapAbsen.summary.rataRataWaktuPenyelesaian
                                .toString(),
                            isUseChip: true,
                            chipValue: '15.7 menit',
                            isArrowUpward: true,
                            isGreen: false,
                            subTitle: 'dibanding kemarin',
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                        margin: const EdgeInsets.only(bottom: 24),
                        width: double.infinity,
                        height: 700,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white),
                        child: state.rekapAbsen.data.isEmpty
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.description,
                                        color: lightActive,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const CustomText(
                                        text: 'Riwayat Absensi',
                                        size: 14,
                                        weight: FontWeight.w700,
                                      )
                                    ],
                                  ),
                                  const Expanded(
                                    child: Center(
                                      child: CustomText(
                                        text: 'Data Kosong!',
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.description,
                                        color: lightActive,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const CustomText(
                                        text: 'Riwayat Absensi',
                                        size: 14,
                                        weight: FontWeight.w700,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade200),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      context
                                          .read<RekapAbsenBloc>()
                                          .add(SearchRekapAbsen(
                                            query: value,
                                            rekapAbsen: state.rekapAbsen,
                                            filter: state.filter,
                                            tanggalRangeCustom:
                                                state.tanggalRangeCustom,
                                          ));
                                    },
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                    child: PaginatedDataTable2(
                                        sortAscending: state.sortAscending,
                                        sortColumnIndex: state.sortColumnIndex,
                                        columns: [
                                          DataColumn2(
                                            label: const CustomText(
                                              text: 'ID',
                                              // color: Colors.grey,
                                              weight: FontWeight.w700,
                                              size: 13,
                                            ),
                                            size: ColumnSize.S,
                                            onSort: (columnIndex, ascending) => context
                                                .read<RekapAbsenBloc>()
                                                .add(SortRekapAbsen(
                                                    columnIndex: columnIndex,
                                                    ascending: ascending,
                                                    rekapAbsen:
                                                        state.rekapAbsen,
                                                    filter: state.filter,
                                                    tanggalRangeCustom: state
                                                        .tanggalRangeCustom,
                                                    searchedOrSortedAbsen: state
                                                        .searchedOrSortedAbsenList)),
                                          ),
                                          DataColumn2(
                                            label: const CustomText(
                                              text: 'ID Teknisi',
                                              // color: Colors.grey,
                                              weight: FontWeight.w700,
                                              size: 13,
                                            ),
                                            onSort: (columnIndex, ascending) => context
                                                .read<RekapAbsenBloc>()
                                                .add(SortRekapAbsen(
                                                    columnIndex: columnIndex,
                                                    ascending: ascending,
                                                    rekapAbsen:
                                                        state.rekapAbsen,
                                                    filter: state.filter,
                                                    tanggalRangeCustom: state
                                                        .tanggalRangeCustom,
                                                    searchedOrSortedAbsen: state
                                                        .searchedOrSortedAbsenList)),
                                          ),
                                          DataColumn2(
                                            label: const CustomText(
                                              text: 'Nama',
                                              // color: Colors.grey,
                                              weight: FontWeight.w700,
                                              size: 13,
                                            ),
                                            onSort: (columnIndex, ascending) => context
                                                .read<RekapAbsenBloc>()
                                                .add(SortRekapAbsen(
                                                    columnIndex: columnIndex,
                                                    ascending: ascending,
                                                    rekapAbsen:
                                                        state.rekapAbsen,
                                                    filter: state.filter,
                                                    tanggalRangeCustom: state
                                                        .tanggalRangeCustom,
                                                    searchedOrSortedAbsen: state
                                                        .searchedOrSortedAbsenList)),
                                          ),
                                          DataColumn2(
                                            label: const CustomText(
                                              text: 'Tanggal',
                                              // color: Colors.grey,
                                              weight: FontWeight.w700,
                                              size: 13,
                                            ),
                                            onSort: (columnIndex, ascending) => context
                                                .read<RekapAbsenBloc>()
                                                .add(SortRekapAbsen(
                                                    columnIndex: columnIndex,
                                                    ascending: ascending,
                                                    rekapAbsen:
                                                        state.rekapAbsen,
                                                    filter: state.filter,
                                                    tanggalRangeCustom: state
                                                        .tanggalRangeCustom,
                                                    searchedOrSortedAbsen: state
                                                        .searchedOrSortedAbsenList)),
                                          ),
                                          DataColumn2(
                                            label: const CustomText(
                                              text: 'Jam Masuk',
                                              // color: Colors.grey,
                                              weight: FontWeight.w700,
                                              size: 13,
                                            ),
                                            onSort: (columnIndex, ascending) => context
                                                .read<RekapAbsenBloc>()
                                                .add(SortRekapAbsen(
                                                    columnIndex: columnIndex,
                                                    ascending: ascending,
                                                    rekapAbsen:
                                                        state.rekapAbsen,
                                                    filter: state.filter,
                                                    tanggalRangeCustom: state
                                                        .tanggalRangeCustom,
                                                    searchedOrSortedAbsen: state
                                                        .searchedOrSortedAbsenList)),
                                          ),
                                          DataColumn2(
                                            label: const CustomText(
                                              text: 'Jam Keluar',
                                              // color: Colors.grey,
                                              weight: FontWeight.w700,
                                              size: 13,
                                            ),
                                            onSort: (columnIndex, ascending) => context
                                                .read<RekapAbsenBloc>()
                                                .add(SortRekapAbsen(
                                                    columnIndex: columnIndex,
                                                    ascending: ascending,
                                                    rekapAbsen:
                                                        state.rekapAbsen,
                                                    filter: state.filter,
                                                    tanggalRangeCustom: state
                                                        .tanggalRangeCustom,
                                                    searchedOrSortedAbsen: state
                                                        .searchedOrSortedAbsenList)),
                                          ),
                                          DataColumn2(
                                            label: const CustomText(
                                              text: 'Total Waktu Kerja (menit)',
                                              // color: Colors.grey,
                                              weight: FontWeight.w700,
                                              size: 13,
                                            ),
                                            fixedWidth: 220,
                                            onSort: (columnIndex, ascending) => context
                                                .read<RekapAbsenBloc>()
                                                .add(SortRekapAbsen(
                                                    columnIndex: columnIndex,
                                                    ascending: ascending,
                                                    rekapAbsen:
                                                        state.rekapAbsen,
                                                    filter: state.filter,
                                                    tanggalRangeCustom: state
                                                        .tanggalRangeCustom,
                                                    searchedOrSortedAbsen: state
                                                        .searchedOrSortedAbsenList)),
                                          ),
                                          DataColumn2(
                                            label: const CustomText(
                                              text: 'Total Tiket',
                                              // color: Colors.grey,
                                              weight: FontWeight.w700,
                                              size: 13,
                                            ),
                                            onSort: (columnIndex, ascending) => context
                                                .read<RekapAbsenBloc>()
                                                .add(SortRekapAbsen(
                                                    columnIndex: columnIndex,
                                                    ascending: ascending,
                                                    rekapAbsen:
                                                        state.rekapAbsen,
                                                    filter: state.filter,
                                                    tanggalRangeCustom: state
                                                        .tanggalRangeCustom,
                                                    searchedOrSortedAbsen: state
                                                        .searchedOrSortedAbsenList)),
                                          ),
                                          DataColumn2(
                                            label: const CustomText(
                                              text:
                                                  'Rata-rata Penyelesaian (menit)',
                                              // color: Colors.grey,
                                              weight: FontWeight.w700,
                                              size: 13,
                                            ),
                                            fixedWidth: 250,
                                            onSort: (columnIndex, ascending) => context
                                                .read<RekapAbsenBloc>()
                                                .add(SortRekapAbsen(
                                                    columnIndex: columnIndex,
                                                    ascending: ascending,
                                                    rekapAbsen:
                                                        state.rekapAbsen,
                                                    filter: state.filter,
                                                    tanggalRangeCustom: state
                                                        .tanggalRangeCustom,
                                                    searchedOrSortedAbsen: state
                                                        .searchedOrSortedAbsenList)),
                                          ),
                                          DataColumn2(
                                            label: const CustomText(
                                              text: 'Status',
                                              // color: Colors.grey,
                                              weight: FontWeight.w700,
                                              size: 13,
                                            ),
                                            onSort: (columnIndex, ascending) => context
                                                .read<RekapAbsenBloc>()
                                                .add(SortRekapAbsen(
                                                    columnIndex: columnIndex,
                                                    ascending: ascending,
                                                    rekapAbsen:
                                                        state.rekapAbsen,
                                                    filter: state.filter,
                                                    tanggalRangeCustom: state
                                                        .tanggalRangeCustom,
                                                    searchedOrSortedAbsen: state
                                                        .searchedOrSortedAbsenList)),
                                          ),
                                        ],
                                        headingRowColor:
                                            WidgetStateColor.resolveWith(
                                                (states) =>
                                                    Colors.grey.shade50),
                                        dataRowHeight: 55,
                                        headingRowHeight: 40,
                                        wrapInCard: false,
                                        dividerThickness: 0.3,
                                        renderEmptyRowsInTheEnd: false,
                                        minWidth: 2000,
                                        source: DataTableSourceAbsence(
                                          context,
                                          state.searchedOrSortedAbsenList ??
                                              state.rekapAbsen.data,
                                        )),
                                  )
                                ],
                              ),
                      )
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),

        // SizedBox(height:16),
        // Expanded(child: child)
      ],
    );
  }
}
