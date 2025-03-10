import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class StyledPaginataedTable extends PaginatedDataTable2 {
  StyledPaginataedTable({
    super.key,
    required super.columns,
    required super.source,
    super.wrapInCard = false,
    super.dividerThickness = 0.3,
    super.minWidth = 2000,
    super.renderEmptyRowsInTheEnd = false,
    super.dataRowHeight = 55,
    super.headingRowHeight = 55,
    super.sortAscending,
    super.sortColumnIndex,
    super.showCheckboxColumn = false,
  }) : super(
          headingRowColor:
              WidgetStateColor.resolveWith((states) => Colors.grey.shade50),
        );
}
