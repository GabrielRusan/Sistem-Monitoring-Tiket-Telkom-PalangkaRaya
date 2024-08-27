// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/teknisi/teknisi_remote_data_source_impl.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';

import '../../../../dummy_data/dummy_object.dart';
import '../../../../helper/json_reader.dart';
import '../../../../helper/test_helpers.mocks.dart';

void main() {
  late MockDio mockDio;
  late MockSharedPreferences mockSharedPreferences;
  late TeknisiRemoteDataSourceImpl teknisiRemoteDataSource;
  setUp(() {
    mockDio = MockDio();
    mockSharedPreferences = MockSharedPreferences();
    teknisiRemoteDataSource =
        TeknisiRemoteDataSourceImpl(mockDio, mockSharedPreferences);
  });

  group('getAllTeknisi', () {
    test('should get teknisi list when call to api is success', () async {
      //arrrange
      when(mockDio.get(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: jsonDecode(readJson('dummy_data/teknisi_response.json'))));
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      //act
      final result = await teknisiRemoteDataSource.getAllTeknisi();
      //assert
      expect(result.teknisiList, tTeknisiResponseModel.teknisiList);
    });

    test('should throw NoCredentialException when token is null', () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn(null);
      //act
      final call = teknisiRemoteDataSource.getAllTeknisi();
      //assert
      expect(() => call, throwsA(isA<NoCredentialException>()));
    });

    test('should throw ConnectionException when get connection error from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.get(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.connectionError(
              requestOptions: RequestOptions(), reason: ''));
      //act
      final call = teknisiRemoteDataSource.getAllTeknisi();
      //assert
      expect(() => call, throwsA(isA<ConnectionException>()));
    });

    test(
        'should throw ConnectionException when get connection timeout from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.get(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.connectionTimeout(
              requestOptions: RequestOptions(), timeout: Duration.zero));
      //act
      final call = teknisiRemoteDataSource.getAllTeknisi();
      //assert
      expect(() => call, throwsA(isA<ConnectionException>()));
    });

    test(
        'should throw InvalidTokenException when get bad response 401 from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.get(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.badResponse(
              requestOptions: RequestOptions(),
              statusCode: 401,
              response:
                  Response(requestOptions: RequestOptions(), statusCode: 401)));
      //act
      final call = teknisiRemoteDataSource.getAllTeknisi();
      //assert
      expect(() => call, throwsA(isA<InvalidTokenException>()));
    });

    test('should throw NotFoundException when get bad response 404 from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.get(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.badResponse(
              requestOptions: RequestOptions(),
              statusCode: 404,
              response:
                  Response(requestOptions: RequestOptions(), statusCode: 404)));
      //act
      final call = teknisiRemoteDataSource.getAllTeknisi();
      //assert
      expect(() => call, throwsA(isA<NotFoundException>()));
    });

    test('should throw ServerException when get other exception from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.get(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.receiveTimeout(
              timeout: Duration.zero, requestOptions: RequestOptions()));
      //act
      final call = teknisiRemoteDataSource.getAllTeknisi();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('addTeknisi', () {
    test('should get valid message when call to api is success', () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.post(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(), statusCode: 200, data: {}));
      //act
      final result = await teknisiRemoteDataSource.addTeknisi(tTeknisiModel);
      //assert
      expect(result, 'Berhasil menambah teknisi!');
    });

    test('should throw NoCredentialException when token is null', () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn(null);
      //act
      final call = teknisiRemoteDataSource.addTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<NoCredentialException>()));
    });

    test('should throw ConnectionException when get connection error from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.post(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.connectionError(
              requestOptions: RequestOptions(), reason: ''));
      //act
      final call = teknisiRemoteDataSource.addTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<ConnectionException>()));
    });

    test(
        'should throw ConnectionException when get connection timeout from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.post(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.connectionTimeout(
              requestOptions: RequestOptions(), timeout: Duration.zero));
      //act
      final call = teknisiRemoteDataSource.addTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<ConnectionException>()));
    });

    test(
        'should throw FieldValidationException when get bad response 400 from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.post(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.badResponse(
              requestOptions: RequestOptions(),
              statusCode: 400,
              response:
                  Response(requestOptions: RequestOptions(), statusCode: 400)));
      //act
      final call = teknisiRemoteDataSource.addTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<FieldValidationException>()));
    });

    test(
        'should throw InvalidTokenException when get bad response 401 from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.post(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.badResponse(
              requestOptions: RequestOptions(),
              statusCode: 401,
              response:
                  Response(requestOptions: RequestOptions(), statusCode: 401)));
      //act
      final call = teknisiRemoteDataSource.addTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<InvalidTokenException>()));
    });
    test(
        'should throw InvalidTokenException when get bad response 403 from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.post(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.badResponse(
              requestOptions: RequestOptions(),
              statusCode: 403,
              response:
                  Response(requestOptions: RequestOptions(), statusCode: 403)));
      //act
      final call = teknisiRemoteDataSource.addTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<InvalidTokenException>()));
    });

    test('should throw NotFoundException when get bad response 404 from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.post(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.badResponse(
              requestOptions: RequestOptions(),
              statusCode: 404,
              response:
                  Response(requestOptions: RequestOptions(), statusCode: 404)));
      //act
      final call = teknisiRemoteDataSource.addTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<NotFoundException>()));
    });

    test('should throw DuplicateException when get bad response 405 from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.post(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.badResponse(
              requestOptions: RequestOptions(),
              statusCode: 405,
              response: Response(
                  requestOptions: RequestOptions(),
                  statusCode: 405,
                  data: {"message": "Nama atau username sudah digunakan"})));
      //act
      final call = teknisiRemoteDataSource.addTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<DuplicateException>()));
    });

    test('should throw ServerException when get other exception from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.post(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.receiveTimeout(
              timeout: Duration.zero, requestOptions: RequestOptions()));
      //act
      final call = teknisiRemoteDataSource.addTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('updateTeknisi', () {
    test('should get valid message when call to api is success', () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.put(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(), statusCode: 200, data: {}));
      //act
      final result = await teknisiRemoteDataSource.updateTeknisi(tTeknisiModel);
      //assert
      expect(result, 'Berhasil update teknisi!');
    });

    test('should throw NoCredentialException when token is null', () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn(null);
      //act
      final call = teknisiRemoteDataSource.updateTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<NoCredentialException>()));
    });

    test('should throw ConnectionException when get connection error from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.put(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.connectionError(
              requestOptions: RequestOptions(), reason: ''));
      //act
      final call = teknisiRemoteDataSource.updateTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<ConnectionException>()));
    });

    test(
        'should throw ConnectionException when get connection timeout from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.put(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.connectionTimeout(
              requestOptions: RequestOptions(), timeout: Duration.zero));
      //act
      final call = teknisiRemoteDataSource.updateTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<ConnectionException>()));
    });

    test(
        'should throw FieldValidationException when get bad response 400 from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.put(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.badResponse(
              requestOptions: RequestOptions(),
              statusCode: 400,
              response:
                  Response(requestOptions: RequestOptions(), statusCode: 400)));
      //act
      final call = teknisiRemoteDataSource.updateTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<FieldValidationException>()));
    });

    test(
        'should throw InvalidTokenException when get bad response 401 from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.put(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.badResponse(
              requestOptions: RequestOptions(),
              statusCode: 401,
              response:
                  Response(requestOptions: RequestOptions(), statusCode: 401)));
      //act
      final call = teknisiRemoteDataSource.updateTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<InvalidTokenException>()));
    });
    test(
        'should throw InvalidTokenException when get bad response 403 from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.put(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.badResponse(
              requestOptions: RequestOptions(),
              statusCode: 403,
              response:
                  Response(requestOptions: RequestOptions(), statusCode: 403)));
      //act
      final call = teknisiRemoteDataSource.updateTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<InvalidTokenException>()));
    });

    test('should throw NotFoundException when get bad response 404 from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.put(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.badResponse(
              requestOptions: RequestOptions(),
              statusCode: 404,
              response:
                  Response(requestOptions: RequestOptions(), statusCode: 404)));
      //act
      final call = teknisiRemoteDataSource.updateTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<NotFoundException>()));
    });

    test('should throw DuplicateException when get bad response 405 from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.put(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.badResponse(
              requestOptions: RequestOptions(),
              statusCode: 405,
              response: Response(
                  requestOptions: RequestOptions(),
                  statusCode: 405,
                  data: {"message": "Nama atau username sudah digunakan"})));
      //act
      final call = teknisiRemoteDataSource.updateTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<DuplicateException>()));
    });

    test('should throw ServerException when get other exception from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.put(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.receiveTimeout(
              timeout: Duration.zero, requestOptions: RequestOptions()));
      //act
      final call = teknisiRemoteDataSource.updateTeknisi(tTeknisiModel);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('deleteTeknisi', () {
    test('should get valid message when call to api is success', () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.delete(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(), statusCode: 200, data: {}));
      //act
      final result = await teknisiRemoteDataSource.deleteTeknisi(1);
      //assert
      expect(result, 'Berhasil menghapus teknisi!');
    });

    test('should throw NoCredentialException when token is null', () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn(null);
      //act
      final call = teknisiRemoteDataSource.deleteTeknisi(1);
      //assert
      expect(() => call, throwsA(isA<NoCredentialException>()));
    });

    test('should throw ConnectionException when get connection error from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.delete(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.connectionError(
              requestOptions: RequestOptions(), reason: ''));
      //act
      final call = teknisiRemoteDataSource.deleteTeknisi(1);
      //assert
      expect(() => call, throwsA(isA<ConnectionException>()));
    });

    test(
        'should throw ConnectionException when get connection timeout from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.delete(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.connectionTimeout(
              requestOptions: RequestOptions(), timeout: Duration.zero));
      //act
      final call = teknisiRemoteDataSource.deleteTeknisi(1);
      //assert
      expect(() => call, throwsA(isA<ConnectionException>()));
    });

    test(
        'should throw InvalidTokenException when get bad response 401 from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.delete(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.badResponse(
              requestOptions: RequestOptions(),
              statusCode: 401,
              response:
                  Response(requestOptions: RequestOptions(), statusCode: 401)));
      //act
      final call = teknisiRemoteDataSource.deleteTeknisi(1);
      //assert
      expect(() => call, throwsA(isA<InvalidTokenException>()));
    });
    test(
        'should throw InvalidTokenException when get bad response 403 from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.delete(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.badResponse(
              requestOptions: RequestOptions(),
              statusCode: 403,
              response:
                  Response(requestOptions: RequestOptions(), statusCode: 403)));
      //act
      final call = teknisiRemoteDataSource.deleteTeknisi(1);
      //assert
      expect(() => call, throwsA(isA<InvalidTokenException>()));
    });

    test('should throw NotFoundException when get bad response 404 from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.delete(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.badResponse(
              requestOptions: RequestOptions(),
              statusCode: 404,
              response:
                  Response(requestOptions: RequestOptions(), statusCode: 404)));
      //act
      final call = teknisiRemoteDataSource.deleteTeknisi(1);
      //assert
      expect(() => call, throwsA(isA<NotFoundException>()));
    });

    test('should throw ServerException when get other exception from dio',
        () async {
      //arrrange
      when(mockSharedPreferences.getString('token')).thenReturn('token');
      when(mockDio.delete(any,
              options: anyNamed('options'), data: anyNamed('data')))
          .thenThrow(DioException.receiveTimeout(
              timeout: Duration.zero, requestOptions: RequestOptions()));
      //act
      final call = teknisiRemoteDataSource.deleteTeknisi(1);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
