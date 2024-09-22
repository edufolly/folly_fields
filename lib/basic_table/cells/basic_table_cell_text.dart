import 'package:flutter/widgets.dart';
import 'package:folly_fields/basic_table/cells/basic_table_abstract_cell.dart';

///
///
///
class BasicTableCellText extends BasicTableAbstractCell {
  final String _text;
  final TextAlign? _textAlign;
  final TextOverflow _textOverflow;
  final TextStyle? _textStyle;

  ///
  ///
  ///
  const BasicTableCellText(
    String text, {
    super.padding,
    super.align,
    super.background,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    TextStyle? textStyle,
    super.key,
  })  : _text = text,
        _textAlign = textAlign,
        _textOverflow = textOverflow ?? TextOverflow.ellipsis,
        _textStyle = textStyle;

  ///
  ///
  ///
  const BasicTableCellText.center(
    String text, {
    EdgeInsets? padding,
    AlignmentGeometry? align,
    Color? background,
    TextAlign? textAlign,
    TextOverflow? textOverflow,
    TextStyle? textStyle,
    Key? key,
  }) : this(
          text,
          padding: padding,
          align: align ?? Alignment.center,
          background: background,
          textAlign: textAlign ?? TextAlign.center,
          textOverflow: textOverflow,
          textStyle: textStyle,
          key: key,
        );

  ///
  ///
  ///
  String get text => _text;

  ///
  ///
  ///
  TextAlign? get textAlign => _textAlign;

  ///
  ///
  ///
  TextOverflow get textOverflow => _textOverflow;

  ///
  ///
  ///
  TextStyle? get textStyle => _textStyle;

  ///
  ///
  ///
  @override
  Widget get child => Text(
        text,
        textAlign: textAlign,
        overflow: textOverflow,
        style: textStyle,
      );
}
