import 'package:telkom_ticket_manager/data/models/tiket_response.dart';

abstract class TiketRemoteDataSource {
  Future<TiketResponseModel> getAllTiket();
  Future<TiketResponseModel> getAllActiveTiket();
  Future<TiketResponseModel> getAllHistoricTiket();
}
