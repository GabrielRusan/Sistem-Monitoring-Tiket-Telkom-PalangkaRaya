part of 'admin_bloc.dart';

sealed class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class SortAdminEvent extends AdminEvent {
  final int columnIndex;
  final bool ascending;

  const SortAdminEvent(this.columnIndex, this.ascending);

  @override
  List<Object> get props => [columnIndex, ascending];
}

class FetchAllAdmin extends AdminEvent {}

class SearchAdmin extends AdminEvent {
  final String query;

  const SearchAdmin({required this.query});

  @override
  List<Object> get props => [query];
}
