import 'package:flutter/widgets.dart';
import 'package:folly_fields/basic_table/cells/basic_table_abstract_cell.dart';
import 'package:folly_fields/basic_table/cells/basic_table_cell_header.dart';

///
///
///
class BasicTableColumnBuilder {
  final double width;
  final BasicTableAbstractCell? Function(BuildContext context, int row) builder;
  final BasicTableCellHeader? Function(BuildContext context)? header;
  final bool flexible;

  ///
  ///
  ///
  const BasicTableColumnBuilder({
    required this.width,
    required this.builder,
    this.header,
    this.flexible = true,
  });
}
