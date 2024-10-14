import 'package:dartz/dartz.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/teknisi/teknisi_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/models/teknisi_model.dart';
import 'package:telkom_ticket_manager/domain/entities/teknisi.dart';
import 'package:telkom_ticket_manager/domain/repositories/teknisi_repository.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

class TeknisiRepositoryImpl implements TeknisiRepository {
  final TeknisiRemoteDataSource remoteDataSource;

  TeknisiRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> addTeknisi(Teknisi teknisi) async {
    try {
      final result =
          await remoteDataSource.addTeknisi(TeknisiModel.fromEntity(teknisi));
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
  Future<Either<Failure, String>> deleteTeknisi(String id) async {
    try {
      final result = await remoteDataSource.deleteTeknisi(id);
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
  Future<Either<Failure, List<Teknisi>>> getAllTeknisi() async {
    try {
      final result = await remoteDataSource.getAllTeknisi();
      return Right(
          result.teknisiList.map((model) => model.toEntity()).toList());
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
  Future<Either<Failure, String>> updateTeknisi(Teknisi teknisi) async {
    try {
      final result = await remoteDataSource
          .updateTeknisi(TeknisiModel.fromEntity(teknisi));
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
