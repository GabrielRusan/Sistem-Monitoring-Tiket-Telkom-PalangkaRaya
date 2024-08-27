import 'package:telkom_ticket_manager/data/models/teknisi_model.dart';
import 'package:telkom_ticket_manager/data/models/teknisi_response.dart';
import 'package:telkom_ticket_manager/domain/entities/teknisi.dart';

final tTeknisiResponseModel =
    TeknisiResponseModel(teknisiList: tTeknisiModelList);

// Teknisi model dummy
final tTeknisiModel = TeknisiModel(
    idteknisi: 1,
    nama: 'nama',
    sektor: 'sektor',
    username: 'username',
    pass: 'pass',
    ket: 'ket',
    createdAt: DateTime(2024, 1, 1, 0, 0, 0),
    updatedAt: DateTime(2024, 1, 1, 0, 0, 0));

final tTeknisiModelList = [tTeknisiModel];

// Teknisi dummy
final tTeknisi = Teknisi(
    idteknisi: 1,
    nama: 'nama',
    sektor: 'sektor',
    username: 'username',
    pass: 'pass',
    ket: 'ket',
    createdAt: DateTime(2024, 1, 1, 0, 0, 0),
    updatedAt: DateTime(2024, 1, 1, 0, 0, 0));

final tTeknisiList = [tTeknisi];
