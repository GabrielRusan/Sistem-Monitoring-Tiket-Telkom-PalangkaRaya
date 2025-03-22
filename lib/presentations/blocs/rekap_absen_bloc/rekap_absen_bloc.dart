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

      pw.Container customRow(
          String no,
          String id,
          String nama,
          String jamMasuk,
          String jamKeluar,
          String totalWaktuKerja,
          String totalTiket,
          String rataRataPenyelesaian,
          String status) {
        List<String> jamMasukSplit = jamMasuk.split(':');
        List<String> jamKeluarSplit = jamKeluar.split(':');

        String newJamMasuk = '${jamMasukSplit[0]}:${jamMasukSplit[1]}';
        String newJamKeluar = '${jamKeluarSplit[0]}:${jamKeluarSplit[1]}';

        if (status == 'Tidak Hadir') {
          newJamMasuk = '-';
          newJamKeluar = '-';
        }

        String newRataRataPenyelesaian =
            rataRataPenyelesaian == '00:00:00' ? '0' : rataRataPenyelesaian;

        String newTotalWaktuKerja =
            totalWaktuKerja == '00:00:00' ? '0' : totalWaktuKerja;

        return pw.Container(
            decoration: const pw.BoxDecoration(
              // color: PdfColor.fromHex('#E6EEF7'),
              border: pw.Border(
                  right: pw.BorderSide(),
                  left: pw.BorderSide(),
                  bottom: pw.BorderSide()),
            ),
            height: 45,
            child: pw.Row(children: [
              pw.Expanded(
                flex: 2,
                child: pw.Text(no, textAlign: pw.TextAlign.center),
              ),
              pw.Container(
                  width: 1,
                  height: double.infinity,
                  color: PdfColor.fromHex('#000000')),
              pw.Expanded(
                flex: 4,
                child: pw.Text(id,
                    style: const pw.TextStyle(
                      fontSize: 11,
                    ),
                    textAlign: pw.TextAlign.center),
              ),
              pw.Container(
                  width: 1,
                  height: double.infinity,
                  color: PdfColor.fromHex('#000000')),
              pw.Expanded(
                flex: 4,
                child: pw.Text(nama,
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(
                      fontSize: 11,
                    )),
              ),
              pw.Container(
                  width: 1,
                  height: double.infinity,
                  color: PdfColor.fromHex('#000000')),
              pw.Expanded(
                flex: 3,
                child: pw.Text(newJamMasuk,
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(
                      fontSize: 11,
                    )),
              ),
              pw.Container(
                  width: 1,
                  height: double.infinity,
                  color: PdfColor.fromHex('#000000')),
              pw.Expanded(
                flex: 3,
                child: pw.Text(newJamKeluar,
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(
                      fontSize: 11,
                    )),
              ),
              pw.Container(
                  width: 1,
                  height: double.infinity,
                  color: PdfColor.fromHex('#000000')),
              pw.Expanded(
                flex: 4,
                child: pw.Text(newTotalWaktuKerja,
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(
                      fontSize: 11,
                    )),
              ),
              pw.Container(
                  width: 1,
                  height: double.infinity,
                  color: PdfColor.fromHex('#000000')),
              pw.Expanded(
                flex: 3,
                child: pw.Text(totalTiket,
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(
                      fontSize: 11,
                    )),
              ),
              pw.Container(
                  width: 1,
                  height: double.infinity,
                  color: PdfColor.fromHex('#000000')),
              pw.Expanded(
                flex: 5,
                child: pw.Text(newRataRataPenyelesaian,
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(
                      fontSize: 11,
                    )),
              ),
              pw.Container(
                  width: 1,
                  height: double.infinity,
                  color: PdfColor.fromHex('#000000')),
              pw.Expanded(
                flex: 3,
                child: pw.Text(status,
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(
                      fontSize: 11,
                    )),
              ),
            ]));
      }

      pw.TableRow summaryTableRow(
          {required String label,
          bool isCustom = false,
          bool isHadir = true,
          required dynamic value}) {
        if (isCustom) {
          Map<dynamic, dynamic> data = value.map((key, value) => MapEntry(
                key,
                isHadir
                    ? value
                        .where((obj) => obj.statusKehadiran == 'Hadir')
                        .length
                    : value
                        .where((obj) => obj.statusKehadiran == 'Tidak Hadir')
                        .length,
              ));
          return data.isEmpty
              ? pw.TableRow(
                  verticalAlignment: pw.TableCellVerticalAlignment.middle,
                  children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          label,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          '0 Teknisi',
                          style: const pw.TextStyle(fontSize: 11),
                        ),
                      ),
                    ])
              : pw.TableRow(
                  verticalAlignment: pw.TableCellVerticalAlignment.middle,
                  children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          label,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      pw.Table(border: pw.TableBorder.all(), children: [
                        pw.TableRow(
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                'Tanggal',
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 11),
                              ),
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                'Jumlah',
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                        for (MapEntry entry in data.entries)
                          pw.TableRow(
                            children: [
                              pw.Padding(
                                padding: const pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  dateFormat.format(entry.key),
                                  style: const pw.TextStyle(fontSize: 11),
                                ),
                              ),
                              pw.Padding(
                                padding: const pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  entry.value.toString(),
                                  style: const pw.TextStyle(fontSize: 11),
                                  textAlign: pw.TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                      ])
                    ]);
        }

        return pw.TableRow(
            verticalAlignment: pw.TableCellVerticalAlignment.middle,
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(
                  label,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(
                  value,
                  style: const pw.TextStyle(
                    fontSize: 11,
                  ),
                ),
              ),
            ]);
      }

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
                        fontSize: 14, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Table(border: pw.TableBorder.all(), columnWidths: {
                    0: const pw.FlexColumnWidth(1),
                    1: const pw.FlexColumnWidth(3),
                  }, children: [
                    summaryTableRow(
                        label: 'Total Teknisi Hadir',
                        isCustom: true,
                        isHadir: true,
                        value: sortedMap),
                    summaryTableRow(
                        label: 'Total Teknisi Tidak Hadir',
                        isCustom: true,
                        isHadir: false,
                        value: sortedMap),
                    summaryTableRow(
                        label: 'Total Teknisi',
                        value:
                            '${event.rekapAbsen.summary.totalTeknisi} Teknisi'),
                    summaryTableRow(
                        label: 'Rata-rata Total Tiket',
                        value:
                            '${event.rekapAbsen.summary.rataRataTotalTiket} Tiket'),
                    summaryTableRow(
                        label: 'Rata-rata Waktu Kerja',
                        value: event.rekapAbsen.summary.rataRataWaktuKerja ==
                                'NaN'
                            ? '0 Menit'
                            : '${event.rekapAbsen.summary.rataRataWaktuKerja} Menit'),
                    summaryTableRow(
                        label: 'Rata-rata Waktu Penyelesaian',
                        value: event.rekapAbsen.summary
                                    .rataRataWaktuPenyelesaian ==
                                'NaN'
                            ? '0 Menit'
                            : '${event.rekapAbsen.summary.rataRataWaktuPenyelesaian} Menit'),
                  ]),
                  // END Summary
                ],
              )
            ];
          },
        ),
      );

      pdf.addPage(pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return [
              // START Riwayat Absensi
              pw.Text(
                'Riwayat Absensi',
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              for (MapEntry entry in sortedMap.entries) ...[
                pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                  pw.Text(
                    dateFormat.format(entry.key),
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                  ),
                ]),
                pw.SizedBox(height: 8),
                pw.Container(
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#E6EEF7'),
                    border: const pw.Border(
                        right: pw.BorderSide(),
                        top: pw.BorderSide(),
                        left: pw.BorderSide(),
                        bottom: pw.BorderSide()),
                  ),
                  height: 55,
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          'No',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                          width: 1,
                          height: double.infinity,
                          color: PdfColor.fromHex('#000000')),
                      pw.Expanded(
                        flex: 4,
                        child: pw.Text(
                          'ID',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                          width: 1,
                          height: double.infinity,
                          color: PdfColor.fromHex('#000000')),
                      pw.Expanded(
                        flex: 4,
                        child: pw.Text(
                          'Nama',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                          width: 1,
                          height: double.infinity,
                          color: PdfColor.fromHex('#000000')),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          'Jam\nMasuk',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                          width: 1,
                          height: double.infinity,
                          color: PdfColor.fromHex('#000000')),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          'Jam\nKeluar',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                          width: 1,
                          height: double.infinity,
                          color: PdfColor.fromHex('#000000')),
                      pw.Expanded(
                        flex: 4,
                        child: pw.Text(
                          'Total Waktu\nKerja (menit)',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                          width: 1,
                          height: double.infinity,
                          color: PdfColor.fromHex('#000000')),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          'Total\nTiket',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                          width: 1,
                          height: double.infinity,
                          color: PdfColor.fromHex('#000000')),
                      pw.Expanded(
                        flex: 5,
                        child: pw.Text(
                          'Rata-rata\nPenyelesaian\n(menit)',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                          width: 1,
                          height: double.infinity,
                          color: PdfColor.fromHex('#000000')),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          'Status',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                for (int i = 0; i < entry.value.length; i++)
                  customRow(
                      '${1 + i}',
                      '${entry.value[i].idTeknisi}',
                      '${entry.value[i].nama}',
                      '${entry.value[i].jamMasuk}',
                      '${entry.value[i].jamKeluar}',
                      '${entry.value[i].totalWaktuKerja}',
                      '${entry.value[i].totalTiket}',
                      '${entry.value[i].rataRataPenyelesaian}',
                      '${entry.value[i].statusKehadiran}'),
                pw.SizedBox(height: 24),
              ],
              // END Riwayat Absensi
            ];
          }));

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
