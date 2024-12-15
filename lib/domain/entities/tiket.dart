import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/domain/entities/detail_tiket.dart';
import 'package:telkom_ticket_manager/domain/entities/pelanggan.dart';

class Tiket extends Equatable {
  final String nomorTiket;
  final String nomorInternet;
  final String keluhan;
  final String type;
  final String status;
  final List<DetailTiket> detailTiket;
  final Pelanggan pelanggan;
  final String idOdp;
  final String namaTeknisi;
  final String idTeknisi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Tiket({
    required this.nomorTiket,
    required this.nomorInternet,
    required this.keluhan,
    required this.type,
    required this.status,
    required this.pelanggan,
    required this.detailTiket,
    required this.idOdp,
    required this.namaTeknisi,
    required this.idTeknisi,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        nomorInternet,
        keluhan,
        pelanggan,
        idOdp,
        namaTeknisi,
        createdAt,
        updatedAt,
        status,
        type,
        detailTiket,
      ];
}
