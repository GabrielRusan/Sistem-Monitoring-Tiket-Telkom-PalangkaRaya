import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/data/models/rekap_model.dart';

abstract class RekapAbsenRemoteDataSource {
  Future<RekapAbsenModel> getRekapAbsen(
      {String filter = 'today', DateTimeRange? rangeTanggalCustom});
}
