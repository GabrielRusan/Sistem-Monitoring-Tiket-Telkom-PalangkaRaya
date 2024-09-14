part of 'update_admin_bloc.dart';

final class UpdateAdminState extends Equatable {
  const UpdateAdminState({
    this.idAdmin = -999,
    this.name = const Name.pure(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final int idAdmin;
  final Name name;
  final Username username;
  final Password password;
  final bool isValid;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  UpdateAdminState copyWith({
    int? idAdmin,
    Name? name,
    Username? username,
    Password? password,
    bool? isValid,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return UpdateAdminState(
      idAdmin: idAdmin ?? this.idAdmin,
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [idAdmin, name, username, password, isValid, status, errorMessage];
}
