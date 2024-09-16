import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/data/models/teknisi_model.dart';

class TeknisiResponseModel extends Equatable {
  final List<TeknisiModel> teknisiList;

  const TeknisiResponseModel({required this.teknisiList});

  factory TeknisiResponseModel.fromJson(
          List<dynamic> json) =>
      TeknisiResponseModel(
          teknisiList: List<TeknisiModel>.from(
              json.map((x) => TeknisiModel.fromJson(x))));

  @override
  List<Object?> get props => [teknisiList];
}
