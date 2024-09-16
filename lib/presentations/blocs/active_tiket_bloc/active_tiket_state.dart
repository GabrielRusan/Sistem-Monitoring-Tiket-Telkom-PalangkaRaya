part of 'active_tiket_bloc.dart';

enum ActiveTiketStatus { loading, loaded, error, empty, initial, tokenInvalid }

class ActiveTiketState extends Equatable {
  final List<Tiket> result;
  final List<Tiket> filteredResult;
  final int? sortColumnIndex;
  final bool sortAscending;
  final bool isFiltered;
  final ActiveTiketStatus status;
  final String? errorMessage;
  final int? inProgressCount;
  final int? ditugaskanCount;

  const ActiveTiketState({
    this.result = const [],
    this.filteredResult = const [],
    this.sortColumnIndex,
    this.sortAscending = true,
    this.isFiltered = false,
    this.status = ActiveTiketStatus.initial,
    this.errorMessage,
    this.inProgressCount,
    this.ditugaskanCount,
  });

  ActiveTiketState copyWith({
    List<Tiket>? result,
    List<Tiket>? filteredResult,
    int? sortColumnIndex,
    bool? sortAscending,
    bool? isFiltered,
    ActiveTiketStatus? status,
    String? errorMessage,
    int? inProgressCount,
    int? ditugaskanCount,
  }) {
    return ActiveTiketState(
      result: result ?? this.result,
      filteredResult: filteredResult ?? this.filteredResult,
      sortColumnIndex: sortColumnIndex ?? this.sortColumnIndex,
      sortAscending: sortAscending ?? this.sortAscending,
      isFiltered: isFiltered ?? this.isFiltered,
      status: status ?? this.status,
      errorMessage: errorMessage,
      inProgressCount: inProgressCount ?? this.inProgressCount,
      ditugaskanCount: ditugaskanCount ?? this.ditugaskanCount,
    );
  }

  @override
  List<Object?> get props => [
        result,
        filteredResult,
        sortColumnIndex,
        sortAscending,
        status,
        errorMessage,
        inProgressCount,
        ditugaskanCount,
        isFiltered,
      ];
}
