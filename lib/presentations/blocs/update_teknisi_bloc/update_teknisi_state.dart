part of 'update_teknisi_bloc.dart';

final class UpdateTeknisiState extends Equatable {
  const UpdateTeknisiState({
    this.idTeknisi = '',
    this.name = const Name.pure(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.kehadiran = 'Hadir',
    this.keterangan = 'Available',
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.statusTeknisi = 'Aktif',
    this.errorMessage,
  });

  final String idTeknisi;
  final Name name;
  final Username username;
  final Password password;
  final String kehadiran;
  final String keterangan;
  final bool isValid;
  final String statusTeknisi;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  UpdateTeknisiState copyWith({
    String? idTeknisi,
    Name? name,
    Username? username,
    Password? password,
    String? kehadiran,
    String? keterangan,
    bool? isValid,
    String? statusTeknisi,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return UpdateTeknisiState(
      idTeknisi: idTeknisi ?? this.idTeknisi,
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
      kehadiran: kehadiran ?? this.kehadiran,
      keterangan: keterangan ?? this.keterangan,
      statusTeknisi: statusTeknisi ?? this.statusTeknisi,
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
        statusTeknisi,
        errorMessage
      ];
}
