import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/teknisi/teknisi_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/models/teknisi_model.dart';
import 'package:telkom_ticket_manager/data/models/teknisi_response.dart';
import 'package:telkom_ticket_manager/utils/constants.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';

class TeknisiRemoteDataSourceImpl extends TeknisiRemoteDataSource {
  final Dio _dio;
  final SharedPreferences _sharedPref;

  TeknisiRemoteDataSourceImpl(this._dio, this._sharedPref);

  @override
  Future<TeknisiResponseModel> getAllTeknisi() async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      final result = await _dio.get(
          'https://6kh4g3z0-3020.asse.devtunnels.ms/teknisi/',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return TeknisiResponseModel.fromJson(result.data);
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionError:
          throw ConnectionException('Gagal menghubungkan dengan server!');
        case DioExceptionType.connectionTimeout:
          throw ConnectionException('Gagal menghubungkan dengan server!');
        case DioExceptionType.badResponse:
          switch (e.response?.statusCode) {
            case 401:
              throw InvalidTokenException();
            case 404:
              throw NotFoundException();
          }
        default:
          throw ServerException();
      }
      throw ServerException();
    }
  }

  @override
  Future<String> addTeknisi(TeknisiModel teknisi) async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      await _dio.post(
        '$baseUrl/teknisi/',
        data: teknisi.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return "Berhasil menambah teknisi!";
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionError:
          throw ConnectionException('Gagal menghubungkan dengan server!');
        case DioExceptionType.connectionTimeout:
          throw ConnectionException('Gagal menghubungkan dengan server!');
        case DioExceptionType.badResponse:
          switch (e.response?.statusCode) {
            case 400:
              throw FieldValidationException();
            case 401:
              throw InvalidTokenException();
            case 403:
              throw InvalidTokenException();
            case 404:
              throw NotFoundException();
            case 405:
              throw DuplicateException(e.response?.data['message']);
          }
        default:
          throw ServerException();
      }
      throw ServerException();
    }
  }

  @override
  Future<String> deleteTeknisi(int id) async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      await _dio.delete(
        '$baseUrl/teknisi/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return "Berhasil menghapus teknisi!";
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionError:
          throw ConnectionException('Gagal menghubungkan dengan server!');
        case DioExceptionType.connectionTimeout:
          throw ConnectionException('Gagal menghubungkan dengan server!');
        case DioExceptionType.badResponse:
          switch (e.response?.statusCode) {
            case 400:
              throw FieldValidationException();
            case 401:
              throw InvalidTokenException();
            case 403:
              throw InvalidTokenException();
            case 404:
              throw NotFoundException();
            case 405:
              throw DuplicateException(e.response?.data['message']);
            case 407:
              throw DuplicateException(e.response?.data['message']);
          }
        default:
          throw ServerException();
      }
      throw ServerException();
    }
  }

  @override
  Future<String> updateTeknisi(TeknisiModel teknisi) async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      await _dio.put('$baseUrl/teknisi/${teknisi.idteknisi}',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {
            "nama": teknisi.nama,
            "sektor": teknisi.sektor,
            "username": teknisi.username,
            "pass": teknisi.pass
          });

      return "Berhasil update teknisi!";
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionError:
          throw ConnectionException('Gagal menghubungkan dengan server!');
        case DioExceptionType.connectionTimeout:
          throw ConnectionException('Gagal menghubungkan dengan server!');
        case DioExceptionType.badResponse:
          switch (e.response?.statusCode) {
            case 400:
              throw FieldValidationException();
            case 401:
              throw InvalidTokenException();
            case 403:
              throw InvalidTokenException();
            case 404:
              throw NotFoundException();
            case 405:
              throw DuplicateException(e.response?.data['message']);
          }
        default:
          throw ServerException();
      }
      throw ServerException();
    }
  }
}
