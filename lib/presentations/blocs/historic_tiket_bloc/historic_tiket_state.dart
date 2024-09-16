part of 'historic_tiket_bloc.dart';

enum HistoricTiketStatus {
  loading,
  loaded,
  error,
  empty,
  initial,
  tokenInvalid
}

class HistoricTiketState extends Equatable {
  final List<Tiket> result;
  final List<Tiket> filteredResult;
  final int? sortColumnIndex;
  final bool sortAscending;
  final bool isFiltered;
  final HistoricTiketStatus status;
  final String? errorMessage;
  final int? selesaiCount;

  const HistoricTiketState({
    this.result = const [],
    this.filteredResult = const [],
    this.sortColumnIndex,
    this.sortAscending = true,
    this.isFiltered = false,
    this.status = HistoricTiketStatus.initial,
    this.errorMessage,
    this.selesaiCount,
  });

  HistoricTiketState copyWith({
    List<Tiket>? result,
    List<Tiket>? filteredResult,
    int? sortColumnIndex,
    bool? sortAscending,
    bool? isFiltered,
    HistoricTiketStatus? status,
    String? errorMessage,
    int? selesaiCount,
  }) {
    return HistoricTiketState(
      result: result ?? this.result,
      filteredResult: filteredResult ?? this.filteredResult,
      sortColumnIndex: sortColumnIndex ?? this.sortColumnIndex,
      sortAscending: sortAscending ?? this.sortAscending,
      isFiltered: isFiltered ?? this.isFiltered,
      status: status ?? this.status,
      errorMessage: errorMessage,
      selesaiCount: selesaiCount ?? this.selesaiCount,
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
        selesaiCount,
        isFiltered,
      ];
}
