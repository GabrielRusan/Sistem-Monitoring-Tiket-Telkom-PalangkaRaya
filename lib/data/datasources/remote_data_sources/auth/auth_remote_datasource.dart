abstract class AuthRemoteDataSource {
  Future<bool> logIn({required String username, required String password});
  Future<bool> logOut();
}
