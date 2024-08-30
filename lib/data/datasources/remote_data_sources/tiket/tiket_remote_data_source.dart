import 'package:telkom_ticket_manager/data/models/tiket_response.dart';

abstract class TiketRemoteDataSource {
  Future<TiketResponseModel> getAllActiveTiket();
  Future<TiketResponseModel> getAllHistoricTiket();
}
