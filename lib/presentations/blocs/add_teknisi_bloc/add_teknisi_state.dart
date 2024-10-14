part of 'add_teknisi_bloc.dart';

final class AddTeknisiState extends Equatable {
  const AddTeknisiState({
    this.name = const Name.pure(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.kehadiran = 'Hadir',
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final Name name;
  final Username username;
  final Password password;
  final String kehadiran;
  final bool isValid;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  AddTeknisiState copyWith({
    Name? name,
    Username? username,
    Password? password,
    String? kehadiran,
    bool? isValid,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return AddTeknisiState(
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
      kehadiran: kehadiran ?? this.kehadiran,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [name, username, password, kehadiran, isValid, status, errorMessage];
}
