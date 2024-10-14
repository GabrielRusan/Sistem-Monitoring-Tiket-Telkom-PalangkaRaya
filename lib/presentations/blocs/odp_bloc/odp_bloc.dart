import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/data/datasources/remote_data_sources/odp/odp_remote_data_source.dart';
import 'package:telkom_ticket_manager/data/models/odp_model.dart';
import 'package:telkom_ticket_manager/date_converter.dart';

part 'odp_event.dart';
part 'odp_state.dart';

class OdpBloc extends Bloc<OdpEvent, OdpState> {
  final OdpRemoteDataSource _odpDatSource;

  OdpBloc(this._odpDatSource) : super(const OdpState()) {
    on<FetchOdp>(_onFetchOdp);
    on<SortOdp>(_onSortOdp);
    on<SearchOdp>(_onSearchOdp);
  }

  void _onSearchOdp(SearchOdp event, Emitter<OdpState> emit) {
    if (event.query.isEmpty) {
      emit(state.copyWith(isFiltered: false, filteredResult: []));
      return;
    }

    List<OdpModel> filteredResult = [];
    final String query = event.query.toLowerCase();

    for (OdpModel odp in state.result) {
      final String idOdp = odp.idodp.toLowerCase();
      final String startTime = dateToStringLengkap(odp.createdAt).toLowerCase();
      final String endTime = dateToStringLengkap(odp.createdAt).toLowerCase();

      if (idOdp.contains(query) ||
          startTime.contains(query) ||
          endTime.contains(query)) {
        filteredResult.add(odp);
      }
    }

    if (filteredResult.isEmpty) {
      emit(state.copyWith(
          isFiltered: false, filteredResult: [], status: OdpStatus.empty));
      return;
    }

    emit(state.copyWith(
        isFiltered: true,
        filteredResult: filteredResult,
        status: OdpStatus.loaded));
  }

  void _onSortOdp(SortOdp event, Emitter<OdpState> emit) {
    final Map<int, Function(OdpModel, OdpModel)> sortFunctions = {
      0: (a, b) => a.idodp.compareTo(b.idodp),
      1: (a, b) => a.createdAt.compareTo(b.createdAt),
      2: (a, b) => a.updatedAt.compareTo(b.updatedAt),
    };

    if (state.isFiltered) {
      List<OdpModel> sortedResult = List.from(state.filteredResult);

      final sortFunction = sortFunctions[event.columnIndex];

      if (sortFunction != null) {
        sortedResult.sort((a, b) =>
            event.ascending ? sortFunction(a, b) : sortFunction(b, a));
      }

      emit(state.copyWith(
          filteredResult: sortedResult,
          sortColumnIndex: event.columnIndex,
          sortAscending: event.ascending,
          status: OdpStatus.loaded));
      return;
    }

    List<OdpModel> sortedResult = List.from(state.result);

    final sortFunction = sortFunctions[event.columnIndex];

    if (sortFunction != null) {
      sortedResult.sort(
          (a, b) => event.ascending ? sortFunction(a, b) : sortFunction(b, a));
    }

    emit(state.copyWith(
        result: sortedResult,
        sortColumnIndex: event.columnIndex,
        sortAscending: event.ascending,
        status: OdpStatus.loaded));
  }

  Future<void> _onFetchOdp(FetchOdp event, Emitter<OdpState> emit) async {
    emit(state.copyWith(status: OdpStatus.loading));
    try {
      final result = await _odpDatSource.getOdp();
      print(result);
      if (result.isEmpty) {
        emit(state.copyWith(status: OdpStatus.empty));
        return;
      }
      emit(state.copyWith(
        status: OdpStatus.loaded,
        result: result,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(
          status: OdpStatus.error, errorMessage: 'Something Wrong Occured'));
    }
  }
}
