part of 'pelanggan_bloc.dart';

enum PelangganStatus { loading, loaded, error, empty, initial, tokenInvalid }

class PelangganState extends Equatable {
  final List<Pelanggan> result;
  final List<Pelanggan> filteredResult;
  final int? sortColumnIndex;
  final bool sortAscending;
  final bool isFiltered;
  final PelangganStatus status;
  final String? errorMessage;

  const PelangganState({
    this.result = const [],
    this.filteredResult = const [],
    this.sortColumnIndex,
    this.sortAscending = true,
    this.status = PelangganStatus.initial,
    this.errorMessage,
    this.isFiltered = false,
  });

  PelangganState copyWith({
    List<Pelanggan>? result,
    List<Pelanggan>? filteredResult,
    int? sortColumnIndex,
    bool? sortAscending,
    bool? isFiltered,
    PelangganStatus? status,
    String? errorMessage,
  }) {
    return PelangganState(
        result: result ?? this.result,
        filteredResult: filteredResult ?? this.filteredResult,
        sortColumnIndex: sortColumnIndex ?? this.sortColumnIndex,
        sortAscending: sortAscending ?? this.sortAscending,
        status: status ?? this.status,
        isFiltered: isFiltered ?? this.isFiltered,
        errorMessage: errorMessage);
  }

  @override
  List<Object?> get props => [
        result,
        sortColumnIndex,
        sortAscending,
        status,
        errorMessage,
        isFiltered,
        filteredResult
      ];
}
