part of 'detail_active_tiket_bloc.dart';

sealed class DetailActiveTiketEvent extends Equatable {
  const DetailActiveTiketEvent();

  @override
  List<Object> get props => [];
}

final class FetchDetailActiveTiketByIdPelanggan extends DetailActiveTiketEvent {
  final String idPelanggan;

  const FetchDetailActiveTiketByIdPelanggan({required this.idPelanggan});

  @override
  List<Object> get props => [idPelanggan];
}

final class FetchDetailActiveTiketByIdTeknisi extends DetailActiveTiketEvent {
  final String idTeknisi;

  const FetchDetailActiveTiketByIdTeknisi({required this.idTeknisi});

  @override
  List<Object> get props => [idTeknisi];
}

final class SearchDetailActiveTiket extends DetailActiveTiketEvent {
  final String query;

  const SearchDetailActiveTiket({required this.query});

  @override
  List<Object> get props => [query];
}

final class SortDetailActiveTiket extends DetailActiveTiketEvent {
  final int columnIndex;
  final bool ascending;

  const SortDetailActiveTiket(this.columnIndex, this.ascending);

  @override
  List<Object> get props => [columnIndex, ascending];
}
