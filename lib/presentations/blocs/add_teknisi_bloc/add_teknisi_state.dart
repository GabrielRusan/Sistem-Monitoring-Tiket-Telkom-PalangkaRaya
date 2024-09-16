part of 'add_teknisi_bloc.dart';

final class AddTeknisiState extends Equatable {
  const AddTeknisiState({
    this.name = const Name.pure(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.sektor = 'plk1',
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final Name name;
  final Username username;
  final Password password;
  final String sektor;
  final bool isValid;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  AddTeknisiState copyWith({
    Name? name,
    Username? username,
    Password? password,
    String? sektor,
    bool? isValid,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return AddTeknisiState(
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
      sektor: sektor ?? this.sektor,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [name, username, password, sektor, isValid, status, errorMessage];
}
