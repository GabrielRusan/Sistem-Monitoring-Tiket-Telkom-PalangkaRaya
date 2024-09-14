import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/date_converter.dart';
import 'package:telkom_ticket_manager/domain/entities/admin.dart';
import 'package:telkom_ticket_manager/domain/repositories/admin_repository.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository _adminRepository;
  AdminBloc(this._adminRepository) : super(const AdminState()) {
    on<SortAdminEvent>(_onSortAdmin);
    on<FetchAllAdmin>(_onFetchAllAdmin);
    on<SearchAdmin>(_onSearchTiket);
  }

  void _onSearchTiket(SearchAdmin event, Emitter<AdminState> emit) {
    if (event.query.isEmpty) {
      emit(state.copyWith(isFiltered: false, filteredResult: []));
      return;
    }

    List<Admin> filteredResult = [];
    final String query = event.query.toLowerCase();

    for (Admin admin in state.result) {
      final String idAdmin = admin.idadmin.toString().toLowerCase();
      final String usename = admin.username.toLowerCase();
      final String nama = admin.nama.toLowerCase();

      final String createdAt =
          dateToStringLengkap(admin.createdAt).toLowerCase();

      if (idAdmin.contains(query) ||
          usename.contains(query) ||
          nama.contains(query) ||
          createdAt.contains(query)) {
        filteredResult.add(admin);
      }
    }

    if (filteredResult.isEmpty) {
      emit(state.copyWith(
          isFiltered: false, filteredResult: [], status: AdminStatus.empty));
      return;
    }

    emit(state.copyWith(
        isFiltered: true,
        filteredResult: filteredResult,
        status: AdminStatus.loaded));
  }

  Future<void> _onFetchAllAdmin(
      FetchAllAdmin event, Emitter<AdminState> emit) async {
    emit(state.copyWith(status: AdminStatus.loading));

    final result = await _adminRepository.getAllAdmin();

    result.fold((failure) {
      if (failure is NotFoundFailure) {
        emit(state.copyWith(status: AdminStatus.empty));
      } else if (failure is TokenFailure) {
        emit(state.copyWith(status: AdminStatus.tokenInvalid));
      } else {
        emit(state.copyWith(
            status: AdminStatus.error, errorMessage: failure.message));
      }
    }, (data) {
      emit(state.copyWith(
          result: data, status: AdminStatus.loaded, errorMessage: null));
    });
  }

  void _onSortAdmin(SortAdminEvent event, Emitter<AdminState> emit) {
    final Map<int, Function(Admin, Admin)> sortFunctions = {
      0: (a, b) => a.idadmin.compareTo(b.idadmin),
      1: (a, b) => a.username.toLowerCase().compareTo(b.username.toLowerCase()),
      2: (a, b) => a.nama.compareTo(b.nama),
      3: (a, b) => a.createdAt.compareTo(b.createdAt),
    };

    if (state.isFiltered) {
      List<Admin> sortedResult = List.from(state.filteredResult);

      final sortFunction = sortFunctions[event.columnIndex];

      if (sortFunction != null) {
        sortedResult.sort((a, b) =>
            event.ascending ? sortFunction(a, b) : sortFunction(b, a));
      }

      emit(state.copyWith(
          filteredResult: sortedResult,
          sortColumnIndex: event.columnIndex,
          sortAscending: event.ascending,
          status: AdminStatus.loaded));
      return;
    }

    List<Admin> sortedResult = List.from(state.result);

    final sortFunction = sortFunctions[event.columnIndex];

    if (sortFunction != null) {
      sortedResult.sort(
          (a, b) => event.ascending ? sortFunction(a, b) : sortFunction(b, a));
    }

    emit(state.copyWith(
        result: sortedResult,
        sortColumnIndex: event.columnIndex,
        sortAscending: event.ascending,
        status: AdminStatus.loaded));
  }
}
