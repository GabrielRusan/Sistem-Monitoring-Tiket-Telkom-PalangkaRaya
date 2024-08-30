import 'package:dartz/dartz.dart';
import 'package:telkom_ticket_manager/domain/entities/tiket.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

abstract class TiketRepository {
  Future<Either<Failure, List<Tiket>>> getAllActiveTiket();
  Future<Either<Failure, List<Tiket>>> getAllHistoricTiket();
}
