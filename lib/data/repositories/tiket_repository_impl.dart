import 'package:dartz/dartz.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/tiket/tiket_remote_data_source.dart';
import 'package:telkom_ticket_manager/domain/entities/tiket.dart';
import 'package:telkom_ticket_manager/domain/repositories/tiket_repository.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

class TiketRepositoryImpl implements TiketRepository {
  final TiketRemoteDataSource remoteSource;

  TiketRepositoryImpl({required this.remoteSource});
  @override
  Future<Either<Failure, List<Tiket>>> getAllActiveTiket() async {
    try {
      final result = await remoteSource.getAllActiveTiket();
      return Right(
          result.teknisiList.map((model) => model.toEntity()).toList());
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
  Future<Either<Failure, List<Tiket>>> getAllHistoricTiket() async {
    try {
      final result = await remoteSource.getAllHistoricTiket();
      return Right(
          result.teknisiList.map((model) => model.toEntity()).toList());
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
