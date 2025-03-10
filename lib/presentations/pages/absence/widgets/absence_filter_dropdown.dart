import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:telkom_ticket_manager/presentations/blocs/rekap_absen_bloc/rekap_absen_bloc.dart';

class AbsenceFilterDropdown extends StatefulWidget {
  final String filter;
  final DateTimeRange? tanggalRangeCustom;

  const AbsenceFilterDropdown(
      {super.key, required this.filter, this.tanggalRangeCustom});
  @override
  _AbsenceFilterDropdownState createState() => _AbsenceFilterDropdownState();
}

class _AbsenceFilterDropdownState extends State<AbsenceFilterDropdown> {
  String _selectedValue = '';
  DateTimeRange? _selectedDateRange;
  final DateFormat _dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');

  @override
  void initState() {
    print(widget.filter);
    _selectedValue = widget.filter == 'today'
        ? 'Hari Ini'
        : widget.filter == '1_bulan'
            ? '1 Bulan'
            : widget.filter == '1_minggu'
                ? '1 Minggu'
                : widget.filter == 'kemarin'
                    ? 'Kemarin'
                    : widget.filter == 'custom'
                        ? 'Custom'
                        : 'Hari Ini';
    _selectedDateRange = widget.tanggalRangeCustom;
    super.initState();
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange: _selectedDateRange,
    );
    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
        _selectedValue = 'Custom';
        context.read<RekapAbsenBloc>().add(FetchRekapAbsen(
            filter: 'custom', rangeTanggalCustom: _selectedDateRange));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), // Outline border
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.calendar_month,
                  color: Colors.grey), // Prefix icon
              const SizedBox(width: 8), // Spacing between icon and dropdown
              DropdownButton<String>(
                focusColor: Colors.transparent,
                value: _selectedValue,
                onChanged: (String? newValue) {
                  if (newValue == 'Custom') {
                    _selectDateRange(context);
                  } else {
                    setState(() {
                      _selectedValue = newValue!;
                      _selectedDateRange = null;
                    });
                    context.read<RekapAbsenBloc>().add(FetchRekapAbsen(
                        filter: newValue == 'Hari Ini'
                            ? 'today'
                            : newValue == '1 Bulan'
                                ? '1_bulan'
                                : newValue == '1 Minggu'
                                    ? '1_minggu'
                                    : newValue == 'Kemarin'
                                        ? 'kemarin'
                                        : ''));
                  }
                },
                items: <String>[
                  'Hari Ini',
                  'Kemarin',
                  '1 Minggu',
                  '1 Bulan',
                  'Custom'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                underline: const SizedBox(), // Remove default underline
                elevation: 0,
                icon: const Icon(Icons.arrow_drop_down,
                    color: Colors.grey), // Custom dropdown icon
                style: const TextStyle(
                  color: Colors.black, // Text color
                  fontSize: 16,
                ),
                // dropdownColor: Colors.white, // Dropdown background color
              ),
            ],
          ),
        ),
        if (_selectedDateRange != null) ...[
          const SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () {
              _selectDateRange(context);
            },
            mouseCursor: SystemMouseCursors.click,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Outline border
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: Text(
                  '${_dateFormat.format(_selectedDateRange!.start)} - ${_dateFormat.format(_selectedDateRange!.end)}',
                  style: const TextStyle(fontSize: 16),
                )),
          )
        ]
      ],
    );
  }
}
