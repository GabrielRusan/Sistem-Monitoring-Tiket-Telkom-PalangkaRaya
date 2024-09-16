import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/data/models/pelanggan_model.dart';
import 'package:telkom_ticket_manager/domain/entities/tiket.dart';

List<TiketModel> tiketModelFromJson(String str) =>
    List<TiketModel>.from(json.decode(str).map((x) => TiketModel.fromJson(x)));

class TiketModel extends Equatable {
  final int idTiket;
  final String nomorTiket;
  final String nomorInternet;
  final String keluhan;
  final String type;
  final String status;
  final String ket;
  final String notePelanggan;
  final PelangganModel pelanggan;
  final String idOdp;
  final String namaTeknisi;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TiketModel({
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

  factory TiketModel.fromJson(Map<String, dynamic> json) => TiketModel(
        idTiket: json["idtiket"],
        nomorTiket: json["nomortiket"],
        nomorInternet: json["nomorinternet"],
        keluhan: json["keluhan"],
        type: json["tipetiket"],
        status: json["status"],
        ket: json["ket"],
        notePelanggan: json["notepelanggan"],
        pelanggan: PelangganModel.fromTiketJson(json["idpelanggan"]),
        idOdp: json["idodp"].split(' | ')[1],
        namaTeknisi: json["idteknisi"].split(' | ')[1],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  factory TiketModel.fromEntity(Tiket tiket) => TiketModel(
      idTiket: tiket.idTiket,
      nomorTiket: tiket.nomorTiket,
      nomorInternet: tiket.nomorInternet,
      keluhan: tiket.keluhan,
      type: tiket.type,
      status: tiket.status,
      ket: tiket.ket,
      notePelanggan: tiket.notePelanggan,
      pelanggan: PelangganModel.fromEntity(tiket.pelanggan),
      idOdp: tiket.idOdp,
      namaTeknisi: tiket.namaTeknisi,
      createdAt: tiket.createdAt,
      updatedAt: tiket.updatedAt);

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

  Tiket toEntity() => Tiket(
      idTiket: idTiket,
      nomorTiket: nomorTiket,
      nomorInternet: nomorInternet,
      keluhan: keluhan,
      type: type,
      status: status,
      ket: ket,
      notePelanggan: notePelanggan,
      pelanggan: pelanggan.toEntity(),
      idOdp: idOdp,
      namaTeknisi: namaTeknisi,
      createdAt: createdAt,
      updatedAt: updatedAt);

  // Map<String, dynamic> toJson() => {
  //       "idtiket": idtiket,
  //       "nomortiket": nomortiket,
  //       "nomorinternet": nomorinternet,
  //       "keluhan": keluhan,
  //       "notepelanggan": notepelanggan,
  //       "idpelanggan": idpelanggan,
  //       "idodp": idodp,
  //       "idteknisi": idteknisi,
  //       "createdAt": createdAt.toIso8601String(),
  //       "updatedAt": updatedAt.toIso8601String(),
  //     };
}
