import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/pelanggan/pelanggan_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/models/pelanggan_model.dart';
import 'package:telkom_ticket_manager/data/models/pelanggan_response.dart';
import 'package:telkom_ticket_manager/utils/constants.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';

class PelangganRemoteDataSourceImpl implements PelangganRemoteDataSource {
  final Dio _dio;
  final SharedPreferences _sharedPref;

  const PelangganRemoteDataSourceImpl(this._dio, this._sharedPref);

  @override
  Future<String> addPelanggan(PelangganModel pelanggan) async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      await _dio.post(
        '$baseUrl/pelanggan/',
        data: pelanggan.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return "Berhasil menambah pelanggan!";
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
            case 500:
              throw DuplicateException('Id pelanggan tidak boleh sama!');
          }
        default:
          throw ServerException();
      }
      throw ServerException();
    }
  }

  @override
  Future<PelangganResponseModel> getAllPelanggan() async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      final result = await _dio.get(
        '$baseUrl/pelanggan/',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return PelangganResponseModel.fromJson(result.data);
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
            case 500:
              throw DuplicateException('Id pelanggan tidak boleh sama!');
          }
        default:
          throw ServerException();
      }
      throw ServerException();
    }
  }

  @override
  Future<String> updatePelanggan(PelangganModel pelanggan) async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      await _dio.put(
        '$baseUrl/pelanggan/${pelanggan.idpelanggan}',
        data: pelanggan.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return "Berhasil update pelanggan!";
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
            case 500:
              throw DuplicateException('Id pelanggan tidak boleh sama!');
          }
        default:
          throw ServerException();
      }
      throw ServerException();
    }
  }
}
