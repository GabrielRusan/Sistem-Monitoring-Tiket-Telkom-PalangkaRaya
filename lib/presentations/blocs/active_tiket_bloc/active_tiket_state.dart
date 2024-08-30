part of 'active_tiket_bloc.dart';

enum ActiveTiketStatus { loading, loaded, error, empty, initial, tokenInvalid }

class ActiveTiketState extends Equatable {
  final List<Tiket> result;
  final int? sortColumnIndex;
  final bool sortAscending;
  final ActiveTiketStatus status;
  final String? errorMessage;
  final int? inProgressCount;
  final int? ditugaskanCount;
  final int? todayCount;
  final int? lastWeekCount;
  final int? lastMonthCount;
  final int? lastYearCount;

  const ActiveTiketState({
    this.result = const [],
    this.sortColumnIndex,
    this.sortAscending = true,
    this.status = ActiveTiketStatus.initial,
    this.errorMessage,
    this.inProgressCount,
    this.ditugaskanCount,
    this.todayCount,
    this.lastWeekCount,
    this.lastMonthCount,
    this.lastYearCount,
  });

  ActiveTiketState copyWith({
    List<Tiket>? result,
    int? sortColumnIndex,
    bool? sortAscending,
    ActiveTiketStatus? status,
    String? errorMessage,
    int? inProgressCount,
    int? ditugaskanCount,
    int? todayCount,
    int? lastWeekCount,
    int? lastMonthCount,
    int? lastYearCount,
  }) {
    return ActiveTiketState(
      result: result ?? this.result,
      sortColumnIndex: sortColumnIndex ?? this.sortColumnIndex,
      sortAscending: sortAscending ?? this.sortAscending,
      status: status ?? this.status,
      errorMessage: errorMessage,
      inProgressCount: inProgressCount ?? this.inProgressCount,
      ditugaskanCount: ditugaskanCount ?? this.ditugaskanCount,
      todayCount: todayCount ?? this.todayCount,
      lastWeekCount: lastWeekCount ?? this.lastWeekCount,
      lastMonthCount: lastMonthCount ?? this.lastMonthCount,
      lastYearCount: lastYearCount ?? this.lastYearCount,
    );
  }

  @override
  List<Object?> get props => [
        result,
        sortColumnIndex,
        sortAscending,
        status,
        errorMessage,
        inProgressCount,
        ditugaskanCount,
        todayCount,
        lastWeekCount,
        lastMonthCount,
        lastYearCount,
      ];
}
