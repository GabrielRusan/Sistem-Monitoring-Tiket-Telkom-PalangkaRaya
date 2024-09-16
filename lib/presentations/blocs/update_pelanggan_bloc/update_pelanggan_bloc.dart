import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:telkom_ticket_manager/domain/entities/pelanggan.dart';
import 'package:telkom_ticket_manager/domain/entities/name.dart';
import 'package:telkom_ticket_manager/domain/entities/phone_number.dart';
import 'package:telkom_ticket_manager/domain/entities/username.dart';
import 'package:telkom_ticket_manager/domain/repositories/pelanggan_repository.dart';

part 'update_pelanggan_event.dart';
part 'update_pelanggan_state.dart';

class UpdatePelangganBloc
    extends Bloc<UpdatePelangganEvent, UpdatePelangganState> {
  final PelangganRepository _pelangganRepository;
  UpdatePelangganBloc(this._pelangganRepository)
      : super(const UpdatePelangganState()) {
    on<OnChangedName>(_onNameChanged);
    on<OnChangedAlamat>(_onAlamatChanged);
    on<OnChangedPhoneNumber>(_onPhoneNumberChanged);
    on<SubmitUpdatePelanggan>(_onSubmitUpdatePelanggan);
    on<ClearUpdatePelanggan>(
        (event, emit) => emit(const UpdatePelangganState()));
    on<InitialEventPelanggan>(
      (event, emit) => emit(UpdatePelangganState(
        idPelanggan: event.pelanggan.idpelanggan,
        name: Name.dirty(event.pelanggan.nama),
        alamat: Username.dirty(event.pelanggan.alamat),
        noHp: PhoneNumber.dirty(event.pelanggan.nohp),
      )),
    );
  }

  void _onNameChanged(OnChangedName event, Emitter<UpdatePelangganState> emit) {
    final name = Name.dirty(event.value);
    emit(state.copyWith(
        name: name, isValid: Formz.validate([name, state.alamat, state.noHp])));
  }

  void _onAlamatChanged(
      OnChangedAlamat event, Emitter<UpdatePelangganState> emit) {
    final alamat = Username.dirty(event.value);
    emit(state.copyWith(
        alamat: alamat,
        isValid: Formz.validate([alamat, state.name, state.noHp])));
  }

  void _onPhoneNumberChanged(
      OnChangedPhoneNumber event, Emitter<UpdatePelangganState> emit) {
    final noHp = PhoneNumber.dirty(event.value);
    emit(state.copyWith(
        noHp: noHp, isValid: Formz.validate([noHp, state.name, state.alamat])));
  }

  Future<void> _onSubmitUpdatePelanggan(
      SubmitUpdatePelanggan event, Emitter<UpdatePelangganState> emit) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final Pelanggan pelanggan = Pelanggan(
      idpelanggan: state.idPelanggan,
      nama: state.name.value,
      alamat: state.alamat.value,
      nohp: state.noHp.value,
    );

    final result = await _pelangganRepository.updatePelanggan(pelanggan);

    result.fold((failure) {
      emit(state.copyWith(
          errorMessage: failure.message,
          status: FormzSubmissionStatus.failure));
    }, (message) {
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    });
  }
}
