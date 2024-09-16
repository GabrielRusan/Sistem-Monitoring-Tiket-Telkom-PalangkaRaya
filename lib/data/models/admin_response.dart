import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/data/models/admin_model.dart';

class AdminResponseModel extends Equatable {
  final List<AdminModel> teknisiList;

  const AdminResponseModel({required this.teknisiList});

  factory AdminResponseModel.fromJson(List<dynamic> json) => AdminResponseModel(
      teknisiList:
          List<AdminModel>.from(json.map((x) => AdminModel.fromJson(x))));

  @override
  List<Object?> get props => [teknisiList];
}
