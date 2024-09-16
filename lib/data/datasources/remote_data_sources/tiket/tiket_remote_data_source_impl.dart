import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/tiket/tiket_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/models/tiket_response.dart';
import 'package:telkom_ticket_manager/utils/constants.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';

class TiketRemoteDataSourceImpl implements TiketRemoteDataSource {
  final Dio _dio;
  final SharedPreferences _sharedPref;

  const TiketRemoteDataSourceImpl(this._dio, this._sharedPref);

  @override
  Future<TiketResponseModel> getAllTiket() async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      final result = await _dio.get(
        '$baseUrl/tiket/',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return TiketResponseModel.fromJson(result.data);
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
  Future<TiketResponseModel> getAllActiveTiket() async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      final result = await _dio.get(
        '$baseUrl/tiket/?status=Ditugaskan&status=In Progress',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return TiketResponseModel.fromJson(result.data);
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
  Future<TiketResponseModel> getAllHistoricTiket() async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      final result = await _dio.get(
        '$baseUrl/tiket/?status=Selesai',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return TiketResponseModel.fromJson(result.data);
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
  Future<TiketResponseModel> getAllTiketByIdTeknisi(String idTeknisi) async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      final result = await _dio.get(
        '$baseUrl/tiket/?idteknisi=$idTeknisi',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return TiketResponseModel.fromJson(result.data);
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
  Future<TiketResponseModel> getAllActiveTiketByIdTeknisi(
      String idTeknisi) async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      final result = await _dio.get(
        '$baseUrl/tiket/?idteknisi=$idTeknisi&status=Ditugaskan&status=In Progress',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return TiketResponseModel.fromJson(result.data);
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
  Future<TiketResponseModel> getAllHistoricTiketByIdTeknisi(
      String idTeknisi) async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      final result = await _dio.get(
        '$baseUrl/tiket/?idteknisi=$idTeknisi&status=Selesai',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return TiketResponseModel.fromJson(result.data);
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
  Future<TiketResponseModel> getAllTiketByIdPelanggan(
      String idPelanggan) async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      final result = await _dio.get(
        '$baseUrl/tiket/?idpelanggan=$idPelanggan',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return TiketResponseModel.fromJson(result.data);
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
  Future<TiketResponseModel> getAllActiveTiketByIdPelanggan(
      String idPelanggan) async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      final result = await _dio.get(
        '$baseUrl/tiket/?idpelanggan=$idPelanggan&status=Ditugaskan&status=In Progress',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return TiketResponseModel.fromJson(result.data);
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
  Future<TiketResponseModel> getAllHistoricTiketByIdPelanggan(
      String idPelanggan) async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      final result = await _dio.get(
        '$baseUrl/tiket/?idpelanggan=$idPelanggan&status=Selesai',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return TiketResponseModel.fromJson(result.data);
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
