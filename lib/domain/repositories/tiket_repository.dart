import 'package:dartz/dartz.dart';
import 'package:telkom_ticket_manager/domain/entities/tiket.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

abstract class TiketRepository {
  Future<Either<Failure, List<Tiket>>> getAllTiket();
  Future<Either<Failure, List<Tiket>>> getAllActiveTiket();
  Future<Either<Failure, List<Tiket>>> getAllHistoricTiket();

  Future<Either<Failure, List<Tiket>>> getAllTiketByIdTeknisi(String idTeknisi);
  Future<Either<Failure, List<Tiket>>> getAllActiveTiketByIdTeknisi(
      String idTeknisi);
  Future<Either<Failure, List<Tiket>>> getAllHistoricTiketByIdTeknisi(
      String idTeknisi);

  Future<Either<Failure, List<Tiket>>> getAllTiketByIdPelanggan(
      String idPelanggan);
  Future<Either<Failure, List<Tiket>>> getAllActiveTiketByIdPelanggan(
      String idPelanggan);
  Future<Either<Failure, List<Tiket>>> getAllHistoricTiketByIdPelanggan(
      String idPelanggan);
}
