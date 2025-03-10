import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/rekap_absen/rekap_absen_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/models/rekap_model.dart';
import 'package:telkom_ticket_manager/utils/constants.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';

class RekapAbsenRemoteDataSourceImpl implements RekapAbsenRemoteDataSource {
  final Dio _dio;
  final SharedPreferences _sharedPref;

  const RekapAbsenRemoteDataSourceImpl(this._dio, this._sharedPref);

  @override
  Future<RekapAbsenModel> getRekapAbsen(
      {String filter = 'today', DateTimeRange? rangeTanggalCustom}) async {
    final String? token = _sharedPref.getString('token');

    if (token == null) throw NoCredentialException();

    try {
      if (filter == 'custom') {
        DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
        final startDate = dateFormatter.format(rangeTanggalCustom!.start);
        final endDate = dateFormatter.format(rangeTanggalCustom.end);
        final result = await _dio.get(
          '$baseUrl/teknisi/rekap?filter=$filter&start_date=$startDate&end_date=$endDate',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
        return RekapAbsenModel.fromJson(result.data);
      }
      final result = await _dio.get(
        '$baseUrl/teknisi/rekap?filter=$filter',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return RekapAbsenModel.fromJson(result.data);
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionError:
          throw ConnectionException('Gagal menghubungkan dengan server!');
        case DioExceptionType.connectionTimeout:
          throw ConnectionException('Gagal menghubungkan dengan server!');
        case DioExceptionType.badResponse:
          switch (e.response?.statusCode) {
            case 400:
              throw DuplicateException(e.response?.data['message']);
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
      throw Exception();
    }
  }
}
