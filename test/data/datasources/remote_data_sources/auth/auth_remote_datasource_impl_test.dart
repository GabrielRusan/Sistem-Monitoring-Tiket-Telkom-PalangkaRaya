import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/auth/auth_remote_datasource_impl.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';

import '../../../../helper/json_reader.dart';
import '../../../../helper/test_helpers.mocks.dart';

void main() {
  late MockDio mockDio;
  late MockSharedPreferences mockSharedPreferences;
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;

  setUp(() {
    mockDio = MockDio();
    mockSharedPreferences = MockSharedPreferences();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(
      dio: mockDio,
      sharedPref: mockSharedPreferences,
    );
  });

  group('logout test', () {
    test('Should return true when success clear token and id from local',
        () async {
      //arrange
      when(mockSharedPreferences.clear()).thenAnswer((_) async => true);
      //act
      final result = await authRemoteDataSourceImpl.logOut();
      //assert
      expect(result, true);
    });
  });

  group("login test", () {
    test('should get token and idteknisi from API when login is successful',
        () async {
      // arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
            data: jsonDecode(readJson('dummy_data/login_response.json'))),
      );

      // Setup SharedPreferences mock
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      // act
      final result = await authRemoteDataSourceImpl.logIn(
          username: 'test_user', password: 'test_pass');

      // assert
      // Verify that the token and idadmin and nama were saved
      verify(mockSharedPreferences.setString("token", 'token')).called(1);
      verify(mockSharedPreferences.setString("id", '1')).called(1);
      verify(mockSharedPreferences.setString("nama", 'nama')).called(1);
      expect(result, true);
    });

    test(
        'should throw WrongCombinationException when either not found username nor wrong password',
        () async {
      // arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenThrow(
          DioException.badResponse(
              statusCode: 401,
              requestOptions: RequestOptions(),
              response: Response(
                  requestOptions: RequestOptions(),
                  statusCode: 401,
                  data: {'message': 'username salah'})));

      // act
      final response = authRemoteDataSourceImpl.logIn(
          username: 'test_user', password: 'test_pass');

      // assert
      expect(() => response, throwsA(isA<WrongCombinationException>()));
    });

    test('should throw ConnectionException when cannot connect to server',
        () async {
      // arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenThrow(
          DioException.connectionError(
              requestOptions: RequestOptions(path: ''),
              reason: 'Cant connect to ur url'));

      // act
      final response = authRemoteDataSourceImpl.logIn(
          username: 'test_user', password: 'test_pass');

      // assert
      expect(() => response, throwsA(isA<ConnectionException>()));
    });

    test('should throw ServerException when call to api is not successful',
        () async {
      // arrange
      when(mockDio.post(any, data: anyNamed('data'))).thenThrow(
          DioException.badResponse(
              statusCode: 501,
              requestOptions: RequestOptions(),
              response: Response(
                  requestOptions: RequestOptions(),
                  statusCode: 501,
                  data: {'message': ''})));

      // act
      final response = authRemoteDataSourceImpl.logIn(
          username: 'test_user', password: 'test_pass');

      // assert
      expect(() => response, throwsA(isA<ServerException>()));
    });
  });
}
