part of 'detail_historic_tiket_bloc.dart';

enum DetailHistoricTiketStatus {
  loading,
  loaded,
  error,
  empty,
  initial,
  tokenInvalid
}

class DetailHistoricTiketState extends Equatable {
  final List<Tiket> result;
  final List<Tiket> filteredResult;
  final int? sortColumnIndex;
  final bool sortAscending;
  final bool isFiltered;
  final DetailHistoricTiketStatus status;
  final String? errorMessage;
  final int? selesaiCount;

  const DetailHistoricTiketState({
    this.result = const [],
    this.filteredResult = const [],
    this.sortColumnIndex,
    this.sortAscending = true,
    this.isFiltered = false,
    this.status = DetailHistoricTiketStatus.initial,
    this.errorMessage,
    this.selesaiCount,
  });

  DetailHistoricTiketState copyWith({
    List<Tiket>? result,
    List<Tiket>? filteredResult,
    int? sortColumnIndex,
    bool? sortAscending,
    bool? isFiltered,
    DetailHistoricTiketStatus? status,
    String? errorMessage,
    int? selesaiCount,
  }) {
    return DetailHistoricTiketState(
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
