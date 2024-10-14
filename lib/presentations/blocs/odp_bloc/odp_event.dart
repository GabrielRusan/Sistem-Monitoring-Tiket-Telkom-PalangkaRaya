part of 'odp_bloc.dart';

sealed class OdpEvent extends Equatable {
  const OdpEvent();

  @override
  List<Object> get props => [];
}

final class FetchOdp extends OdpEvent {}

final class SearchOdp extends OdpEvent {
  final String query;

  const SearchOdp({required this.query});

  @override
  List<Object> get props => [query];
}

final class SortOdp extends OdpEvent {
  final int columnIndex;
  final bool ascending;

  const SortOdp(this.columnIndex, this.ascending);

  @override
  List<Object> get props => [columnIndex, ascending];
}
