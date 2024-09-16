import 'package:dartz/dartz.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/admin/admin_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/models/admin_model.dart';
import 'package:telkom_ticket_manager/domain/entities/admin.dart';
import 'package:telkom_ticket_manager/domain/repositories/admin_repository.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource remoteDataSource;

  AdminRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Admin>>> getAllAdmin() async {
    try {
      final result = await remoteDataSource.getAllAdmin();
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
  Future<Either<Failure, String>> updateAdmin(Admin teknisi) async {
    try {
      final result =
          await remoteDataSource.updateAdmin(AdminModel.fromEntity(teknisi));
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
