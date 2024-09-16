import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/date_converter.dart';
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
    on<SearchTeknisi>(_onSearchTiket);
  }

  void _onSearchTiket(SearchTeknisi event, Emitter<TeknisiState> emit) {
    if (event.query.isEmpty) {
      emit(state.copyWith(isFiltered: false, filteredResult: []));
      return;
    }

    List<Teknisi> filteredResult = [];
    final String query = event.query.toLowerCase();

    for (Teknisi teknisi in state.result) {
      final String idTeknisi = teknisi.idteknisi.toString().toLowerCase();
      final String usename = teknisi.username.toLowerCase();
      final String password = teknisi.pass.toLowerCase();
      final String nama = teknisi.nama.toLowerCase();
      final String sektor = teknisi.sektor.toLowerCase();
      final String ket = teknisi.ket.toLowerCase();

      final String createdAt =
          dateToStringLengkap(teknisi.createdAt).toLowerCase();

      if (idTeknisi.contains(query) ||
          usename.contains(query) ||
          password.contains(query) ||
          nama.contains(query) ||
          sektor.contains(query) ||
          createdAt.contains(query) ||
          ket.contains(query)) {
        filteredResult.add(teknisi);
      }
    }

    if (filteredResult.isEmpty) {
      emit(state.copyWith(
          isFiltered: false, filteredResult: [], status: TeknisiStatus.empty));
      return;
    }

    emit(state.copyWith(
        isFiltered: true,
        filteredResult: filteredResult,
        status: TeknisiStatus.loaded));
  }

  Future<void> _onFetchAllTeknisi(
      FetchAllTeknisi event, Emitter<TeknisiState> emit) async {
    emit(state.copyWith(status: TeknisiStatus.loading));

    final result = await getAllTeknisi.execute();

    result.fold((failure) {
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
    final Map<int, Function(Teknisi, Teknisi)> sortFunctions = {
      0: (a, b) => a.idteknisi.compareTo(b.idteknisi),
      1: (a, b) => a.username.toLowerCase().compareTo(b.username.toLowerCase()),
      2: (a, b) => a.pass.compareTo(b.pass),
      3: (a, b) => a.nama.compareTo(b.nama),
      4: (a, b) => a.sektor.compareTo(b.sektor),
      5: (a, b) => a.ket.compareTo(b.ket),
      6: (a, b) => a.createdAt.compareTo(b.createdAt),
    };

    if (state.isFiltered) {
      List<Teknisi> sortedResult = List.from(state.filteredResult);

      final sortFunction = sortFunctions[event.columnIndex];

      if (sortFunction != null) {
        sortedResult.sort((a, b) =>
            event.ascending ? sortFunction(a, b) : sortFunction(b, a));
      }

      emit(state.copyWith(
          filteredResult: sortedResult,
          sortColumnIndex: event.columnIndex,
          sortAscending: event.ascending,
          status: TeknisiStatus.loaded));
      return;
    }

    List<Teknisi> sortedResult = List.from(state.result);

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
