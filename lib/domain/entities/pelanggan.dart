import 'package:equatable/equatable.dart';

class Pelanggan extends Equatable {
  final String idpelanggan;
  final String nama;
  final String nohp;
  final String alamat;

  const Pelanggan({
    required this.idpelanggan,
    required this.nama,
    required this.nohp,
    required this.alamat,
  });

  @override
  List<Object?> get props => [idpelanggan, nama, nohp, alamat];
}
