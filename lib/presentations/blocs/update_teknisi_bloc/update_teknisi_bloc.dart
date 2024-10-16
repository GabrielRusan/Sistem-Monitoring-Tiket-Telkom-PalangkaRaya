import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:telkom_ticket_manager/domain/entities/name.dart';
import 'package:telkom_ticket_manager/domain/entities/password.dart';
import 'package:telkom_ticket_manager/domain/entities/teknisi.dart';
import 'package:telkom_ticket_manager/domain/entities/username.dart';
import 'package:telkom_ticket_manager/domain/repositories/teknisi_repository.dart';

part 'update_teknisi_event.dart';
part 'update_teknisi_state.dart';

class UpdateTeknisiBloc extends Bloc<UpdateTeknisiEvent, UpdateTeknisiState> {
  final TeknisiRepository _teknisiRepository;
  UpdateTeknisiBloc(this._teknisiRepository)
      : super(const UpdateTeknisiState()) {
    on<OnChangedName>(_onNameChanged);
    on<OnChangedUsername>(_onUsernameChanged);
    on<OnChangedPassword>(_onPasswordChanged);
    on<OnChangedKehadiran>(_onKehadiranChanged);
    on<SubmitUpdateTeknisi>(_onSubmitUpdateTeknisi);
    on<ClearUpdateTeknisi>((event, emit) => emit(const UpdateTeknisiState()));
    on<InitialEventTeknisi>(
      (event, emit) => emit(UpdateTeknisiState(
          idTeknisi: event.teknisi.idteknisi,
          username: Username.dirty(event.teknisi.username),
          name: Name.dirty(event.teknisi.nama),
          password: Password.dirty(event.teknisi.pass),
          kehadiran: event.teknisi.kehadiran)),
    );
  }

  void _onNameChanged(OnChangedName event, Emitter<UpdateTeknisiState> emit) {
    final name = Name.dirty(event.value);
    emit(state.copyWith(
        name: name,
        isValid: Formz.validate([name, state.username, state.password])));
  }

  void _onUsernameChanged(
      OnChangedUsername event, Emitter<UpdateTeknisiState> emit) {
    final username = Username.dirty(event.value);
    emit(state.copyWith(
        username: username,
        isValid: Formz.validate([username, state.name, state.password])));
  }

  void _onPasswordChanged(
      OnChangedPassword event, Emitter<UpdateTeknisiState> emit) {
    final password = Password.dirty(event.value);
    emit(state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.name, state.username])));
  }

  void _onKehadiranChanged(
      OnChangedKehadiran event, Emitter<UpdateTeknisiState> emit) {
    emit(state.copyWith(
        kehadiran: event.value,
        isValid: Formz.validate([state.password, state.name, state.username])));
  }

  Future<void> _onSubmitUpdateTeknisi(
      SubmitUpdateTeknisi event, Emitter<UpdateTeknisiState> emit) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final Teknisi teknisi = Teknisi(
        idteknisi: state.idTeknisi,
        nama: state.name.value,
        kehadiran: state.kehadiran,
        username: state.username.value,
        pass: state.password.value,
        ket: 'available',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());

    final result = await _teknisiRepository.updateTeknisi(teknisi);

    result.fold((failure) {
      emit(state.copyWith(
          errorMessage: failure.message,
          status: FormzSubmissionStatus.failure));
    }, (message) {
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    });
  }
}
