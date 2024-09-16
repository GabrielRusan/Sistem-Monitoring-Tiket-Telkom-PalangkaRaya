part of 'login_bloc.dart';

enum LoginStatus { success, inProggres, failed, initial }

final class LoginState extends Equatable {
  const LoginState({
    this.username = '',
    this.password = '',
    this.loginStatus = LoginStatus.initial,
    this.errorMessage = '',
  });

  final String username;
  final String password;
  final LoginStatus loginStatus;
  final String errorMessage;

  LoginState copyWith({
    String? username,
    String? password,
    LoginStatus? loginStatus,
    String? errorMessage,
  }) =>
      LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        loginStatus: loginStatus ?? this.loginStatus,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props => [username, password, loginStatus, errorMessage];
}
