import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:telkom_ticket_manager/data/repositories/auth_repository_impl.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

import '../../helper/test_helpers.mocks.dart';

void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(
      authRemoteDataSource: mockAuthRemoteDataSource,
    );
  });

  const String tUsername = 'username';
  const String tPassword = 'password';

  group('login test', () {
    test('should return true when success login', () async {
      //arrange
      when(mockAuthRemoteDataSource.logIn(
        username: tUsername,
        password: tPassword,
      )).thenAnswer((_) async => true);

      //act
      final result =
          await repository.logIn(username: tUsername, password: tPassword);

      //assert
      expect(result, const Right(true));
    });

    test(
        'should return LoginFailure with correct message when combination is false',
        () async {
      //arrange
      when(mockAuthRemoteDataSource.logIn(
        username: tUsername,
        password: tPassword,
      )).thenThrow(WrongCombinationException('Username not found'));

      //act
      final result =
          await repository.logIn(username: tUsername, password: tPassword);

      //assert
      expect(result, const Left(LoginFailure('Username not found')));
    });

    test('should return ServerFailure when server error', () async {
      //arrange
      when(mockAuthRemoteDataSource.logIn(
        username: tUsername,
        password: tPassword,
      )).thenThrow(ServerException());

      //act
      final result =
          await repository.logIn(username: tUsername, password: tPassword);

      //assert
      expect(result, const Left(ServerFailure('Server Error')));
    });

    test('should return ConnectionFailure when cannot connect to server',
        () async {
      //arrange
      when(mockAuthRemoteDataSource.logIn(
        username: tUsername,
        password: tPassword,
      )).thenThrow(ConnectionException('Gagal menghubungkan dengan server!'));

      //act
      final result =
          await repository.logIn(username: tUsername, password: tPassword);

      //assert
      expect(result,
          const Left(ConnectionFailure('Gagal menghubungkan dengan server!')));
    });
  });
}
