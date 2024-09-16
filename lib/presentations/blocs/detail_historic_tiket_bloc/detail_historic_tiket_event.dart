part of 'detail_historic_tiket_bloc.dart';

sealed class DetailHistoricTiketEvent extends Equatable {
  const DetailHistoricTiketEvent();

  @override
  List<Object> get props => [];
}

final class FetchDetailHistoricTiketByIdPelanggan
    extends DetailHistoricTiketEvent {
  final String idPelanggan;

  const FetchDetailHistoricTiketByIdPelanggan({required this.idPelanggan});

  @override
  List<Object> get props => [idPelanggan];
}

final class FetchDetailHistoricTiketByIdTeknisi
    extends DetailHistoricTiketEvent {
  final String idTeknisi;

  const FetchDetailHistoricTiketByIdTeknisi({required this.idTeknisi});

  @override
  List<Object> get props => [idTeknisi];
}

final class SearchDetailHistoricTiket extends DetailHistoricTiketEvent {
  final String query;

  const SearchDetailHistoricTiket({required this.query});

  @override
  List<Object> get props => [query];
}

final class SortDetailHistoricTiket extends DetailHistoricTiketEvent {
  final int columnIndex;
  final bool ascending;

  const SortDetailHistoricTiket(this.columnIndex, this.ascending);

  @override
  List<Object> get props => [columnIndex, ascending];
}
