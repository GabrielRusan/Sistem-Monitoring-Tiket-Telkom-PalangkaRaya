import 'package:dartz/dartz.dart';
import 'package:telkom_ticket_manager/domain/entities/teknisi.dart';
import 'package:telkom_ticket_manager/domain/repositories/teknisi_repository.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

class GetAllTeknisi {
  final TeknisiRepository repository;

  GetAllTeknisi({required this.repository});

  Future<Either<Failure, List<Teknisi>>> execute() =>
      repository.getAllTeknisi();
}
