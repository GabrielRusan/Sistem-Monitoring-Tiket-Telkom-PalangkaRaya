import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/domain/entities/tiket.dart';
import 'package:telkom_ticket_manager/domain/repositories/tiket_repository.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

part 'all_tiket_event.dart';
part 'all_tiket_state.dart';

class AllTiketBloc extends Bloc<AllTiketEvent, AllTiketState> {
  final TiketRepository _tiketRepository;

  AllTiketBloc(this._tiketRepository) : super(const AllTiketState()) {
    on<FetchAllTiket>(_onFetchAllTiket);
  }

  Future<void> _onFetchAllTiket(
      FetchAllTiket event, Emitter<AllTiketState> emit) async {
    emit(state.copyWith(status: AllTiketStatus.loading));
    final result = await _tiketRepository.getAllTiket();

    result.fold((failure) {
      if (failure is NotFoundFailure) {
        emit(state.copyWith(status: AllTiketStatus.empty));
      } else {
        emit(state.copyWith(
            status: AllTiketStatus.error, errorMessage: failure.message));
      }
    }, (data) {
      int todayCount = 0;
      int lastWeekCount = 0;
      int lastMonthCount = 0;
      int lastYearCount = 0;

      DateTime now = DateTime.now();
      DateTime startOfToday = DateTime(now.year, now.month, now.day);
      DateTime startOfWeek = now.subtract(const Duration(days: 7));
      DateTime startOfMonth = now.subtract(const Duration(days: 30));
      DateTime startOfYear = now.subtract(const Duration(days: 365));

      for (Tiket tiket in data) {
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
        status: AllTiketStatus.loaded,
        result: data,
        todayCount: todayCount,
        lastWeekCount: lastWeekCount,
        lastMonthCount: lastMonthCount,
        lastYearCount: lastYearCount,
      ));
    });
  }
}
