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

final class OnChangedSektor extends UpdateTeknisiEvent {
  final String value;

  const OnChangedSektor({required this.value});

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
