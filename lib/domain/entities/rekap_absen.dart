import 'package:equatable/equatable.dart';
import 'package:telkom_ticket_manager/data/models/rekap_model.dart';

class RekapAbsen extends Equatable {
  final String message;
  final Summary summary;
  final List<Absen> data;

  const RekapAbsen({
    required this.message,
    required this.summary,
    required this.data,
  });

  factory RekapAbsen.fromModel(RekapAbsenModel model) {
    return RekapAbsen(
      message: model.message,
      summary: model.summary,
      data: model.data,
    );
  }

  @override
  List<Object?> get props => [message, summary, data];
}
