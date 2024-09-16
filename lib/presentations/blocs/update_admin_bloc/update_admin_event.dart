part of 'update_admin_bloc.dart';

sealed class UpdateAdminEvent extends Equatable {
  const UpdateAdminEvent();

  @override
  List<Object> get props => [];
}

final class OnChangedName extends UpdateAdminEvent {
  final String value;

  const OnChangedName({required this.value});

  @override
  List<Object> get props => [value];
}

final class OnChangedUsername extends UpdateAdminEvent {
  final String value;

  const OnChangedUsername({required this.value});

  @override
  List<Object> get props => [value];
}

final class OnChangedPassword extends UpdateAdminEvent {
  final String value;

  const OnChangedPassword({required this.value});

  @override
  List<Object> get props => [value];
}

final class SubmitUpdateAdmin extends UpdateAdminEvent {}

final class ClearUpdateAdmin extends UpdateAdminEvent {}

final class InitialEventAdmin extends UpdateAdminEvent {
  final Admin admin;

  const InitialEventAdmin({required this.admin});

  @override
  List<Object> get props => [admin];
}
