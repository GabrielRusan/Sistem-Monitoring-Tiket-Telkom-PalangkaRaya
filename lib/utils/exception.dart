class ServerException implements Exception {}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

class ConnectionException implements Exception {
  final String message;

  ConnectionException(this.message);
}

class DuplicateException implements Exception {
  final String message;

  DuplicateException(this.message);
}

class WrongCombinationException implements Exception {
  final String message;

  WrongCombinationException(this.message);
}

class NoCredentialException implements Exception {}

class InvalidTokenException implements Exception {}

class NotFoundException implements Exception {}

class FieldValidationException implements Exception {}

class NoChangeDataException implements Exception {}
