import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_ticket_manager/data/models/odp_model.dart';
import 'package:telkom_ticket_manager/utils/constants.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';

class OdpRemoteDataSource {
  final Dio _dio;
  final SharedPreferences _sharedPref;

  const OdpRemoteDataSource(this._dio, this._sharedPref);

  Future<List<OdpModel>> getOdp() async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      final response = await _dio.get(
        '$baseUrl/odp/',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return (response.data as List)
          .map((odp) => OdpModel.fromJson(odp))
          .toList();
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
