import 'package:telkom_ticket_manager/data/models/tiket_response.dart';

abstract class TiketRemoteDataSource {
  Future<TiketResponseModel> getAllTiket();
  Future<TiketResponseModel> getAllActiveTiket();
  Future<TiketResponseModel> getAllHistoricTiket();

  Future<TiketResponseModel> getAllTiketByIdTeknisi(String idTeknisi);
  Future<TiketResponseModel> getAllActiveTiketByIdTeknisi(String idTeknisi);
  Future<TiketResponseModel> getAllHistoricTiketByIdTeknisi(String idTeknisi);

  Future<TiketResponseModel> getAllTiketByIdPelanggan(String idPelanggan);
  Future<TiketResponseModel> getAllActiveTiketByIdPelanggan(String idPelanggan);
  Future<TiketResponseModel> getAllHistoricTiketByIdPelanggan(
      String idPelanggan);
}
