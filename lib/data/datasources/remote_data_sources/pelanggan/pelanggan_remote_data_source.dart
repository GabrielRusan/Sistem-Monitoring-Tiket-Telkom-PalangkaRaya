import 'package:telkom_ticket_manager/data/models/pelanggan_model.dart';
import 'package:telkom_ticket_manager/data/models/pelanggan_response.dart';

abstract class PelangganRemoteDataSource {
  Future<PelangganResponseModel> getAllPelanggan();
  Future<String> updatePelanggan(PelangganModel pelanggan);
  Future<String> addPelanggan(PelangganModel pelanggan);
}
