part of 'detail_all_tiket_bloc.dart';

sealed class DetailAllTiketEvent extends Equatable {
  const DetailAllTiketEvent();

  @override
  List<Object> get props => [];
}

final class FetchDetailAllTiketByIdTeknisi extends DetailAllTiketEvent {
  final String idTeknisi;

  const FetchDetailAllTiketByIdTeknisi({required this.idTeknisi});

  @override
  List<Object> get props => [idTeknisi];
}

final class FetchDetailAllTiketByIdPelanggan extends DetailAllTiketEvent {
  final String idPelanggan;

  const FetchDetailAllTiketByIdPelanggan({required this.idPelanggan});

  @override
  List<Object> get props => [idPelanggan];
}
