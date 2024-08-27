import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/auth/auth_remote_datasource.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/teknisi/teknisi_remote_data_source.dart';

@GenerateMocks(
    [Dio, SharedPreferences, AuthRemoteDataSource, TeknisiRemoteDataSource])
void main() {}
