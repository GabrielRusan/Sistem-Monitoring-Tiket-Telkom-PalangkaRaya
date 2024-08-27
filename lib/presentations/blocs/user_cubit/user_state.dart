part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoaded extends UserState {
  final String nama;

  const UserLoaded({required this.nama});

  @override
  List<Object> get props => [nama];
}

final class UserError extends UserState {}
