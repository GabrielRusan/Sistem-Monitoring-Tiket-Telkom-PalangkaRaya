import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/admin/admin_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/models/admin_model.dart';
import 'package:telkom_ticket_manager/data/models/admin_response.dart';
import 'package:telkom_ticket_manager/utils/constants.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';

class AdminRemoteDataSourceImpl extends AdminRemoteDataSource {
  final Dio _dio;
  final SharedPreferences _sharedPref;

  AdminRemoteDataSourceImpl(this._dio, this._sharedPref);

  @override
  Future<AdminResponseModel> getAllAdmin() async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      final result = await _dio.get('$baseUrl/admin/',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return AdminResponseModel.fromJson(result.data);
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
            case 403:
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
  Future<String> updateAdmin(AdminModel admin) async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      await _dio.put('$baseUrl/admin/${admin.idadmin}',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: admin.toJson());

      await _sharedPref.setString("nama", admin.nama);

      return "Berhasil update admin!";
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
