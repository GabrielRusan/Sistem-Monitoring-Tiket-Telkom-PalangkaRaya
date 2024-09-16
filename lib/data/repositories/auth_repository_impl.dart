import 'package:dartz/dartz.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/auth/auth_remote_datasource.dart';
import 'package:telkom_ticket_manager/domain/repositories/auth_repository.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, bool>> logIn(
      {required String username, required String password}) async {
    try {
      final result = await authRemoteDataSource.logIn(
          username: username, password: password);
      return Right(result);
    } on WrongCombinationException catch (e) {
      return Left(LoginFailure(e.message));
    } on ServerException {
      return const Left(ServerFailure('Server Error'));
    } on ConnectionException {
      return const Left(
          ConnectionFailure('Gagal menghubungkan dengan server!'));
    }
  }

  @override
  Future<bool> logOut() async {
    return await authRemoteDataSource.logOut();
  }
}
