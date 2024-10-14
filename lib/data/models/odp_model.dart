// To parse this JSON data, do
//
//     final odpModel = odpModelFromJson(jsonString);

import 'dart:convert';

List<OdpModel> odpModelFromJson(String str) =>
    List<OdpModel>.from(json.decode(str).map((x) => OdpModel.fromJson(x)));

String odpModelToJson(List<OdpModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OdpModel {
  final String idodp;
  final DateTime createdAt;
  final DateTime updatedAt;

  OdpModel({
    required this.idodp,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OdpModel.fromJson(Map<String, dynamic> json) => OdpModel(
        idodp: json["idodp"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "idodp": idodp,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
