part of 'historic_tiket_bloc.dart';

sealed class HistoricTiketEvent extends Equatable {
  const HistoricTiketEvent();

  @override
  List<Object> get props => [];
}

final class FetchHistoricTiket extends HistoricTiketEvent {}

final class SearchHistoricTiket extends HistoricTiketEvent {
  final String query;

  const SearchHistoricTiket({required this.query});

  @override
  List<Object> get props => [query];
}

final class SortHistoricTiket extends HistoricTiketEvent {
  final int columnIndex;
  final bool ascending;

  const SortHistoricTiket(this.columnIndex, this.ascending);

  @override
  List<Object> get props => [columnIndex, ascending];
}
