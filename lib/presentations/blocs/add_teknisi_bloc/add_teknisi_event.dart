part of 'add_teknisi_bloc.dart';

sealed class AddTeknisiEvent extends Equatable {
  const AddTeknisiEvent();

  @override
  List<Object> get props => [];
}

final class OnChangedName extends AddTeknisiEvent {
  final String value;

  const OnChangedName({required this.value});

  @override
  List<Object> get props => [value];
}

final class OnChangedUsername extends AddTeknisiEvent {
  final String value;

  const OnChangedUsername({required this.value});

  @override
  List<Object> get props => [value];
}

final class OnChangedPassword extends AddTeknisiEvent {
  final String value;

  const OnChangedPassword({required this.value});

  @override
  List<Object> get props => [value];
}

final class OnChangedSektor extends AddTeknisiEvent {
  final String value;

  const OnChangedSektor({required this.value});

  @override
  List<Object> get props => [value];
}

final class SubmitAddTeknisi extends AddTeknisiEvent {}

final class ClearAddTeknisi extends AddTeknisiEvent {}
