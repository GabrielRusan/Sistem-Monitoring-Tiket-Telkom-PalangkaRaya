import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:telkom_ticket_manager/domain/entities/admin.dart';
import 'package:telkom_ticket_manager/domain/entities/name.dart';
import 'package:telkom_ticket_manager/domain/entities/password.dart';
import 'package:telkom_ticket_manager/domain/entities/username.dart';
import 'package:telkom_ticket_manager/domain/repositories/admin_repository.dart';

part 'update_admin_event.dart';
part 'update_admin_state.dart';

class UpdateAdminBloc extends Bloc<UpdateAdminEvent, UpdateAdminState> {
  final AdminRepository _adminRepository;
  UpdateAdminBloc(this._adminRepository) : super(const UpdateAdminState()) {
    on<OnChangedName>(_onNameChanged);
    on<OnChangedUsername>(_onUsernameChanged);
    on<OnChangedPassword>(_onPasswordChanged);
    on<SubmitUpdateAdmin>(_onSubmitUpdateAdmin);
    on<ClearUpdateAdmin>((event, emit) => emit(const UpdateAdminState()));
    on<InitialEventAdmin>(
      (event, emit) => emit(UpdateAdminState(
        idAdmin: event.admin.idadmin,
        username: Username.dirty(event.admin.username),
        name: Name.dirty(event.admin.nama),
        password: Password.dirty(event.admin.pass),
      )),
    );
  }

  void _onNameChanged(OnChangedName event, Emitter<UpdateAdminState> emit) {
    final name = Name.dirty(event.value);
    emit(state.copyWith(
        name: name,
        isValid: Formz.validate([name, state.username, state.password])));
  }

  void _onUsernameChanged(
      OnChangedUsername event, Emitter<UpdateAdminState> emit) {
    final username = Username.dirty(event.value);
    emit(state.copyWith(
        username: username,
        isValid: Formz.validate([username, state.name, state.password])));
  }

  void _onPasswordChanged(
      OnChangedPassword event, Emitter<UpdateAdminState> emit) {
    final password = Password.dirty(event.value);
    emit(state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.name, state.username])));
  }

  Future<void> _onSubmitUpdateAdmin(
      SubmitUpdateAdmin event, Emitter<UpdateAdminState> emit) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final Admin admin = Admin(
        idadmin: state.idAdmin,
        nama: state.name.value,
        username: state.username.value,
        pass: state.password.value,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());

    final result = await _adminRepository.updateAdmin(admin);

    result.fold((failure) {
      emit(state.copyWith(
          errorMessage: failure.message,
          status: FormzSubmissionStatus.failure));
    }, (message) {
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    });
  }
}
