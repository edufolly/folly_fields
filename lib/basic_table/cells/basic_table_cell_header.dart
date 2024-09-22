import 'package:flutter/widgets.dart';
import 'package:folly_fields/basic_table/cells/basic_table_cell_text.dart';

///
///
///
class BasicTableCellHeader extends BasicTableCellText {
  final bool _sortable;

  ///
  ///
  ///
  const BasicTableCellHeader(
    super.text, {
    bool? sortable,
    super.padding,
    AlignmentGeometry? align,
    super.background,
    super.textAlign,
    super.textOverflow,
    super.textStyle,
    super.key,
  })  : _sortable = sortable ?? false,
        super(
          align: align ?? Alignment.bottomLeft,
        );

  ///
  ///
  ///
  const BasicTableCellHeader.center(
    String text, {
    bool? sortable,
    EdgeInsets? padding,
    AlignmentGeometry? align,
    Color? background,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    TextStyle? textStyle,
    Key? key,
  }) : this(
          text,
          sortable: sortable,
          padding: padding,
          align: align ?? Alignment.bottomCenter,
          background: background,
          textAlign: textAlign ?? TextAlign.center,
          textOverflow: textOverflow,
          textStyle: textStyle,
          key: key,
        );

  ///
  ///
  ///
  bool get sortable => _sortable;
}
