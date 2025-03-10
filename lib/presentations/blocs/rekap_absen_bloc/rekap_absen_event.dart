part of 'rekap_absen_bloc.dart';

sealed class RekapAbsenEvent extends Equatable {
  const RekapAbsenEvent();

  @override
  List<Object?> get props => [];
}

class FetchRekapAbsen extends RekapAbsenEvent {
  final String filter;
  final DateTimeRange? rangeTanggalCustom;

  const FetchRekapAbsen({required this.filter, this.rangeTanggalCustom});

  @override
  List<Object?> get props => [filter, rangeTanggalCustom];
}

class SearchRekapAbsen extends RekapAbsenEvent {
  final String query;
  final RekapAbsen rekapAbsen;
  final String filter;
  final DateTimeRange? tanggalRangeCustom;

  const SearchRekapAbsen({
    required this.query,
    required this.rekapAbsen,
    required this.filter,
    this.tanggalRangeCustom,
  });
  @override
  List<Object> get props => [
        query,
      ];
}

class SortRekapAbsen extends RekapAbsenEvent {
  final int columnIndex;
  final bool ascending;

  final RekapAbsen rekapAbsen;
  final String filter;
  final DateTimeRange? tanggalRangeCustom;
  final List<Absen>? searchedOrSortedAbsen;

  const SortRekapAbsen({
    required this.columnIndex,
    required this.ascending,
    required this.rekapAbsen,
    required this.filter,
    this.tanggalRangeCustom,
    this.searchedOrSortedAbsen,
  });

  @override
  List<Object?> get props => [
        columnIndex,
        ascending,
        rekapAbsen,
        filter,
        tanggalRangeCustom,
        searchedOrSortedAbsen,
      ];
}

class DownloadPdf extends RekapAbsenEvent {
  final RekapAbsen rekapAbsen;
  final String filter;
  final DateTimeRange? rangeTanggalCustom;

  const DownloadPdf(
      {required this.rekapAbsen,
      required this.filter,
      this.rangeTanggalCustom});

  @override
  List<Object?> get props => [rekapAbsen, filter, rangeTanggalCustom];
}
