import 'package:equatable/equatable.dart';

class DetailTiket extends Equatable {
  final String idDetailTiket;
  final int tiketAktif;
  final int totalTiket;
  final double wp;
  final double normalizedWp;
  final String durasi;
  final String idTeknisi;
  final String namaTeknisi;
  final String keterangan;

  const DetailTiket({
    required this.idDetailTiket,
    required this.tiketAktif,
    required this.totalTiket,
    required this.wp,
    required this.normalizedWp,
    required this.durasi,
    required this.idTeknisi,
    required this.namaTeknisi,
    required this.keterangan,
  });

  @override
  List<Object?> get props => [
        idDetailTiket,
        tiketAktif,
        totalTiket,
        wp,
        normalizedWp,
        durasi,
        idTeknisi,
        namaTeknisi,
        keterangan
      ];
}
