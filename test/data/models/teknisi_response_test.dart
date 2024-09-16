import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:telkom_ticket_manager/data/models/teknisi_response.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helper/json_reader.dart';

void main() {
  test('Should return a valid model from JSON', () {
    // arrange
    final jsonMap = json.decode(readJson('dummy_data/teknisi_response.json'));
    // act
    final result = TeknisiResponseModel.fromJson(jsonMap);
    // assert
    expect(result, tTeknisiResponseModel);
  });
}
