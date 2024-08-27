import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class LoginFailure extends Failure {
  const LoginFailure(super.message);
}

class TokenFailure extends Failure {
  const TokenFailure(super.message);
}

class FieldValidationFailure extends Failure {
  const FieldValidationFailure(super.message);
}

class DuplicateFailure extends Failure {
  const DuplicateFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}
