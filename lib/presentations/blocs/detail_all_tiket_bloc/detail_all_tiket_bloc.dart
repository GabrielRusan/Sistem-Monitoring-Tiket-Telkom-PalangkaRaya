import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/domain/entities/tiket.dart';
import 'package:telkom_ticket_manager/domain/repositories/tiket_repository.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

part 'detail_all_tiket_event.dart';
part 'detail_all_tiket_state.dart';

class DetailAllTiketBloc
    extends Bloc<DetailAllTiketEvent, DetailAllTiketState> {
  final TiketRepository _tiketRepository;

  DetailAllTiketBloc(this._tiketRepository)
      : super(const DetailAllTiketState()) {
    on<FetchDetailAllTiketByIdPelanggan>(_onFetchDetailAllTiketByIdPelanggan);
    on<FetchDetailAllTiketByIdTeknisi>(_onFetchDetailAllTiketByIdTeknisi);
  }

  Future<void> _onFetchDetailAllTiketByIdPelanggan(
      FetchDetailAllTiketByIdPelanggan event,
      Emitter<DetailAllTiketState> emit) async {
    emit(state.copyWith(status: DetailAllTiketStatus.loading));
    final result =
        await _tiketRepository.getAllTiketByIdPelanggan(event.idPelanggan);

    result.fold((failure) {
      if (failure is NotFoundFailure) {
        emit(state.copyWith(status: DetailAllTiketStatus.empty));
      } else {
        emit(state.copyWith(
            status: DetailAllTiketStatus.error, errorMessage: failure.message));
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
        status: DetailAllTiketStatus.loaded,
        result: data,
        todayCount: todayCount,
        lastWeekCount: lastWeekCount,
        lastMonthCount: lastMonthCount,
        lastYearCount: lastYearCount,
      ));
    });
  }

  Future<void> _onFetchDetailAllTiketByIdTeknisi(
      FetchDetailAllTiketByIdTeknisi event,
      Emitter<DetailAllTiketState> emit) async {
    emit(state.copyWith(status: DetailAllTiketStatus.loading));
    final result =
        await _tiketRepository.getAllTiketByIdTeknisi(event.idTeknisi);

    result.fold((failure) {
      if (failure is NotFoundFailure) {
        emit(state.copyWith(status: DetailAllTiketStatus.empty));
      } else {
        emit(state.copyWith(
            status: DetailAllTiketStatus.error, errorMessage: failure.message));
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
        status: DetailAllTiketStatus.loaded,
        result: data,
        todayCount: todayCount,
        lastWeekCount: lastWeekCount,
        lastMonthCount: lastMonthCount,
        lastYearCount: lastYearCount,
      ));
    });
  }
}
