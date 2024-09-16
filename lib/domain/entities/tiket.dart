import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/domain/entities/pelanggan.dart';

class Tiket extends Equatable {
  final int idTiket;
  final String nomorTiket;
  final String nomorInternet;
  final String keluhan;
  final String type;
  final String status;
  final String ket;
  final String notePelanggan;
  final Pelanggan pelanggan;
  final String idOdp;
  final String namaTeknisi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Tiket({
    required this.idTiket,
    required this.nomorTiket,
    required this.nomorInternet,
    required this.keluhan,
    required this.type,
    required this.status,
    required this.ket,
    required this.notePelanggan,
    required this.pelanggan,
    required this.idOdp,
    required this.namaTeknisi,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        idTiket,
        nomorTiket,
        nomorInternet,
        keluhan,
        notePelanggan,
        pelanggan,
        idOdp,
        namaTeknisi,
        createdAt,
        updatedAt,
        ket,
        status,
        type
      ];
}
