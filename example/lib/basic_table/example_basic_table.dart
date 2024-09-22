import 'package:flutter/material.dart';
import 'package:folly_fields/basic_table/basic_table.dart';
import 'package:folly_fields/basic_table/basic_table_cell_header.dart';
import 'package:folly_fields/basic_table/basic_table_cell_text.dart';
import 'package:folly_fields/basic_table/basic_table_column_builder.dart';

///
///
///
class ExampleBasicTable extends StatefulWidget {
///
  ///
  ///
  const ExampleBasicTable({super.key});

  ///
  ///
  ///
  @override
  State<ExampleBasicTable> createState() => _ExampleBasicTableState();
}

///
///
///
class _ExampleBasicTableState extends State<ExampleBasicTable> {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: BasicTable(
          rowsCount: 100,
          headerHeight: 32,
          rowHeight: 32,
          columnBuilders: <BasicTableColumnBuilder>[
            /// First Column
            BasicTableColumnBuilder(
              width: 100,
              header: (BuildContext context) =>
              const BasicTableCellHeader.center('First Column'),
              builder: (BuildContext context, int row) =>
                  BasicTableCellText.center('Column 1 - Row $row'),
            ),

            /// Second Column
            BasicTableColumnBuilder(
              width: 150,
              header: (BuildContext context) =>
              const BasicTableCellHeader.center('Second Column'),
              builder: (BuildContext context, int row) =>
                  BasicTableCellText.center('Column 2 - Row $row'),
            ),

            /// Third Column
            BasicTableColumnBuilder(
              width: 110,
              header: (BuildContext context) =>
              const BasicTableCellHeader.center('Third Column'),
              builder: (BuildContext context, int row) =>
                  BasicTableCellText.center('Column 3 - Row $row'),
            ),

            /// Fourth Column
            BasicTableColumnBuilder(
              width: 120,
              header: (BuildContext context) =>
              const BasicTableCellHeader.center('Fourth Column'),
              builder: (BuildContext context, int row) =>
                  BasicTableCellText.center('Column 4 - Row $row'),
            ),
          ],
        ),
      ),
    );
  }
}
