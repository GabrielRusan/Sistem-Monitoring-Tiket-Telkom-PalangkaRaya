import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/data/models/pelanggan_model.dart';

class PelangganResponseModel extends Equatable {
  final List<PelangganModel> pelangganList;

  const PelangganResponseModel({required this.pelangganList});

  factory PelangganResponseModel.fromJson(List<dynamic> json) =>
      PelangganResponseModel(
          pelangganList: List<PelangganModel>.from(
              json.map((x) => PelangganModel.fromJson(x))));

  @override
  List<Object?> get props => [pelangganList];
}
