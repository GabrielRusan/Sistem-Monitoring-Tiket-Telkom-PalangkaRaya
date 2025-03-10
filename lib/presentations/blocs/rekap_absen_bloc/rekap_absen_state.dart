part of 'rekap_absen_bloc.dart';

sealed class RekapAbsenState extends Equatable {
  const RekapAbsenState();

  @override
  List<Object?> get props => [];
}

final class RekapAbsenInitial extends RekapAbsenState {}

final class RekapAbsenLoading extends RekapAbsenState {}

final class RekapAbsenLoaded extends RekapAbsenState {
  final RekapAbsen rekapAbsen;
  final String filter;
  final DateTimeRange? tanggalRangeCustom;
  final List<Absen>? searchedOrSortedAbsenList;
  final int? sortColumnIndex;
  final bool sortAscending;

  const RekapAbsenLoaded({
    required this.rekapAbsen,
    required this.filter,
    this.sortAscending = true,
    this.sortColumnIndex,
    this.tanggalRangeCustom,
    this.searchedOrSortedAbsenList,
  });

  RekapAbsenLoaded copyWith({
    RekapAbsen? rekapAbsen,
    String? filter,
    DateTimeRange? tanggalRangeCustom,
    List<Absen>? searchedOrSortedAbsenList,
  }) {
    return RekapAbsenLoaded(
      rekapAbsen: rekapAbsen ?? this.rekapAbsen,
      filter: filter ?? this.filter,
      tanggalRangeCustom: tanggalRangeCustom ?? this.tanggalRangeCustom,
      searchedOrSortedAbsenList:
          searchedOrSortedAbsenList ?? this.searchedOrSortedAbsenList,
    );
  }

  @override
  List<Object?> get props => [
        rekapAbsen,
        filter,
        tanggalRangeCustom,
        searchedOrSortedAbsenList,
        sortAscending,
        sortColumnIndex,
      ];
}

final class RekapAbsenError extends RekapAbsenState {
  final String message;

  const RekapAbsenError({this.message = 'telah terjadi kesalahan'});
}
