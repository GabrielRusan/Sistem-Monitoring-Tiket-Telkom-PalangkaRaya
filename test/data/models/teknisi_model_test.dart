import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:telkom_ticket_manager/data/models/teknisi_model.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helper/json_reader.dart';

void main() {
  test('Should return valid entity from model', () {
    final result = tTeknisiModel.toEntity();

    expect(result, tTeknisi);
  });

  test('Should return valid model from json', () {
    //arrange
    final Map<String, dynamic> jsonMap =
        jsonDecode(readJson('dummy_data/teknisi.json'));
    //act
    final result = TeknisiModel.fromJson(jsonMap);
    //assert
    expect(result, tTeknisiModel);
  });

  test('Should return valid json map from model', () {
    //arrange
    final expectedJsonMap = {
      "idteknisi": 1,
      "nama": "nama",
      "wilayahSektor": "sektor",
      "username": "username",
      "pass": "pass",
      "ket": "ket"
    };
    //act
    final result = tTeknisiModel.toJson();
    //assert
    expect(result, expectedJsonMap);
  });

  test('Should return valid model from entity', () {
    final result = TeknisiModel.fromEntity(tTeknisi);

    expect(result, tTeknisiModel);
  });
}
