import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/data/models/detail_tiket_model.dart';
import 'package:telkom_ticket_manager/data/models/pelanggan_model.dart';
import 'package:telkom_ticket_manager/domain/entities/tiket.dart';

List<TiketModel> tiketModelFromJson(String str) =>
    List<TiketModel>.from(json.decode(str).map((x) => TiketModel.fromJson(x)));

class TiketModel extends Equatable {
  final String nomorTiket;
  final String nomorInternet;
  final String keluhan;
  final String type;
  final String status;
  final PelangganModel pelanggan;
  final String idOdp;
  final String namaTeknisi;
  final String idTeknisi;
  final List<DetailTiketModel> detailTiket;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TiketModel({
    required this.nomorTiket,
    required this.nomorInternet,
    required this.keluhan,
    required this.type,
    required this.status,
    required this.pelanggan,
    required this.idOdp,
    required this.namaTeknisi,
    required this.idTeknisi,
    required this.detailTiket,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TiketModel.fromJson(Map<String, dynamic> json) => TiketModel(
        nomorTiket: json["nomortiket"],
        nomorInternet: json["nomorinternet"],
        keluhan: json["keluhan"],
        type: json["tipetiket"],
        status: json["status"],
        pelanggan: PelangganModel.fromTiketJson(json["idpelanggan"]),
        idOdp: json["idodp"],
        detailTiket: json['detail_tiket']
            .map<DetailTiketModel>(
                (detailTiket) => DetailTiketModel.fromJson(detailTiket))
            .toList(),
        namaTeknisi: json["idteknisi"].split(' | ')[1],
        idTeknisi: json["idteknisi"].split(' | ')[0],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  factory TiketModel.fromEntity(Tiket tiket) => TiketModel(
      nomorTiket: tiket.nomorTiket,
      nomorInternet: tiket.nomorInternet,
      keluhan: tiket.keluhan,
      type: tiket.type,
      status: tiket.status,
      pelanggan: PelangganModel.fromEntity(tiket.pelanggan),
      idOdp: tiket.idOdp,
      namaTeknisi: tiket.namaTeknisi,
      idTeknisi: tiket.idTeknisi,
      detailTiket:
          tiket.detailTiket.map((e) => DetailTiketModel.fromEntity(e)).toList(),
      createdAt: tiket.createdAt,
      updatedAt: tiket.updatedAt);

  @override
  List<Object?> get props => [
        nomorTiket,
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

  Tiket toEntity() => Tiket(
      nomorTiket: nomorTiket,
      nomorInternet: nomorInternet,
      keluhan: keluhan,
      type: type,
      status: status,
      pelanggan: pelanggan.toEntity(),
      idOdp: idOdp,
      namaTeknisi: namaTeknisi,
      idTeknisi: idTeknisi,
      detailTiket: detailTiket.map((e) => e.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt);

  // Map<String, dynamic> toJson() => {
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
