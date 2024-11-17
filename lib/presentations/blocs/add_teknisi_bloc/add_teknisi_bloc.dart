import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:telkom_ticket_manager/domain/entities/name.dart';
import 'package:telkom_ticket_manager/domain/entities/password.dart';
import 'package:telkom_ticket_manager/domain/entities/teknisi.dart';
import 'package:telkom_ticket_manager/domain/entities/username.dart';
import 'package:telkom_ticket_manager/domain/repositories/teknisi_repository.dart';

part 'add_teknisi_event.dart';
part 'add_teknisi_state.dart';

class AddTeknisiBloc extends Bloc<AddTeknisiEvent, AddTeknisiState> {
  final TeknisiRepository _teknisiRepository;
  AddTeknisiBloc(this._teknisiRepository) : super(const AddTeknisiState()) {
    on<OnChangedName>(_onNameChanged);
    on<OnChangedUsername>(_onUsernameChanged);
    on<OnChangedPassword>(_onPasswordChanged);
    on<OnChangedKehadiran>(_onKehadiranChanged);
    on<OnChangedKeterangan>(_onKeteranganChanged);
    on<OnChangedStatus>(_onStatusChanged);
    on<SubmitAddTeknisi>(_onSubmitAddTeknisi);
    on<ClearAddTeknisi>((event, emit) => emit(const AddTeknisiState()));
  }

  void _onNameChanged(OnChangedName event, Emitter<AddTeknisiState> emit) {
    final name = Name.dirty(event.value);
    emit(state.copyWith(
        name: name,
        isValid: Formz.validate([name, state.username, state.password])));
  }

  void _onUsernameChanged(
      OnChangedUsername event, Emitter<AddTeknisiState> emit) {
    final username = Username.dirty(event.value);
    emit(state.copyWith(
        username: username,
        isValid: Formz.validate([username, state.name, state.password])));
  }

  void _onPasswordChanged(
      OnChangedPassword event, Emitter<AddTeknisiState> emit) {
    final password = Password.dirty(event.value);
    emit(state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.name, state.username])));
  }

  void _onKehadiranChanged(
      OnChangedKehadiran event, Emitter<AddTeknisiState> emit) {
    emit(state.copyWith(
        kehadiran: event.value,
        isValid: Formz.validate([state.password, state.name, state.username])));
  }

  void _onKeteranganChanged(
      OnChangedKeterangan event, Emitter<AddTeknisiState> emit) {
    emit(state.copyWith(
        keterangan: event.value,
        isValid: Formz.validate([state.password, state.name, state.username])));
  }

  void _onStatusChanged(OnChangedStatus event, Emitter<AddTeknisiState> emit) {
    emit(state.copyWith(
        statusTeknisi: event.value,
        isValid: Formz.validate([state.password, state.name, state.username])));
  }

  Future<void> _onSubmitAddTeknisi(
      SubmitAddTeknisi event, Emitter<AddTeknisiState> emit) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final Teknisi teknisi = Teknisi(
        idteknisi: "-999",
        nama: state.name.value,
        kehadiran: state.kehadiran,
        username: state.username.value,
        pass: state.password.value,
        ket: state.keterangan,
        status: state.statusTeknisi,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());

    final result = await _teknisiRepository.addTeknisi(teknisi);

    result.fold((failure) {
      emit(state.copyWith(
          errorMessage: failure.message,
          status: FormzSubmissionStatus.failure));
    }, (message) {
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    });
  }
}
