import 'package:telkom_ticket_manager/data/models/pelanggan_model.dart';
import 'package:telkom_ticket_manager/data/models/pelanggan_response.dart';
import 'package:telkom_ticket_manager/data/models/teknisi_model.dart';
import 'package:telkom_ticket_manager/data/models/teknisi_response.dart';
import 'package:telkom_ticket_manager/data/models/tiket_model.dart';
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

// pelanggan dummy
const tPelangganModel = PelangganModel(
    idpelanggan: 'idpelanggan', nama: 'nama', nohp: 'nohp', alamat: 'alamat');

const tPelangganResponseModel =
    PelangganResponseModel(pelangganList: [tPelangganModel]);

// tiket dummy

final tTiketModel = TiketModel(
  idTiket: 1,
  nomorTiket: 'nomorTiket',
  nomorInternet: 'nomorInternet',
  keluhan: 'keluhan',
  notePelanggan: 'notePelanggan',
  pelanggan: const PelangganModel(
      idpelanggan: 'idpelanggan', nama: 'nama', nohp: 'nohp', alamat: 'alamat'),
  idOdp: 'ODP-PLK-FAE/175 FAE/D09/175.01',
  namaTeknisi: 'Loudri',
  createdAt: DateTime(2024, 1, 1, 0, 0, 0),
  updatedAt: DateTime(2024, 1, 1, 0, 0, 0),
  type: 'type',
  status: 'status',
  ket: 'ket',
);
