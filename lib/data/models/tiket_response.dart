import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/data/models/tiket_model.dart';

class TiketResponseModel extends Equatable {
  final List<TiketModel> teknisiList;

  const TiketResponseModel({required this.teknisiList});

  factory TiketResponseModel.fromJson(List<dynamic> json) => TiketResponseModel(
      teknisiList:
          List<TiketModel>.from(json.map((x) => TiketModel.fromJson(x))));

  @override
  List<Object?> get props => [teknisiList];
}
