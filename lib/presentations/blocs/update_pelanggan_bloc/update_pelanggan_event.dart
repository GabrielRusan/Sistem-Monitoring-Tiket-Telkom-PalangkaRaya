part of 'update_pelanggan_bloc.dart';

sealed class UpdatePelangganEvent extends Equatable {
  const UpdatePelangganEvent();

  @override
  List<Object> get props => [];
}

final class OnChangedName extends UpdatePelangganEvent {
  final String value;

  const OnChangedName({required this.value});

  @override
  List<Object> get props => [value];
}

final class OnChangedAlamat extends UpdatePelangganEvent {
  final String value;

  const OnChangedAlamat({required this.value});

  @override
  List<Object> get props => [value];
}

final class OnChangedPhoneNumber extends UpdatePelangganEvent {
  final String value;

  const OnChangedPhoneNumber({required this.value});

  @override
  List<Object> get props => [value];
}

final class SubmitUpdatePelanggan extends UpdatePelangganEvent {}

final class ClearUpdatePelanggan extends UpdatePelangganEvent {}

final class InitialEventPelanggan extends UpdatePelangganEvent {
  final Pelanggan pelanggan;

  const InitialEventPelanggan({required this.pelanggan});

  @override
  List<Object> get props => [pelanggan];
}
