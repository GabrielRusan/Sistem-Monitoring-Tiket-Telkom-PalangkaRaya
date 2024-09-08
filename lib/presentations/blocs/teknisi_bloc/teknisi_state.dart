part of 'teknisi_bloc.dart';

enum TeknisiStatus { loading, loaded, error, empty, initial, tokenInvalid }

class TeknisiState extends Equatable {
  final List<Teknisi> result;
  final List<Teknisi> filteredResult;
  final int? sortColumnIndex;
  final bool sortAscending;
  final bool isFiltered;
  final TeknisiStatus status;
  final String? errorMessage;

  const TeknisiState({
    this.result = const [],
    this.filteredResult = const [],
    this.sortColumnIndex,
    this.sortAscending = true,
    this.status = TeknisiStatus.initial,
    this.errorMessage,
    this.isFiltered = false,
  });

  TeknisiState copyWith({
    List<Teknisi>? result,
    List<Teknisi>? filteredResult,
    int? sortColumnIndex,
    bool? sortAscending,
    bool? isFiltered,
    TeknisiStatus? status,
    String? errorMessage,
  }) {
    return TeknisiState(
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
