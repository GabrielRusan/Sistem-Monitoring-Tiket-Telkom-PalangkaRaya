part of 'odp_bloc.dart';

enum OdpStatus { loading, loaded, error, empty, initial, tokenInvalid }

class OdpState extends Equatable {
  final List<OdpModel> result;
  final List<OdpModel> filteredResult;
  final int? sortColumnIndex;
  final bool sortAscending;
  final bool isFiltered;
  final OdpStatus status;
  final String? errorMessage;

  const OdpState({
    this.result = const [],
    this.filteredResult = const [],
    this.sortColumnIndex,
    this.sortAscending = true,
    this.isFiltered = false,
    this.status = OdpStatus.initial,
    this.errorMessage,
  });

  OdpState copyWith({
    List<OdpModel>? result,
    List<OdpModel>? filteredResult,
    int? sortColumnIndex,
    bool? sortAscending,
    bool? isFiltered,
    OdpStatus? status,
    String? errorMessage,
    int? inProgressCount,
    int? ditugaskanCount,
  }) {
    return OdpState(
      result: result ?? this.result,
      filteredResult: filteredResult ?? this.filteredResult,
      sortColumnIndex: sortColumnIndex ?? this.sortColumnIndex,
      sortAscending: sortAscending ?? this.sortAscending,
      isFiltered: isFiltered ?? this.isFiltered,
      status: status ?? this.status,
      errorMessage: errorMessage,
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
      ];
}
