import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/domain/entities/teknisi.dart';
import 'package:telkom_ticket_manager/domain/usecases/teknisi/get_all_teknisi.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

part 'teknisi_event.dart';
part 'teknisi_state.dart';

class TeknisiBloc extends Bloc<TeknisiEvent, TeknisiState> {
  final GetAllTeknisi getAllTeknisi;
  TeknisiBloc(this.getAllTeknisi) : super(const TeknisiState()) {
    on<SortTeknisiEvent>(_onSortTeknisi);
    on<FetchAllTeknisi>(_onFetchAllTeknisi);
  }

  Future<void> _onFetchAllTeknisi(
      FetchAllTeknisi event, Emitter<TeknisiState> emit) async {
    emit(state.copyWith(status: TeknisiStatus.loading));

    final result = await getAllTeknisi.execute();

    result.fold((failure) {
      print(failure.message);
      if (failure is NotFoundFailure) {
        emit(state.copyWith(status: TeknisiStatus.empty));
      } else if (failure is TokenFailure) {
        emit(state.copyWith(status: TeknisiStatus.tokenInvalid));
      } else {
        emit(state.copyWith(
            status: TeknisiStatus.error, errorMessage: failure.message));
      }
    }, (data) {
      emit(state.copyWith(
          result: data, status: TeknisiStatus.loaded, errorMessage: null));
    });
  }

  void _onSortTeknisi(SortTeknisiEvent event, Emitter<TeknisiState> emit) {
    List<Teknisi> sortedResult = List.from(state.result);

    final Map<int, Function(Teknisi, Teknisi)> sortFunctions = {
      0: (a, b) => a.idteknisi.compareTo(b.idteknisi),
      1: (a, b) => a.username.compareTo(b.username),
      2: (a, b) => a.nama.compareTo(b.nama),
      3: (a, b) => a.sektor.compareTo(b.sektor),
      4: (a, b) => a.ket.compareTo(b.ket),
      5: (a, b) => a.createdAt.compareTo(b.createdAt),
    };

    final sortFunction = sortFunctions[event.columnIndex];

    if (sortFunction != null) {
      sortedResult.sort(
          (a, b) => event.ascending ? sortFunction(a, b) : sortFunction(b, a));
    }

    emit(state.copyWith(
        result: sortedResult,
        sortColumnIndex: event.columnIndex,
        sortAscending: event.ascending,
        status: TeknisiStatus.loaded));
  }
}
