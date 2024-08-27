import 'package:dartz/dartz.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> logIn(
      {required String username, required String password});
  Future<bool> logOut();
}
