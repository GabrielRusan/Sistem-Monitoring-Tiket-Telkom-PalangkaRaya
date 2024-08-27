import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/domain/usecases/auth/login.dart';
import 'package:telkom_ticket_manager/utils/transformers.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login usecase;
  LoginBloc(this.usecase) : super(const LoginState()) {
    on<SignIn>(_onSignIn,
        transformer: throttleDroppable(const Duration(seconds: 1)));
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ClearLoginField>(_onClearLoginField);
  }

  void _onUsernameChanged(UsernameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        username: event.value, loginStatus: LoginStatus.initial));
  }

  void _onClearLoginField(ClearLoginField event, Emitter<LoginState> emit) {
    emit(const LoginState());
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        password: event.value, loginStatus: LoginStatus.initial));
  }

  Future<void> _onSignIn(SignIn event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.inProggres));

    final result = await usecase.execute(
      username: state.username,
      password: state.password,
    );

    result.fold((failure) {
      emit(state.copyWith(
          loginStatus: LoginStatus.failed, errorMessage: failure.message));
    }, (status) {
      emit(state.copyWith(loginStatus: LoginStatus.success));
    });
  }
}
