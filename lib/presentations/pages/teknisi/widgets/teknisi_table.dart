import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/utils/style.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';

/// Example without a datasource
class TeknisiTable extends StatelessWidget {
  const TeknisiTable({super.key});

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
                blurRadius: 12)
          ],
          border: Border.all(color: lightGrey, width: .5)),
      child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 1500,
          columns: const [
            DataColumn2(
              label: CustomText(
                text: 'No. Tiket',
                textAlign: TextAlign.center,
                weight: FontWeight.bold,
              ),
            ),
            DataColumn2(
              label: CustomText(
                text: 'Nama Pelanggan',
                textAlign: TextAlign.center,
                weight: FontWeight.bold,
              ),
            ),
            DataColumn2(
              label: CustomText(
                text: 'Alamat Pelanggan',
                textAlign: TextAlign.center,
                weight: FontWeight.bold,
              ),
            ),
            DataColumn2(
                label: CustomText(
                  text: 'Deskripsi Gangguan',
                  textAlign: TextAlign.center,
                  weight: FontWeight.bold,
                ),
                size: ColumnSize.L),
            DataColumn2(
              label: CustomText(
                text: 'Start Time',
                weight: FontWeight.bold,
              ),
            ),
            DataColumn2(
              label: CustomText(
                text: 'End Time',
                weight: FontWeight.bold,
              ),
            ),
            DataColumn2(
              label: CustomText(
                text: 'Teknisi',
                textAlign: TextAlign.center,
                weight: FontWeight.bold,
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: CustomText(
                text: 'Status',
                textAlign: TextAlign.center,
                weight: FontWeight.bold,
              ),
            ),
          ],
          rows: List<DataRow>.generate(
              10,
              (index) => DataRow(cells: [
                    const DataCell(CustomText(
                      text: "12345",
                    )),
                    const DataCell(CustomText(
                      text: "Gabriel Rusan",
                    )),
                    const DataCell(CustomText(text: "Jln. G Obos 19 A")),
                    const DataCell(CustomText(
                        text: "Lampu merah di modem menyala abangkuh")),
                    const DataCell(Row(
                      children: [
                        CustomText(
                          text: "07:22",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
                    const DataCell(CustomText(
                      text: "10:20",
                    )),
                    DataCell(
                      InkWell(
                        onTap: () {},
                        hoverColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: active,
                                width: .5,
                              ),
                              color: light,
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: CustomText(
                            text: "Assign Teknisi",
                            color: active.withOpacity(.7),
                          ),
                        ),
                      ),
                    ),
                    const DataCell(CustomText(
                      text: "Done",
                    )),
                  ]))),
    );
  }
}
