// To parse this JSON data, do
//
//     final rekapAbsenModel = rekapAbsenModelFromJson(jsonString);

import 'dart:convert';

RekapAbsenModel rekapAbsenModelFromJson(String str) =>
    RekapAbsenModel.fromJson(json.decode(str));

String rekapAbsenModelToJson(RekapAbsenModel data) =>
    json.encode(data.toJson());

class RekapAbsenModel {
  final String message;
  final Summary summary;
  final List<Absen> data;

  RekapAbsenModel({
    required this.message,
    required this.summary,
    required this.data,
  });

  factory RekapAbsenModel.fromJson(Map<String, dynamic> json) =>
      RekapAbsenModel(
        message: json["message"],
        summary: Summary.fromJson(json["summary"]),
        data: List<Absen>.from(json["data"].map((x) => Absen.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "summary": summary.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Absen {
  final String id;
  final String idTeknisi;
  final String nama;
  final DateTime tanggal;
  final String jamMasuk;
  final String jamKeluar;
  final String statusKehadiran;
  final String totalWaktuKerja;
  final String totalTiket;
  final String rataRataPenyelesaian;

  Absen({
    required this.id,
    required this.idTeknisi,
    required this.nama,
    required this.tanggal,
    required this.jamMasuk,
    required this.jamKeluar,
    required this.statusKehadiran,
    required this.totalWaktuKerja,
    required this.totalTiket,
    required this.rataRataPenyelesaian,
  });

  factory Absen.fromJson(Map<String, dynamic> json) => Absen(
        id: json["id"],
        idTeknisi: json["id_teknisi"],
        nama: json["nama"],
        tanggal: DateTime.parse(json["tanggal"]),
        jamMasuk: json["jam_masuk"],
        jamKeluar: json["jam_keluar"],
        statusKehadiran: json["status_kehadiran"],
        totalWaktuKerja: json["total_waktu_kerja"],
        totalTiket: json["total_tiket"],
        rataRataPenyelesaian: json["rata_rata_penyelesaian"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_teknisi": idTeknisi,
        "nama": nama,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "jam_masuk": jamMasuk,
        "jam_keluar": jamKeluar,
        "status_kehadiran": statusKehadiran,
        "total_waktu_kerja": totalWaktuKerja,
        "total_tiket": totalTiket,
        "rata_rata_penyelesaian": rataRataPenyelesaian,
      };
}

class Summary {
  final String rataRataWaktuKerja;
  final String rataRataTotalTiket;
  final String rataRataWaktuPenyelesaian;
  final String totalHadir;
  final String totalTidakHadir;
  final String totalTeknisi;

  Summary({
    required this.rataRataWaktuKerja,
    required this.rataRataTotalTiket,
    required this.rataRataWaktuPenyelesaian,
    required this.totalHadir,
    required this.totalTidakHadir,
    required this.totalTeknisi,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        rataRataWaktuKerja: json["rata_rata_waktu_kerja"].toString(),
        rataRataTotalTiket: json["rata_rata_total_tiket"].toString(),
        rataRataWaktuPenyelesaian:
            json["rata_rata_waktu_penyelesaian"].toString(),
        totalHadir: json["total_hadir"].toString(),
        totalTidakHadir: json["total_tidak_hadir"].toString(),
        totalTeknisi: json["total_teknisi"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "rata_rata_waktu_kerja": rataRataWaktuKerja,
        "rata_rata_total_tiket": rataRataTotalTiket,
        "rata_rata_waktu_penyelesaian": rataRataWaktuPenyelesaian,
        "total_hadir": totalHadir,
        "total_tidak_hadir": totalTidakHadir,
        "total_teknisi": totalTeknisi,
      };
}
