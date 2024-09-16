import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:telkom_ticket_manager/data/models/tiket_model.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helper/json_reader.dart';

void main() {
  test('Should return valid model from json', () {
    //arrange
    final Map<String, dynamic> jsonMap =
        jsonDecode(readJson('dummy_data/tiket.json'));
    //act
    final result = TiketModel.fromJson(jsonMap);
    //assert
    expect(result, tTiketModel);
  });
}
