import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/data/models/tiket_model.dart';

class TiketResponseModel extends Equatable {
  final List<TiketModel> tiketList;

  const TiketResponseModel({required this.tiketList});

  factory TiketResponseModel.fromJson(List<dynamic> json) => TiketResponseModel(
      tiketList:
          List<TiketModel>.from(json.map((x) => TiketModel.fromJson(x))));

  @override
  List<Object?> get props => [tiketList];
}
