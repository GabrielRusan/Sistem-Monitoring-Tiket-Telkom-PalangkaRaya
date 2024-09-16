import 'package:telkom_ticket_manager/data/models/admin_model.dart';
import 'package:telkom_ticket_manager/data/models/admin_response.dart';

abstract class AdminRemoteDataSource {
  Future<AdminResponseModel> getAllAdmin();
  // Future<String> deleteAdmin(int id);
  // Future<String> addAdmin(AdminModel admin);
  Future<String> updateAdmin(AdminModel admin);
}
