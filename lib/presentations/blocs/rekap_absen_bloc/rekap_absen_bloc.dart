import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:telkom_ticket_manager/data/models/rekap_model.dart';
import 'package:telkom_ticket_manager/domain/entities/rekap_absen.dart';
import 'package:telkom_ticket_manager/domain/repositories/rekap_absen_repository.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

part 'rekap_absen_event.dart';
part 'rekap_absen_state.dart';

class RekapAbsenBloc extends Bloc<RekapAbsenEvent, RekapAbsenState> {
  final RekapAbsenRepository repository;
  RekapAbsenBloc(this.repository) : super(RekapAbsenInitial()) {
    on<FetchRekapAbsen>((event, emit) async {
      emit(RekapAbsenLoading());

      final result = await repository.getRekapAbsen(
          filter: event.filter, rangeTanggalCustom: event.rangeTanggalCustom);

      result.fold((failure) {
        emit(RekapAbsenError(message: failure.message));
      }, (data) {
        emit(RekapAbsenLoaded(
            rekapAbsen: data,
            filter: event.filter,
            tanggalRangeCustom: event.rangeTanggalCustom));
      });
    });
    on<DownloadPdf>((event, emit) async {
      DateTime hariIni = DateTime.now();
      final range = event.filter == 'kemarin'
          ? DateTimeRange(
              start: hariIni.subtract(const Duration(days: 1)), end: hariIni)
          : event.filter == '1_minggu'
              ? DateTimeRange(
                  start: hariIni.subtract(const Duration(days: 7)),
                  end: hariIni)
              : event.filter == '1_month'
                  ? DateTimeRange(
                      start: hariIni.subtract(const Duration(days: 30)),
                      end: hariIni)
                  : event.filter == 'custom'
                      ? event.rangeTanggalCustom!
                      : null;
      DateFormat dateFormat = DateFormat('EEEE, d MMMM yyyy', "id_ID");
      Map<DateTime, List<Absen>> groupedByDate = {};

      for (var absen in event.rekapAbsen.data) {
        DateTime dateKey = DateTime(
            absen.tanggal.year, absen.tanggal.month, absen.tanggal.day);

        if (!groupedByDate.containsKey(dateKey)) {
          groupedByDate[dateKey] = [];
        }
        groupedByDate[dateKey]!.add(absen);
      }

      // 2. Urutkan key berdasarkan tanggal (Ascending - Lama ke Baru)
      var sortedMap = Map.fromEntries(
        groupedByDate.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
      );

      final pdf = pw.Document();
      final img =
          await rootBundle.load('assets/icons/logo_telkom_lite_baru.png');
      final imageBytes = img.buffer.asUint8List();

      pw.Image logo =
          pw.Image(pw.MemoryImage(imageBytes), height: 55, width: 55);

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      pw.Container(
                          margin:
                              const pw.EdgeInsets.only(bottom: 12, left: 12),
                          height: 50,
                          width: 50,
                          child: logo),
                      pw.SizedBox(width: 36),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(
                            "PT. TELKOM PALANGKA RAYA",
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            "Kantor Pusat Telkom Palangka Raya Jalan Ahmad Yani Palangka Raya",
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            "Kalimantan Tengah - CS@telkomsel.com",
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Container(
                      // padding: pw.EdgeInsets.all(10),
                      alignment: pw.Alignment.center,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: 2)),
                      )),
                  pw.SizedBox(height: 16),
                  // Judul Laporan
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          'Rekap Absensi Telkom Palangka Raya',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold),
                        ),
                      ]),

                  pw.SizedBox(height: 16),

                  // START Periode
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text(
                          range != null
                              ? 'Periode : ${dateFormat.format(range.start)} - ${dateFormat.format(range.end)}'
                              : 'Periode : ${dateFormat.format(hariIni)}',
                          style: const pw.TextStyle(fontSize: 11),
                        ),
                      ]),
                  // END Periode

                  pw.SizedBox(height: 16),

                  // START Summary
                  pw.Text(
                    'Summary',
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Total Teknisi Hadir',
                        style: const pw.TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 6,
                      child: pw.Text(
                        ': ${event.rekapAbsen.summary.totalHadir}',
                        style: const pw.TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ]),
                  pw.SizedBox(height: 8),
                  pw.Row(children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Total Teknisi Tidak Hadir',
                        style: const pw.TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 6,
                      child: pw.Text(
                        ': ${event.rekapAbsen.summary.totalTidakHadir}',
                        style: const pw.TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ]),
                  pw.SizedBox(height: 8),
                  pw.Row(children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Total Teknisi',
                        style: const pw.TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 6,
                      child: pw.Text(
                        ': ${event.rekapAbsen.summary.totalTeknisi}',
                        style: const pw.TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ]),
                  pw.SizedBox(height: 8),
                  pw.Row(children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Rata-rata Total Tiket',
                        style: const pw.TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 6,
                      child: pw.Text(
                        ': ${event.rekapAbsen.summary.rataRataTotalTiket}',
                        style: const pw.TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ]),
                  pw.SizedBox(height: 8),
                  pw.Row(children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Rata-rata Waktu Kerja',
                        style: const pw.TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 6,
                      child: pw.Text(
                        ': ${event.rekapAbsen.summary.rataRataWaktuKerja} menit',
                        style: const pw.TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ]),
                  pw.SizedBox(height: 8),
                  pw.Row(children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Rata-rata Waktu Penyelesaian',
                        style: const pw.TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 6,
                      child: pw.Text(
                        ': ${event.rekapAbsen.summary.rataRataWaktuPenyelesaian} menit',
                        style: const pw.TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ]),
                  // END Summary

                  pw.SizedBox(height: 36),

                  // START Riwayat Absensi
                  pw.Text(
                    'Riwayat Absensi',
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 8),
                  for (MapEntry entry in sortedMap.entries) ...[
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Text(
                            dateFormat.format(entry.key),
                            style: pw.TextStyle(
                              fontSize: 11,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ]),
                    pw.SizedBox(height: 6),
                    pw.Container(
                        decoration: const pw.BoxDecoration(
                      border: pw.Border(bottom: pw.BorderSide(width: 1)),
                    )),
                    pw.SizedBox(height: 6),
                    for (int i = 0; i < entry.value.length; i++) ...[
                      pw.Text(
                        "${i + 1}. ${entry.value[i].nama}",
                        style: const pw.TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 20),
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 3,
                            child: pw.Text(
                              'ID Teknisi',
                              style: const pw.TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 6,
                            child: pw.Text(
                              ': ${entry.value[i].idTeknisi}',
                              style: const pw.TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 20),
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 3,
                            child: pw.Text(
                              'Jam Masuk',
                              style: const pw.TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 6,
                            child: pw.Text(
                              ': ${entry.value[i].jamMasuk}',
                              style: const pw.TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 20),
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 3,
                            child: pw.Text(
                              'Jam Keluar',
                              style: const pw.TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 6,
                            child: pw.Text(
                              ': ${entry.value[i].jamKeluar}',
                              style: const pw.TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 20),
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 3,
                            child: pw.Text(
                              'Total Waktu Kerja',
                              style: const pw.TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 6,
                            child: pw.Text(
                              ': ${entry.value[i].totalWaktuKerja} menit',
                              style: const pw.TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 20),
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 3,
                            child: pw.Text(
                              'Total Tiket',
                              style: const pw.TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 6,
                            child: pw.Text(
                              ': ${entry.value[i].totalTiket}',
                              style: const pw.TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 20),
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 3,
                            child: pw.Text(
                              'Rata-rata Penyelesaian',
                              style: const pw.TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 6,
                            child: pw.Text(
                              ': ${entry.value[i].rataRataPenyelesaian} menit',
                              style: const pw.TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 20),
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 3,
                            child: pw.Text(
                              'Status Kehadiran',
                              style: const pw.TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            flex: 6,
                            child: pw.Text(
                              ': ${entry.value[i].statusKehadiran}',
                              style: const pw.TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      pw.SizedBox(height: 6),
                    ],
                    pw.SizedBox(height: 12),
                  ]
                  // END Riwayat Absensi
                ],
              )
            ];
          },
        ),
      );

      // Konversi PDF ke format Uint8List
      Uint8List pdfBytes = await pdf.save();

      // Buat Blob dan trigger download
      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute("download",
            "Rekap Absen_${DateTime.now().millisecondsSinceEpoch}.pdf")
        ..click();

      // Hapus URL setelah download
      html.Url.revokeObjectUrl(url);
    });
    on<SearchRekapAbsen>((event, emit) async {
      if (event.query.isEmpty) {
        emit(RekapAbsenLoaded(
          rekapAbsen: event.rekapAbsen,
          filter: event.filter,
          tanggalRangeCustom: event.tanggalRangeCustom,
          searchedOrSortedAbsenList: null,
        ));
        return;
      }

      DateFormat dateFormat = DateFormat('EEEE, d MMMM yyyy', "id_ID");

      List<Absen> searchedAbsen = [];
      final String query = event.query.toLowerCase();

      for (Absen absen in event.rekapAbsen.data) {
        final String id = absen.id.toLowerCase();
        final String idTeknisi = absen.idTeknisi.toLowerCase();
        final String nama = absen.nama.toLowerCase();
        final String tanggal = dateFormat.format(absen.tanggal).toLowerCase();
        final String jamMasuk = absen.jamMasuk.toLowerCase();
        final String jamKeluar = absen.jamKeluar.toLowerCase();
        final String statusKehadiran = absen.statusKehadiran.toLowerCase();
        final String totalWaktuKerja = absen.totalWaktuKerja.toLowerCase();
        final String totalTiket = absen.totalTiket.toLowerCase();
        final String rataRataPenyelesaian =
            absen.rataRataPenyelesaian.toLowerCase();

        if (id.contains(query) ||
            idTeknisi.contains(query) ||
            nama.contains(query) ||
            tanggal.contains(query) ||
            jamMasuk.contains(query) ||
            jamKeluar.contains(query) ||
            totalWaktuKerja.contains(query) ||
            totalTiket.contains(query) ||
            rataRataPenyelesaian.contains(query) ||
            statusKehadiran.contains(query)) {
          searchedAbsen.add(absen);
        }
      }

      emit(RekapAbsenLoaded(
          rekapAbsen: event.rekapAbsen,
          filter: event.filter,
          tanggalRangeCustom: event.tanggalRangeCustom,
          searchedOrSortedAbsenList: searchedAbsen));
    });
    on<SortRekapAbsen>((event, emit) async {
      final Map<int, Function(Absen, Absen)> sortFunctions = {
        0: (a, b) => a.id.compareTo(b.id),
        1: (a, b) => a.idTeknisi.compareTo(b.idTeknisi),
        2: (a, b) => a.nama.compareTo(b.nama),
        3: (a, b) => a.tanggal.compareTo(b.tanggal),
        4: (a, b) => a.jamMasuk.compareTo(b.jamMasuk),
        5: (a, b) => a.jamKeluar.compareTo(b.jamKeluar),
        6: (a, b) => a.statusKehadiran.compareTo(b.statusKehadiran),
        7: (a, b) => a.totalWaktuKerja.compareTo(b.totalWaktuKerja),
        8: (a, b) => a.totalTiket.compareTo(b.totalTiket),
        9: (a, b) => a.rataRataPenyelesaian.compareTo(b.rataRataPenyelesaian),
      };

      if (event.searchedOrSortedAbsen != null) {
        List<Absen> sortedResult = List.from(event.searchedOrSortedAbsen!);
        final sortFunction = sortFunctions[event.columnIndex];

        if (sortFunction != null) {
          sortedResult.sort((a, b) =>
              event.ascending ? sortFunction(a, b) : sortFunction(b, a));
        }

        emit(RekapAbsenLoaded(
          rekapAbsen: event.rekapAbsen,
          filter: event.filter,
          tanggalRangeCustom: event.tanggalRangeCustom,
          searchedOrSortedAbsenList: sortedResult,
          sortAscending: event.ascending,
          sortColumnIndex: event.columnIndex,
        ));
        return;
      }

      List<Absen> sortedResult = List.from(event.rekapAbsen.data);
      final sortFunction = sortFunctions[event.columnIndex];

      if (sortFunction != null) {
        sortedResult.sort((a, b) =>
            event.ascending ? sortFunction(a, b) : sortFunction(b, a));
      }

      emit(RekapAbsenLoaded(
        rekapAbsen: event.rekapAbsen,
        filter: event.filter,
        tanggalRangeCustom: event.tanggalRangeCustom,
        searchedOrSortedAbsenList: sortedResult,
        sortAscending: event.ascending,
        sortColumnIndex: event.columnIndex,
      ));
    });
  }
}
