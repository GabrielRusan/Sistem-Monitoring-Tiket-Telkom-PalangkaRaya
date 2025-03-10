import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/domain/entities/rekap_absen.dart';
import 'package:telkom_ticket_manager/utils/failure.dart';

abstract class RekapAbsenRepository {
  Future<Either<Failure, RekapAbsen>> getRekapAbsen(
      {String filter = 'today', DateTimeRange? rangeTanggalCustom});
}
