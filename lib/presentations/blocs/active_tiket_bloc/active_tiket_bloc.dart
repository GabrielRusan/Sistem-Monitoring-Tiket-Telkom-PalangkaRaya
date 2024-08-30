import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/domain/entities/tiket.dart';
import 'package:telkom_ticket_manager/domain/repositories/tiket_repository.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

part 'active_tiket_event.dart';
part 'active_tiket_state.dart';

class ActiveTiketBloc extends Bloc<ActiveTiketEvent, ActiveTiketState> {
  final TiketRepository _tiketRepository;

  ActiveTiketBloc(this._tiketRepository) : super(const ActiveTiketState()) {
    on<FetchActiveTiket>(_onFetchActiveTiket);
    on<SortActiveTiket>(_onSortTeknisi);
  }

  void _onSortTeknisi(SortActiveTiket event, Emitter<ActiveTiketState> emit) {
    List<Tiket> sortedResult = List.from(state.result);

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
      int inProgressCount = 0;
      int ditugaskanCount = 0;
      int todayCount = 0;
      int lastWeekCount = 0;
      int lastMonthCount = 0;
      int lastYearCount = 0;

      DateTime now = DateTime.now();
      DateTime startOfToday = DateTime(now.year, now.month, now.day);
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      DateTime startOfMonth = DateTime(now.year, now.month, 1);
      DateTime startOfYear = DateTime(now.year, 1, 1);

      for (Tiket tiket in data) {
        if (tiket.status == "InProgress") {
          inProgressCount += 1;
        } else if (tiket.status == "Ditugaskan") {
          ditugaskanCount += 1;
        }

        DateTime createdAt = tiket.createdAt;

        if (createdAt.isAfter(startOfToday)) {
          todayCount += 1;
        }
        if (createdAt.isAfter(startOfWeek)) {
          lastWeekCount += 1;
        }
        if (createdAt.isAfter(startOfMonth)) {
          lastMonthCount += 1;
        }
        if (createdAt.isAfter(startOfYear)) {
          lastYearCount += 1;
        }
      }

      emit(state.copyWith(
        status: ActiveTiketStatus.loaded,
        result: data,
        inProgressCount: inProgressCount,
        ditugaskanCount: ditugaskanCount,
        todayCount: todayCount,
        lastWeekCount: lastWeekCount,
        lastMonthCount: lastMonthCount,
        lastYearCount: lastYearCount,
      ));
    });
  }
}
