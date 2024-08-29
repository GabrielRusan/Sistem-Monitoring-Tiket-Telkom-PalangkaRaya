import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:telkom_ticket_manager/data/models/pelanggan_model.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helper/json_reader.dart';

void main() {
  // test('Should return valid entity from model', () {
  //   final result = tPelangganModel.toEntity();

  //   expect(result, tPelanggan);
  // });

  test('Should return valid model from json', () {
    //arrange
    final Map<String, dynamic> jsonMap =
        jsonDecode(readJson('dummy_data/pelanggan.json'));
    //act
    final result = PelangganModel.fromJson(jsonMap);
    //assert
    expect(result, tPelangganModel);
  });

  test('Should return valid model from tiketJson', () {
    //arrange
    const String json = 'idpelanggan | nama | alamat | nohp';
    //act
    final result = PelangganModel.fromTiketJson(json);
    //assert
    expect(result, tPelangganModel);
  });

  test('Should return valid json map from model', () {
    //arrange
    final expectedJsonMap = {
      "nama": "nama",
      "nohp": "nohp",
      "alamat": "alamat",
    };
    //act
    final result = tPelangganModel.toJson();
    //assert
    expect(result, expectedJsonMap);
  });

  // test('Should return valid model from entity', () {
  //   final result = PelangganModel.fromEntity(tPelanggan);

  //   expect(result, tPelangganModel);
  // });
}
