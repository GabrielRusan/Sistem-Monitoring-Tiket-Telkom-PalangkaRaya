part of 'all_tiket_bloc.dart';

sealed class AllTiketEvent extends Equatable {
  const AllTiketEvent();

  @override
  List<Object> get props => [];
}

final class FetchAllTiket extends AllTiketEvent {}
