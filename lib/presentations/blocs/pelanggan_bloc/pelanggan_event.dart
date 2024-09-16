part of 'pelanggan_bloc.dart';

sealed class PelangganEvent extends Equatable {
  const PelangganEvent();

  @override
  List<Object> get props => [];
}

class SortPelangganEvent extends PelangganEvent {
  final int columnIndex;
  final bool ascending;

  const SortPelangganEvent(this.columnIndex, this.ascending);

  @override
  List<Object> get props => [columnIndex, ascending];
}

class FetchAllPelanggan extends PelangganEvent {}

class SearchPelanggan extends PelangganEvent {
  final String query;

  const SearchPelanggan({required this.query});

  @override
  List<Object> get props => [query];
}
