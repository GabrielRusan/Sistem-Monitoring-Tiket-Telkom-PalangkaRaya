part of 'update_teknisi_bloc.dart';

sealed class UpdateTeknisiEvent extends Equatable {
  const UpdateTeknisiEvent();

  @override
  List<Object> get props => [];
}

final class OnChangedName extends UpdateTeknisiEvent {
  final String value;

  const OnChangedName({required this.value});

  @override
  List<Object> get props => [value];
}

final class OnChangedUsername extends UpdateTeknisiEvent {
  final String value;

  const OnChangedUsername({required this.value});

  @override
  List<Object> get props => [value];
}

final class OnChangedPassword extends UpdateTeknisiEvent {
  final String value;

  const OnChangedPassword({required this.value});

  @override
  List<Object> get props => [value];
}

final class OnChangedKehadiran extends UpdateTeknisiEvent {
  final String value;

  const OnChangedKehadiran({required this.value});

  @override
  List<Object> get props => [value];
}

final class OnChangedKeterangan extends UpdateTeknisiEvent {
  final String value;

  const OnChangedKeterangan({required this.value});

  @override
  List<Object> get props => [value];
}

final class OnChangedStatus extends UpdateTeknisiEvent {
  final String value;

  const OnChangedStatus({required this.value});

  @override
  List<Object> get props => [value];
}

final class SubmitUpdateTeknisi extends UpdateTeknisiEvent {}

final class ClearUpdateTeknisi extends UpdateTeknisiEvent {}

final class InitialEventTeknisi extends UpdateTeknisiEvent {
  final Teknisi teknisi;

  const InitialEventTeknisi({required this.teknisi});

  @override
  List<Object> get props => [teknisi];
}
