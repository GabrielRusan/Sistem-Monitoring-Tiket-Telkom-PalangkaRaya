part of 'active_tiket_bloc.dart';

sealed class ActiveTiketEvent extends Equatable {
  const ActiveTiketEvent();

  @override
  List<Object> get props => [];
}

final class FetchActiveTiket extends ActiveTiketEvent {}

final class SearchActiveTiket extends ActiveTiketEvent {
  final String query;

  const SearchActiveTiket({required this.query});

  @override
  List<Object> get props => [query];
}

final class SortActiveTiket extends ActiveTiketEvent {
  final int columnIndex;
  final bool ascending;

  const SortActiveTiket(this.columnIndex, this.ascending);

  @override
  List<Object> get props => [columnIndex, ascending];
}
