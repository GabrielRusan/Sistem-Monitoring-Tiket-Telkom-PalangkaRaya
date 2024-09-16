import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/domain/entities/admin.dart';

class AdminModel extends Equatable {
  final int idadmin;
  final String nama;
  final String username;
  final String pass;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdminModel({
    required this.idadmin,
    required this.nama,
    required this.username,
    required this.pass,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        idadmin: json["idadmin"],
        nama: json["nama"],
        username: json["username"],
        pass: json["pass"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  factory AdminModel.fromEntity(Admin admin) => AdminModel(
      idadmin: admin.idadmin,
      nama: admin.nama,
      username: admin.username,
      pass: admin.pass,
      createdAt: admin.createdAt,
      updatedAt: admin.updatedAt);

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "username": username,
        "pass": pass,
      };

  Admin toEntity() => Admin(
      idadmin: idadmin,
      nama: nama,
      username: username,
      pass: pass,
      createdAt: createdAt,
      updatedAt: updatedAt);

  @override
  List<Object?> get props =>
      [idadmin, nama, username, pass, createdAt, updatedAt];
}
