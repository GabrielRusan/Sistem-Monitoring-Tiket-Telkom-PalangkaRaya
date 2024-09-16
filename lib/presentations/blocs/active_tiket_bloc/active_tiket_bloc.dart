import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/date_converter.dart';
import 'package:telkom_ticket_manager/domain/entities/tiket.dart';
import 'package:telkom_ticket_manager/domain/repositories/tiket_repository.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

part 'active_tiket_event.dart';
part 'active_tiket_state.dart';

class ActiveTiketBloc extends Bloc<ActiveTiketEvent, ActiveTiketState> {
  final TiketRepository _tiketRepository;

  ActiveTiketBloc(this._tiketRepository) : super(const ActiveTiketState()) {
    on<FetchActiveTiket>(_onFetchActiveTiket);
    on<SortActiveTiket>(_onSortTiket);
    on<SearchActiveTiket>(_onSearchTiket);
  }

  void _onSearchTiket(SearchActiveTiket event, Emitter<ActiveTiketState> emit) {
    if (event.query.isEmpty) {
      emit(state.copyWith(isFiltered: false, filteredResult: []));
      return;
    }

    List<Tiket> filteredResult = [];
    final String query = event.query.toLowerCase();

    for (Tiket tiket in state.result) {
      final String noTiket = tiket.nomorTiket.toLowerCase();
      final String namaPelanggan = tiket.pelanggan.nama.toLowerCase();
      final String alamatPelanggan = tiket.pelanggan.alamat.toLowerCase();
      final String keluhan = tiket.keluhan.toLowerCase();
      final String odp = tiket.idOdp.toLowerCase();
      final String namaTeknisi = tiket.namaTeknisi.toLowerCase();
      final String tipe = tiket.type.toLowerCase();
      final String status = tiket.status.toLowerCase();
      final String startTime =
          dateToStringLengkap(tiket.createdAt).toLowerCase();

      if (noTiket.contains(query) ||
          namaPelanggan.contains(query) ||
          alamatPelanggan.contains(query) ||
          keluhan.contains(query) ||
          odp.contains(query) ||
          tipe.contains(query) ||
          status.contains(query) ||
          startTime.contains(query) ||
          namaTeknisi.contains(query)) {
        filteredResult.add(tiket);
      }
    }

    if (filteredResult.isEmpty) {
      emit(state.copyWith(
          isFiltered: false,
          filteredResult: [],
          status: ActiveTiketStatus.empty));
      return;
    }

    emit(state.copyWith(
        isFiltered: true,
        filteredResult: filteredResult,
        status: ActiveTiketStatus.loaded));
  }

  void _onSortTiket(SortActiveTiket event, Emitter<ActiveTiketState> emit) {
    final Map<int, Function(Tiket, Tiket)> sortFunctions = {
      0: (a, b) => a.nomorTiket.compareTo(b.nomorTiket),
      1: (a, b) => a.pelanggan.nama.compareTo(b.pelanggan.nama),
      2: (a, b) => a.pelanggan.alamat.compareTo(b.pelanggan.alamat),
      3: (a, b) => a.keluhan.compareTo(b.keluhan),
      4: (a, b) => a.idOdp.compareTo(b.idOdp),
      5: (a, b) => a.createdAt.compareTo(b.createdAt),
      6: (a, b) => a.namaTeknisi.compareTo(b.namaTeknisi),
      7: (a, b) => a.type.compareTo(b.type),
      8: (a, b) => a.status.compareTo(b.status),
    };

    if (state.isFiltered) {
      List<Tiket> sortedResult = List.from(state.filteredResult);

      final sortFunction = sortFunctions[event.columnIndex];

      if (sortFunction != null) {
        sortedResult.sort((a, b) =>
            event.ascending ? sortFunction(a, b) : sortFunction(b, a));
      }

      emit(state.copyWith(
          filteredResult: sortedResult,
          sortColumnIndex: event.columnIndex,
          sortAscending: event.ascending,
          status: ActiveTiketStatus.loaded));
      return;
    }

    List<Tiket> sortedResult = List.from(state.result);

    final sortFunction = sortFunctions[event.columnIndex];

    if (sortFunction != null) {
      sortedResult.sort(
          (a, b) => event.ascending ? sortFunction(a, b) : sortFunction(b, a));
    }

    emit(state.copyWith(
        result: sortedResult,
        sortColumnIndex: event.columnIndex,
        sortAscending: event.ascending,
        status: ActiveTiketStatus.loaded));
  }

  Future<void> _onFetchActiveTiket(
      FetchActiveTiket event, Emitter<ActiveTiketState> emit) async {
    emit(state.copyWith(status: ActiveTiketStatus.loading));
    final result = await _tiketRepository.getAllActiveTiket();

    result.fold((failure) {
      if (failure is NotFoundFailure) {
        emit(state.copyWith(status: ActiveTiketStatus.empty));
      } else {
        emit(state.copyWith(
            status: ActiveTiketStatus.error, errorMessage: failure.message));
      }
    }, (data) {
      if (data.isEmpty) {
        emit(state.copyWith(status: ActiveTiketStatus.empty));
        return;
      }
      int inProgressCount = 0;
      int ditugaskanCount = 0;

      for (Tiket tiket in data) {
        if (tiket.status == "In Progress") {
          inProgressCount += 1;
        } else if (tiket.status == "Ditugaskan") {
          ditugaskanCount += 1;
        }
      }

      emit(state.copyWith(
        status: ActiveTiketStatus.loaded,
        result: data,
        inProgressCount: inProgressCount,
        ditugaskanCount: ditugaskanCount,
      ));
    });
  }
}
