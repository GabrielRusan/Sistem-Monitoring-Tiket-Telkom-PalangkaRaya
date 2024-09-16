part of 'detail_active_tiket_bloc.dart';

enum DetailActiveTiketStatus {
  loading,
  loaded,
  error,
  empty,
  initial,
  tokenInvalid
}

class DetailActiveTiketState extends Equatable {
  final List<Tiket> result;
  final List<Tiket> filteredResult;
  final int? sortColumnIndex;
  final bool sortAscending;
  final bool isFiltered;
  final DetailActiveTiketStatus status;
  final String? errorMessage;
  final int? inProgressCount;
  final int? ditugaskanCount;

  const DetailActiveTiketState({
    this.result = const [],
    this.filteredResult = const [],
    this.sortColumnIndex,
    this.sortAscending = true,
    this.isFiltered = false,
    this.status = DetailActiveTiketStatus.initial,
    this.errorMessage,
    this.inProgressCount,
    this.ditugaskanCount,
  });

  DetailActiveTiketState copyWith({
    List<Tiket>? result,
    List<Tiket>? filteredResult,
    int? sortColumnIndex,
    bool? sortAscending,
    bool? isFiltered,
    DetailActiveTiketStatus? status,
    String? errorMessage,
    int? inProgressCount,
    int? ditugaskanCount,
  }) {
    return DetailActiveTiketState(
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
        isFiltered,
        ditugaskanCount,
        inProgressCount
      ];
}
