import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/domain/entities/teknisi.dart';
import 'package:telkom_ticket_manager/utils/constants.dart';

class TeknisiModel extends Equatable {
  final String idteknisi;
  final String nama;
  final String kehadiran;
  final String username;
  final String pass;
  final String ket;
  final String status;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TeknisiModel({
    required this.idteknisi,
    required this.nama,
    required this.kehadiran,
    required this.username,
    required this.pass,
    required this.ket,
    required this.imageUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TeknisiModel.fromJson(Map<String, dynamic> json) => TeknisiModel(
        idteknisi: json["idteknisi"],
        nama: json["nama"],
        kehadiran: json["kehadiran"],
        username: json["username"],
        pass: json["pass"],
        ket: json["ket"],
        status: json["stateknisi"],
        imageUrl: "$baseUrl/uploads/teknisi/${json["foto"]}",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  factory TeknisiModel.fromEntity(Teknisi entity) => TeknisiModel(
        idteknisi: entity.idteknisi,
        nama: entity.nama,
        kehadiran: entity.kehadiran,
        username: entity.username,
        pass: entity.pass,
        ket: entity.ket,
        imageUrl: entity.imageUrl,
        status: entity.status,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "kehadiran": kehadiran,
        "username": username,
        "pass": pass,
        "ket": ket,
        "stateknisi": status,
        // "createdAt": DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAt),
        // "updatedAt": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      };

  Teknisi toEntity() => Teknisi(
      idteknisi: idteknisi,
      nama: nama,
      kehadiran: kehadiran,
      username: username,
      pass: pass,
      ket: ket,
      status: status,
      imageUrl: imageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt);

  @override
  List<Object?> get props => [
        idteknisi,
        nama,
        kehadiran,
        username,
        pass,
        ket,
        createdAt,
        imageUrl,
        status,
        updatedAt
      ];
}
