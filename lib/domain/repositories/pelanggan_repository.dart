import 'package:dartz/dartz.dart';
import 'package:telkom_ticket_manager/domain/entities/pelanggan.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

abstract class PelangganRepository {
  Future<Either<Failure, List<Pelanggan>>> getAllPelanggan();
  Future<Either<Failure, String>> updatePelanggan(Pelanggan pelanggan);
  Future<Either<Failure, String>> addPelanggan(Pelanggan pelanggan);
}
