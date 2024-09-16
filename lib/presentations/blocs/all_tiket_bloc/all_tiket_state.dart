part of 'all_tiket_bloc.dart';

enum AllTiketStatus { loading, loaded, error, empty, initial, tokenInvalid }

class AllTiketState extends Equatable {
  final List<Tiket> result;
  final AllTiketStatus status;
  final String? errorMessage;
  final int? todayCount;
  final int? lastWeekCount;
  final int? lastMonthCount;
  final int? lastYearCount;

  const AllTiketState({
    this.result = const [],
    this.status = AllTiketStatus.initial,
    this.errorMessage,
    this.todayCount,
    this.lastWeekCount,
    this.lastMonthCount,
    this.lastYearCount,
  });

  AllTiketState copyWith({
    List<Tiket>? result,
    AllTiketStatus? status,
    String? errorMessage,
    int? todayCount,
    int? lastWeekCount,
    int? lastMonthCount,
    int? lastYearCount,
  }) {
    return AllTiketState(
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
