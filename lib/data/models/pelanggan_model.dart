import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/domain/entities/pelanggan.dart';

class PelangganModel extends Equatable {
  final String idpelanggan;
  final String nama;
  final String nohp;
  final String alamat;

  const PelangganModel({
    required this.idpelanggan,
    required this.nama,
    required this.nohp,
    required this.alamat,
  });

  factory PelangganModel.fromJson(Map<String, dynamic> json) => PelangganModel(
        idpelanggan: json["idpelanggan"],
        nama: json["nama"],
        nohp: json["nohp"],
        alamat: json["alamat"],
      );

  factory PelangganModel.fromEntity(Pelanggan pelanggan) => PelangganModel(
        idpelanggan: pelanggan.idpelanggan,
        nama: pelanggan.nama,
        nohp: pelanggan.nohp,
        alamat: pelanggan.alamat,
      );

  factory PelangganModel.fromTiketJson(String json) {
    final List<String> data = json.split(' | ');
    return PelangganModel(
        idpelanggan: data[0], nama: data[1], nohp: data[3], alamat: data[2]);
  }

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "nohp": nohp,
        "alamat": alamat,
      };

  Pelanggan toEntity() => Pelanggan(
        idpelanggan: idpelanggan,
        nama: nama,
        nohp: nohp,
        alamat: alamat,
      );

  @override
  List<Object?> get props => [idpelanggan, nama, nohp, alamat];
}
