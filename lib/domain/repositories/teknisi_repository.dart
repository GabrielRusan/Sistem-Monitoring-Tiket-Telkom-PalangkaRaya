import 'package:dartz/dartz.dart';
import 'package:telkom_ticket_manager/domain/entities/teknisi.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

abstract class TeknisiRepository {
  Future<Either<Failure, List<Teknisi>>> getAllTeknisi();
  Future<Either<Failure, String>> addTeknisi();
  Future<Either<Failure, String>> deleteTeknisi();
  Future<Either<Failure, String>> updateTeknisi();
}
