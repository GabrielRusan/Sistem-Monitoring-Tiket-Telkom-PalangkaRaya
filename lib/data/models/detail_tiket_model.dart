// To parse this JSON data, do
//
//     final detailTiket = detailTiketFromJson(jsonString);

import 'dart:convert';

import 'package:telkom_ticket_manager/domain/entities/detail_tiket.dart';

List<DetailTiketModel> detailTiketFromJson(String str) =>
    List<DetailTiketModel>.from(
        json.decode(str).map((x) => DetailTiketModel.fromJson(x)));

// String detailTiketToJson(List<DetailTiketModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailTiketModel {
  final String idDetailTiket;
  final int tiketAktif;
  final int totalTiket;
  final double wp;
  final double normalizedWp;
  final String durasi;
  final String idTeknisi;
  final String namaTeknisi;

  DetailTiketModel({
    required this.idDetailTiket,
    required this.tiketAktif,
    required this.totalTiket,
    required this.wp,
    required this.normalizedWp,
    required this.durasi,
    required this.idTeknisi,
    required this.namaTeknisi,
  });

  factory DetailTiketModel.fromJson(Map<String, dynamic> json) =>
      DetailTiketModel(
        idDetailTiket: json["id_detailtiket"],
        tiketAktif: int.parse(json["tiketaktif"]),
        totalTiket: int.parse(json["totaltiket"]),
        wp: double.parse(json["wp"]),
        normalizedWp: double.parse(json["normalized_wp"]),
        durasi: json["durasi"],
        idTeknisi: json["idteknisi"],
        namaTeknisi: json["namateknisi"],
      );

  factory DetailTiketModel.fromEntity(DetailTiket detailTiket) =>
      DetailTiketModel(
        idDetailTiket: detailTiket.idDetailTiket,
        tiketAktif: detailTiket.tiketAktif,
        totalTiket: detailTiket.totalTiket,
        wp: detailTiket.wp,
        normalizedWp: detailTiket.normalizedWp,
        durasi: detailTiket.durasi,
        idTeknisi: detailTiket.idTeknisi,
        namaTeknisi: detailTiket.namaTeknisi,
      );

  DetailTiket toEntity() => DetailTiket(
        idDetailTiket: idDetailTiket,
        tiketAktif: tiketAktif,
        totalTiket: totalTiket,
        wp: wp,
        normalizedWp: normalizedWp,
        durasi: durasi,
        idTeknisi: idTeknisi,
        namaTeknisi: namaTeknisi,
      );

  // Map<String, dynamic> toJson() => {
  //       "id_detailtiket": idDetailTiket,
  //       "tiketAktif": tiketAktif,
  //       "totalTiket": totalTiket,
  //       "wp": wp,
  //       "normalized_wp": normalizedWp,
  //       "durasi": durasi,
  //       "idTeknisi": idTeknisi,
  //     };
}
