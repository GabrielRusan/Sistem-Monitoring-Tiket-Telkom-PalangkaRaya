import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:telkom_ticket_manager/data/repositories/teknisi_repository_impl.dart';
import 'package:telkom_ticket_manager/utils/exception.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

import '../../dummy_data/dummy_object.dart';
import '../../helper/test_helpers.mocks.dart';

void main() {
  late MockTeknisiRemoteDataSource mockTeknisiRemoteDataSource;
  late TeknisiRepositoryImpl repo;

  setUp(() {
    mockTeknisiRemoteDataSource = MockTeknisiRemoteDataSource();
    repo = TeknisiRepositoryImpl(remoteDataSource: mockTeknisiRemoteDataSource);
  });

  group('getAllTeknisi', () {
    test('should return list of teknisi when call to remote is successful',
        () async {
      //arrange
      when(mockTeknisiRemoteDataSource.getAllTeknisi())
          .thenAnswer((_) async => tTeknisiResponseModel);
      //act
      final result = await repo.getAllTeknisi();
      //assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTeknisiList);
    });

    test(
        'should return TokenFailure when remote data throw InvalidTokenException',
        () async {
      //arrange
      when(mockTeknisiRemoteDataSource.getAllTeknisi())
          .thenThrow(InvalidTokenException());
      //act
      final result = await repo.getAllTeknisi();
      //assert
      expect(result, const Left(TokenFailure('Sesi anda telah berakhir!')));
    });

    test(
        'should return TokenFailure when remote data throw NoCredentialException',
        () async {
      //arrange
      when(mockTeknisiRemoteDataSource.getAllTeknisi())
          .thenThrow(NoCredentialException());
      //act
      final result = await repo.getAllTeknisi();
      //assert
      expect(result, const Left(TokenFailure('Sesi anda telah berakhir!')));
    });

    test(
        'should return NotFoundFailure when remote data throw NotFoundException',
        () async {
      //arrange
      when(mockTeknisiRemoteDataSource.getAllTeknisi())
          .thenThrow(NotFoundException());
      //act
      final result = await repo.getAllTeknisi();
      //assert
      expect(result, const Left(NotFoundFailure('')));
    });

    test(
        'should return NotFoundFailure when remote data throw NotFoundExeption',
        () async {
      //arrange
      when(mockTeknisiRemoteDataSource.getAllTeknisi())
          .thenThrow(NotFoundException());
      //act
      final result = await repo.getAllTeknisi();
      //assert
      expect(result, const Left(NotFoundFailure('')));
    });

    test(
        'should return ConnectionFailure when remote data throw ConnectionException',
        () async {
      //arrange
      when(mockTeknisiRemoteDataSource.getAllTeknisi())
          .thenThrow(ConnectionException(''));
      //act
      final result = await repo.getAllTeknisi();
      //assert
      expect(result, const Left(ConnectionFailure('')));
    });

    test('should return ServerFailure when remote data throw ServerException',
        () async {
      //arrange
      when(mockTeknisiRemoteDataSource.getAllTeknisi())
          .thenThrow(ServerException());
      //act
      final result = await repo.getAllTeknisi();
      //assert
      expect(result, const Left(ServerFailure('Server Error!')));
    });
  });
}
