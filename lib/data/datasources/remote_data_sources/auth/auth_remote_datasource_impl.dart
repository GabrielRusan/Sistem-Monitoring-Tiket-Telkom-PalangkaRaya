import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/auth/auth_remote_datasource.dart';
import 'package:telkom_ticket_manager/utils/constants.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SharedPreferences sharedPref;
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.sharedPref, required this.dio});

  @override
  Future<bool> logIn(
      {required String username, required String password}) async {
    try {
      final response = await dio.post("$baseUrl/login/", data: {
        "username": username,
        "pass": password,
      });

      final data = response.data;

      await sharedPref.setString("token", data["token"]);
      await sharedPref.setString("nama", data["nama"]);
      await sharedPref.setString("id", data["idadmin"].toString());
      return true;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw ConnectionException('TIdak dapat terhubung dengan server!');
      } else if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 401) {
          throw WrongCombinationException(e.response?.data['message']);
        } else if (e.response?.statusCode == 400) {
          throw WrongCombinationException('Field tidak boleh kosong!');
        }
      }
      throw ServerException();
    }
  }

  @override
  Future<bool> logOut() async {
    return await sharedPref.clear();
  }
}
