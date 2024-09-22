import 'package:flutter/widgets.dart';
import 'package:folly_fields/basic_table/basic_table_abstract_cell.dart';

///
///
///
class BasicTableCellWidget extends BasicTableAbstractCell {
  final Widget _child;

  ///
  ///
  ///
  const BasicTableCellWidget({
    required Widget child,
    super.padding,
    super.align,
    super.background,
    super.key,
  }) : _child = child;

  ///
  ///
  ///
  @override
  Widget get child => _child;

  ///
  ///
  ///
  static const BasicTableCellWidget empty = BasicTableCellWidget(
    padding: EdgeInsets.zero,
    child: SizedBox.shrink(),
  );
}
