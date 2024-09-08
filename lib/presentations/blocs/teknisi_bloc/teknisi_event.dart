part of 'teknisi_bloc.dart';

sealed class TeknisiEvent extends Equatable {
  const TeknisiEvent();

  @override
  List<Object> get props => [];
}

class SortTeknisiEvent extends TeknisiEvent {
  final int columnIndex;
  final bool ascending;

  const SortTeknisiEvent(this.columnIndex, this.ascending);

  @override
  List<Object> get props => [columnIndex, ascending];
}

class FetchAllTeknisi extends TeknisiEvent {}

class SearchTeknisi extends TeknisiEvent {
  final String query;

  const SearchTeknisi({required this.query});

  @override
  List<Object> get props => [query];
}
