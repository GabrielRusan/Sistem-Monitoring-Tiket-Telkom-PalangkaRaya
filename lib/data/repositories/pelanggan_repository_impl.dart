import 'package:dartz/dartz.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/pelanggan/pelanggan_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/models/pelanggan_model.dart';
import 'package:telkom_ticket_manager/domain/entities/pelanggan.dart';
import 'package:telkom_ticket_manager/domain/repositories/pelanggan_repository.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

class PelangganRepositoryImpl implements PelangganRepository {
  final PelangganRemoteDataSource remoteDataSource;

  PelangganRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> addPelanggan(Pelanggan pelanggan) async {
    try {
      final result = await remoteDataSource
          .addPelanggan(PelangganModel.fromEntity(pelanggan));
      return Right(result);
    } on FieldValidationException {
      return const Left(FieldValidationFailure('Field tidak boleh kosong!'));
    } on DuplicateException catch (e) {
      return Left(DuplicateFailure(e.message));
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

  @override
  Future<Either<Failure, List<Pelanggan>>> getAllPelanggan() async {
    try {
      final result = await remoteDataSource.getAllPelanggan();
      return Right(
          result.pelangganList.map((model) => model.toEntity()).toList());
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

  @override
  Future<Either<Failure, String>> updatePelanggan(Pelanggan pelanggan) async {
    try {
      final result = await remoteDataSource
          .updatePelanggan(PelangganModel.fromEntity(pelanggan));
      return Right(result);
    } on FieldValidationException {
      return const Left(FieldValidationFailure('Field tidak boleh kosong!'));
    } on DuplicateException catch (e) {
      return Left(DuplicateFailure(e.message));
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
