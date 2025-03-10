import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/rekap_absen/rekap_absen_remote_data_source.dart';
import 'package:telkom_ticket_manager/domain/entities/rekap_absen.dart';
import 'package:telkom_ticket_manager/domain/repositories/rekap_absen_repository.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

class RekapAbsenRepositoryImpl implements RekapAbsenRepository {
  final RekapAbsenRemoteDataSource datasource;

  RekapAbsenRepositoryImpl({required this.datasource});
  @override
  Future<Either<Failure, RekapAbsen>> getRekapAbsen(
      {String filter = 'today', DateTimeRange? rangeTanggalCustom}) async {
    try {
      final result = await datasource.getRekapAbsen(
          filter: filter, rangeTanggalCustom: rangeTanggalCustom);
      return Right(RekapAbsen.fromModel(result));
    } on InvalidTokenException {
      return const Left(TokenFailure('Sesi anda telah berakhir!'));
    } on NoCredentialException {
      return const Left(TokenFailure('Sesi anda telah berakhir!'));
    } on NotFoundException {
      return const Left(NotFoundFailure(''));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message));
    } on ServerException {
      return const Left(ServerFailure('Server Error!'));
    }
  }
}
