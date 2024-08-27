import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/utils/style.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

class TicketTable extends StatefulWidget {
  const TicketTable({super.key});

  @override
  State<TicketTable> createState() => _TicketTableState();
}

class _TicketTableState extends State<TicketTable> {
  int? _sortColumnIndex;
  bool _sortAscending = true;
  List<Map<String, dynamic>> _data = [
    {
      'ticketNo': '1',
      'name': 'Gabriel Rusan',
      'address': 'Jln. G Obos 19 A',
      'description': 'Ini loh mas',
      'startTime': '07:22',
      'endTime': '10:20',
      'technician': 'Lukman',
      'status': 'Done'
    },
    {
      'ticketNo': '2',
      'name': 'Alex',
      'address': 'Jln. G Obos 19 A',
      'description': 'Lampu merah di modem menyala abangkuh',
      'startTime': '07:22',
      'endTime': '10:20',
      'technician': 'Lukman',
      'status': 'Done'
    },
    // Tambahkan data lainnya di sini
  ];

  void _sort<T>(Comparable<T> Function(Map<String, dynamic>) getField,
      int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      _data.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.only(bottom: 8, top: 16, left: 16, right: 16),
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            color: lightGrey.withOpacity(.1),
            blurRadius: 12,
          )
        ],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              CustomText(
                  text: "Ticket Table",
                  color: lightGrey,
                  weight: FontWeight.bold),
            ],
          ),
          SizedBox(
            height: 440,
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 1500,
              columns: [
                DataColumn2(
                  fixedWidth: 100,
                  label: const CustomText(
                      text: 'No. Tiket',
                      textAlign: TextAlign.center,
                      weight: FontWeight.bold),
                  onSort: (columnIndex, ascending) =>
                      _sort((d) => d['ticketNo'], columnIndex, ascending),
                ),
                DataColumn2(
                  fixedWidth: 200,
                  label: const CustomText(
                      text: 'Nama Pelanggan',
                      textAlign: TextAlign.center,
                      weight: FontWeight.bold),
                  onSort: (columnIndex, ascending) =>
                      _sort((d) => d['name'], columnIndex, ascending),
                ),
                DataColumn2(
                  fixedWidth: 300,
                  label: const CustomText(
                      text: 'Alamat Pelanggan',
                      textAlign: TextAlign.center,
                      weight: FontWeight.bold),
                  onSort: (columnIndex, ascending) =>
                      _sort((d) => d['address'], columnIndex, ascending),
                ),
                DataColumn2(
                  fixedWidth: 300,
                  label: const CustomText(
                      text: 'Deskripsi Gangguan',
                      textAlign: TextAlign.center,
                      weight: FontWeight.bold),
                  onSort: (columnIndex, ascending) =>
                      _sort((d) => d['description'], columnIndex, ascending),
                ),
                DataColumn2(
                  fixedWidth: 120,
                  label: const CustomText(
                      text: 'Start Time',
                      textAlign: TextAlign.center,
                      weight: FontWeight.bold),
                  onSort: (columnIndex, ascending) =>
                      _sort((d) => d['startTime'], columnIndex, ascending),
                ),
                DataColumn2(
                  fixedWidth: 120,
                  label: const CustomText(
                      text: 'End Time',
                      textAlign: TextAlign.center,
                      weight: FontWeight.bold),
                  onSort: (columnIndex, ascending) =>
                      _sort((d) => d['endTime'], columnIndex, ascending),
                ),
                DataColumn2(
                  fixedWidth: 200,
                  label: const CustomText(
                      text: 'Teknisi',
                      textAlign: TextAlign.center,
                      weight: FontWeight.bold),
                  onSort: (columnIndex, ascending) =>
                      _sort((d) => d['technician'], columnIndex, ascending),
                ),
                DataColumn2(
                  label: const CustomText(
                      text: 'Status',
                      textAlign: TextAlign.center,
                      weight: FontWeight.bold),
                  onSort: (columnIndex, ascending) =>
                      _sort((d) => d['status'], columnIndex, ascending),
                ),
              ],
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              rows: _data
                  .map((data) => DataRow(
                        cells: [
                          DataCell(CustomText(text: data['ticketNo'])),
                          DataCell(CustomText(text: data['name'])),
                          DataCell(CustomText(text: data['address'])),
                          DataCell(CustomText(text: data['description'])),
                          DataCell(CustomText(text: data['startTime'])),
                          DataCell(CustomText(text: data['endTime'])),
                          DataCell(CustomText(text: data['technician'])),
                          DataCell(CustomText(text: data['status'])),
                        ],
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
