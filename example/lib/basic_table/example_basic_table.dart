import 'package:flutter/material.dart';
import 'package:folly_fields/basic_table/basic_table.dart';
import 'package:folly_fields/basic_table/basic_table_column_builder.dart';
import 'package:folly_fields/basic_table/cells/basic_table_cell_header.dart';
import 'package:folly_fields/basic_table/cells/basic_table_cell_text.dart';
import 'package:folly_fields/util/folly_num_extension.dart';

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
  final int _count = 33;
  int _size = 10;
  int _page = 1;

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Table Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: BasicTable(
          rowsCount: _size.min(_count - ((_page - 1) * _size)),
          headerHeight: 32,
          rowHeight: 32,
          columnBuilders: <BasicTableColumnBuilder>[
            /// First Column
            BasicTableColumnBuilder(
              width: 100,
              header: (BuildContext context) =>
                  const BasicTableCellHeader.center('First Column'),
              builder: (BuildContext context, int row) =>
                  BasicTableCellText.center('Column 1 - '
                      'Row ${row + 1 + ((_page - 1) * _size)}'),
            ),

            /// Second Column
            BasicTableColumnBuilder(
              width: 150,
              header: (BuildContext context) =>
                  const BasicTableCellHeader.center('Second Column'),
              builder: (BuildContext context, int row) =>
                  BasicTableCellText.center('Column 2 - '
                      'Row ${row + 1 + ((_page - 1) * _size)}'),
            ),

            /// Third Column
            BasicTableColumnBuilder(
              width: 110,
              header: (BuildContext context) =>
                  const BasicTableCellHeader.center('Third Column'),
              builder: (BuildContext context, int row) =>
                  BasicTableCellText.center('Column 3 - '
                      'Row ${row + 1 + ((_page - 1) * _size)}'),
            ),

            /// Fourth Column
            BasicTableColumnBuilder(
              width: 120,
              header: (BuildContext context) =>
                  const BasicTableCellHeader.center('Fourth Column'),
              builder: (BuildContext context, int row) =>
                  BasicTableCellText.center('Column 4 - '
                      'Row ${row + 1 + ((_page - 1) * _size)}'),
            ),
          ],
          initialPageSize: _size,
          onPageSizeChanged: (int size, int page) => setState(() {
            _size = size;
            _page = page;
          }),
          totalPages: (_count / _size).ceil(),
          onPageChanged: (int page) => setState(() => _page = page),
        ),
      ),
    );
  }
}
