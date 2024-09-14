import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telkom_ticket_manager/domain/usecases/auth/logout.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SharedPreferences _sharedPreferences;
  final Logout _logout;
  UserCubit(this._sharedPreferences, this._logout) : super(UserInitial());
  void getUserData() {
    final String? nama = _sharedPreferences.getString('nama');
    if (nama == null) {
      emit(UserError());
    } else {
      print(nama);
      print('kuda cuki');
      emit(UserLoaded(nama: nama));
    }
  }

  Future<void> signOut() async {
    await _logout.execute();
  }
}
