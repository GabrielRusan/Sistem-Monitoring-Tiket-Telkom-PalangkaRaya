part of 'update_pelanggan_bloc.dart';

final class UpdatePelangganState extends Equatable {
  const UpdatePelangganState({
    this.idPelanggan = "",
    this.name = const Name.pure(),
    this.alamat = const Username.pure(),
    this.noHp = const PhoneNumber.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final String idPelanggan;
  final Name name;
  final Username alamat;
  final PhoneNumber noHp;
  final bool isValid;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  UpdatePelangganState copyWith({
    String? idPelanggan,
    Name? name,
    Username? alamat,
    PhoneNumber? noHp,
    bool? isValid,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return UpdatePelangganState(
      idPelanggan: idPelanggan ?? this.idPelanggan,
      name: name ?? this.name,
      alamat: alamat ?? this.alamat,
      noHp: noHp ?? this.noHp,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [idPelanggan, name, alamat, noHp, isValid, status, errorMessage];
}
