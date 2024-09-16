import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/domain/entities/teknisi.dart';

class TeknisiModel extends Equatable {
  final int idteknisi;
  final String nama;
  final String sektor;
  final String username;
  final String pass;
  final String ket;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TeknisiModel({
    required this.idteknisi,
    required this.nama,
    required this.sektor,
    required this.username,
    required this.pass,
    required this.ket,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TeknisiModel.fromJson(Map<String, dynamic> json) => TeknisiModel(
        idteknisi: json["idteknisi"],
        nama: json["nama"],
        sektor: json["sektor"],
        username: json["username"],
        pass: json["pass"],
        ket: json["ket"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  factory TeknisiModel.fromEntity(Teknisi entity) => TeknisiModel(
        idteknisi: entity.idteknisi,
        nama: entity.nama,
        sektor: entity.sektor,
        username: entity.username,
        pass: entity.pass,
        ket: entity.ket,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "sektor": sektor,
        "username": username,
        "pass": pass,
        "ket": ket,
        // "createdAt": DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAt),
        // "updatedAt": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      };

  Teknisi toEntity() => Teknisi(
      idteknisi: idteknisi,
      nama: nama,
      sektor: sektor,
      username: username,
      pass: pass,
      ket: ket,
      createdAt: createdAt,
      updatedAt: updatedAt);

  @override
  List<Object?> get props =>
      [idteknisi, nama, sektor, username, pass, ket, createdAt, updatedAt];
}
