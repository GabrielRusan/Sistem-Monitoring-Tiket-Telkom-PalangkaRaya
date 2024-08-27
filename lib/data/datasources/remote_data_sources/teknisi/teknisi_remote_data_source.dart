import 'package:telkom_ticket_manager/data/models/teknisi_model.dart';
import 'package:telkom_ticket_manager/data/models/teknisi_response.dart';

abstract class TeknisiRemoteDataSource {
  Future<TeknisiResponseModel> getAllTeknisi();
  Future<String> deleteTeknisi(int id);
  Future<String> addTeknisi(TeknisiModel teknisi);
  Future<String> updateTeknisi(TeknisiModel teknisi);
}
