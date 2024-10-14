part of 'delete_teknisi_bloc.dart';

sealed class DeleteTeknisiState extends Equatable {
  const DeleteTeknisiState();

  @override
  List<Object> get props => [];
}

final class InitialDeleteTeknisi extends DeleteTeknisiState {}

final class SuccessDeleteTeknisi extends DeleteTeknisiState {
  final String message;

  const SuccessDeleteTeknisi({required this.message});

  @override
  List<Object> get props => [message];
}

final class LoadingDeleteTeknisi extends DeleteTeknisiState {}

final class WarningDeleteTeknisi extends DeleteTeknisiState {
  final String idTeknisi;
  final String namaTeknisi;
  const WarningDeleteTeknisi(
      {required this.idTeknisi, required this.namaTeknisi});

  @override
  List<Object> get props => [idTeknisi, namaTeknisi];
}

final class FailedDeleteTeknisi extends DeleteTeknisiState {
  final String message;

  const FailedDeleteTeknisi({required this.message});

  @override
  List<Object> get props => [message];
}
