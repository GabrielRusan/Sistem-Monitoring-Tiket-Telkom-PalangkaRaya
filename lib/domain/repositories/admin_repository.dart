import 'package:dartz/dartz.dart';
import 'package:telkom_ticket_manager/domain/entities/admin.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

abstract class AdminRepository {
  Future<Either<Failure, List<Admin>>> getAllAdmin();
  Future<Either<Failure, String>> updateAdmin(Admin teknisi);
}
