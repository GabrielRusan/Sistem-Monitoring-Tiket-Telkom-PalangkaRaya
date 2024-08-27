part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SignIn extends LoginEvent {}

class UsernameChanged extends LoginEvent {
  final String value;

  const UsernameChanged({required this.value});

  @override
  List<Object> get props => [value];
}

class PasswordChanged extends LoginEvent {
  final String value;

  const PasswordChanged({required this.value});

  @override
  List<Object> get props => [value];
}

class ClearLoginField extends LoginEvent {}
