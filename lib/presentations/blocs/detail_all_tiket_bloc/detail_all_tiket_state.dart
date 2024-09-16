part of 'detail_all_tiket_bloc.dart';

enum DetailAllTiketStatus {
  loading,
  loaded,
  error,
  empty,
  initial,
  tokenInvalid
}

class DetailAllTiketState extends Equatable {
  final List<Tiket> result;
  final DetailAllTiketStatus status;
  final String? errorMessage;
  final int? todayCount;
  final int? lastWeekCount;
  final int? lastMonthCount;
  final int? lastYearCount;

  const DetailAllTiketState({
    this.result = const [],
    this.status = DetailAllTiketStatus.initial,
    this.errorMessage,
    this.todayCount,
    this.lastWeekCount,
    this.lastMonthCount,
    this.lastYearCount,
  });

  DetailAllTiketState copyWith({
    List<Tiket>? result,
    DetailAllTiketStatus? status,
    String? errorMessage,
    int? todayCount,
    int? lastWeekCount,
    int? lastMonthCount,
    int? lastYearCount,
  }) {
    return DetailAllTiketState(
      result: result ?? this.result,
      status: status ?? this.status,
      errorMessage: errorMessage,
      todayCount: todayCount ?? this.todayCount,
      lastWeekCount: lastWeekCount ?? this.lastWeekCount,
      lastMonthCount: lastMonthCount ?? this.lastMonthCount,
      lastYearCount: lastYearCount ?? this.lastYearCount,
    );
  }

  @override
  List<Object?> get props => [
        result,
        status,
        errorMessage,
        todayCount,
        lastWeekCount,
        lastMonthCount,
        lastYearCount,
      ];
}
