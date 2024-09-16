import 'package:equatable/equatable.dart';

class Admin extends Equatable {
  final int idadmin;
  final String nama;
  final String username;
  final String pass;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Admin({
    required this.idadmin,
    required this.nama,
    required this.username,
    required this.pass,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [idadmin, nama, username, pass, createdAt, updatedAt];
}
