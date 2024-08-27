part of 'teknisi_bloc.dart';

enum TeknisiStatus { loading, loaded, error, empty, initial, tokenInvalid }

class TeknisiState extends Equatable {
  final List<Teknisi> result;
  final int? sortColumnIndex;
  final bool sortAscending;
  final TeknisiStatus status;
  final String? errorMessage;

  const TeknisiState({
    this.result = const [],
    this.sortColumnIndex,
    this.sortAscending = true,
    this.status = TeknisiStatus.initial,
    this.errorMessage,
  });

  TeknisiState copyWith({
    List<Teknisi>? result,
    int? sortColumnIndex,
    bool? sortAscending,
    TeknisiStatus? status,
    String? errorMessage,
  }) {
    return TeknisiState(
        result: result ?? this.result,
        sortColumnIndex: sortColumnIndex ?? this.sortColumnIndex,
        sortAscending: sortAscending ?? this.sortAscending,
        status: status ?? this.status,
        errorMessage: errorMessage);
  }

  @override
  List<Object?> get props =>
      [result, sortColumnIndex, sortAscending, status, errorMessage];
}
