import 'package:dartz/dartz.dart';
import 'package:telkom_ticket_manager/domain/repositories/auth_repository.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

class Login {
  final AuthRepository repository;

  Login({required this.repository});

  Future<Either<Failure, bool>> execute(
          {required String username, required String password}) =>
      repository.logIn(username: username, password: password);
}
