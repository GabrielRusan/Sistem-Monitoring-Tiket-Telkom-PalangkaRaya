part of 'admin_bloc.dart';

enum AdminStatus { loading, loaded, error, empty, initial, tokenInvalid }

class AdminState extends Equatable {
  final List<Admin> result;
  final List<Admin> filteredResult;
  final int? sortColumnIndex;
  final bool sortAscending;
  final bool isFiltered;
  final AdminStatus status;
  final String? errorMessage;

  const AdminState({
    this.result = const [],
    this.filteredResult = const [],
    this.sortColumnIndex,
    this.sortAscending = true,
    this.status = AdminStatus.initial,
    this.errorMessage,
    this.isFiltered = false,
  });

  AdminState copyWith({
    List<Admin>? result,
    List<Admin>? filteredResult,
    int? sortColumnIndex,
    bool? sortAscending,
    bool? isFiltered,
    AdminStatus? status,
    String? errorMessage,
  }) {
    return AdminState(
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
