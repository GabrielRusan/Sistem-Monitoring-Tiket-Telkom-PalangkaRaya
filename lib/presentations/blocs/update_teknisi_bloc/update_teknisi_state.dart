part of 'update_teknisi_bloc.dart';

final class UpdateTeknisiState extends Equatable {
  const UpdateTeknisiState({
    this.idTeknisi = '',
    this.name = const Name.pure(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.kehadiran = 'hadir',
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final String idTeknisi;
  final Name name;
  final Username username;
  final Password password;
  final String kehadiran;
  final bool isValid;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  UpdateTeknisiState copyWith({
    String? idTeknisi,
    Name? name,
    Username? username,
    Password? password,
    String? kehadiran,
    bool? isValid,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return UpdateTeknisiState(
      idTeknisi: idTeknisi ?? this.idTeknisi,
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
  List<Object?> get props => [
        idTeknisi,
        name,
        username,
        password,
        kehadiran,
        isValid,
        status,
        errorMessage
      ];
}
