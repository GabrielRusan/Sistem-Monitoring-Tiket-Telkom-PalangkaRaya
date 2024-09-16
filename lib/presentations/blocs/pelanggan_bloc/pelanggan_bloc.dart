import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/domain/entities/pelanggan.dart';
import 'package:telkom_ticket_manager/domain/repositories/pelanggan_repository.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

part 'pelanggan_event.dart';
part 'pelanggan_state.dart';

class PelangganBloc extends Bloc<PelangganEvent, PelangganState> {
  final PelangganRepository _repository;
  PelangganBloc(this._repository) : super(const PelangganState()) {
    on<SortPelangganEvent>(_onSortPelanggan);
    on<FetchAllPelanggan>(_onFetchAllPelanggan);
    on<SearchPelanggan>(_onSearchTiket);
  }

  void _onSearchTiket(SearchPelanggan event, Emitter<PelangganState> emit) {
    if (event.query.isEmpty) {
      emit(state.copyWith(isFiltered: false, filteredResult: []));
      return;
    }

    List<Pelanggan> filteredResult = [];
    final String query = event.query.toLowerCase();

    for (Pelanggan pelanggan in state.result) {
      final String idPelanggan = pelanggan.idpelanggan.toString().toLowerCase();
      final String nama = pelanggan.nama.toLowerCase();
      final String nohp = pelanggan.nohp.toLowerCase();
      final String alamat = pelanggan.alamat.toLowerCase();

      if (idPelanggan.contains(query) ||
          nama.contains(query) ||
          alamat.contains(query) ||
          nohp.contains(query)) {
        filteredResult.add(pelanggan);
      }
    }

    if (filteredResult.isEmpty) {
      emit(state.copyWith(
          isFiltered: false,
          filteredResult: [],
          status: PelangganStatus.empty));
      return;
    }

    emit(state.copyWith(
        isFiltered: true,
        filteredResult: filteredResult,
        status: PelangganStatus.loaded));
  }

  Future<void> _onFetchAllPelanggan(
      FetchAllPelanggan event, Emitter<PelangganState> emit) async {
    emit(state.copyWith(status: PelangganStatus.loading));

    final result = await _repository.getAllPelanggan();

    result.fold((failure) {
      if (failure is NotFoundFailure) {
        emit(state.copyWith(status: PelangganStatus.empty));
      } else if (failure is TokenFailure) {
        emit(state.copyWith(status: PelangganStatus.tokenInvalid));
      } else {
        emit(state.copyWith(
            status: PelangganStatus.error, errorMessage: failure.message));
      }
    }, (data) {
      emit(state.copyWith(
          result: data, status: PelangganStatus.loaded, errorMessage: null));
    });
  }

  void _onSortPelanggan(
      SortPelangganEvent event, Emitter<PelangganState> emit) {
    final Map<int, Function(Pelanggan, Pelanggan)> sortFunctions = {
      0: (a, b) => a.idpelanggan.compareTo(b.idpelanggan),
      1: (a, b) => a.nama.compareTo(b.nama),
      2: (a, b) => a.alamat.compareTo(b.alamat),
      3: (a, b) => a.nohp.compareTo(b.nohp),
    };

    if (state.isFiltered) {
      List<Pelanggan> sortedResult = List.from(state.filteredResult);

      final sortFunction = sortFunctions[event.columnIndex];

      if (sortFunction != null) {
        sortedResult.sort((a, b) =>
            event.ascending ? sortFunction(a, b) : sortFunction(b, a));
      }

      emit(state.copyWith(
          filteredResult: sortedResult,
          sortColumnIndex: event.columnIndex,
          sortAscending: event.ascending,
          status: PelangganStatus.loaded));
      return;
    }

    List<Pelanggan> sortedResult = List.from(state.result);

    final sortFunction = sortFunctions[event.columnIndex];

    if (sortFunction != null) {
      sortedResult.sort(
          (a, b) => event.ascending ? sortFunction(a, b) : sortFunction(b, a));
    }

    emit(state.copyWith(
        result: sortedResult,
        sortColumnIndex: event.columnIndex,
        sortAscending: event.ascending,
        status: PelangganStatus.loaded));
  }
}
