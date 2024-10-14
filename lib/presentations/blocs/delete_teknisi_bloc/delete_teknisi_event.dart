part of 'delete_teknisi_bloc.dart';

sealed class DeleteTeknisiEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class DeleteTeknisi extends DeleteTeknisiEvent {
  final String idTeknisi;
  DeleteTeknisi({required this.idTeknisi});

  @override
  List<Object> get props => [idTeknisi];
}

final class WarningDeleteTeknisiEvent extends DeleteTeknisiEvent {
  final String idTeknisi;
  final String namaTeknisi;
  WarningDeleteTeknisiEvent(
      {required this.idTeknisi, required this.namaTeknisi});

  @override
  List<Object> get props => [idTeknisi, namaTeknisi];
}
