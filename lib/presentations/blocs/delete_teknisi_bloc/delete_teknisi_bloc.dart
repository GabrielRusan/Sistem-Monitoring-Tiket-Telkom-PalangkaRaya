import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/domain/repositories/teknisi_repository.dart';

part 'delete_teknisi_event.dart';
part 'delete_teknisi_state.dart';

class DeleteTeknisiBloc extends Bloc<DeleteTeknisiEvent, DeleteTeknisiState> {
  final TeknisiRepository _teknisiRepo;
  DeleteTeknisiBloc(this._teknisiRepo) : super(InitialDeleteTeknisi()) {
    on<DeleteTeknisi>((event, emit) async {
      emit(LoadingDeleteTeknisi());
      final result = await _teknisiRepo.deleteTeknisi(event.idTeknisi);

      result.fold((failure) {
        emit(FailedDeleteTeknisi(message: failure.message));
      }, (message) {
        emit(SuccessDeleteTeknisi(message: message));
      });
    });
    on<WarningDeleteTeknisiEvent>(
      (event, emit) {
        emit(InitialDeleteTeknisi());
        emit(WarningDeleteTeknisi(
            idTeknisi: event.idTeknisi, namaTeknisi: event.namaTeknisi));
      },
    );
  }
}
