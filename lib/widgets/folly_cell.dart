import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
///
///
class FollyCell extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;
  final AlignmentGeometry align;
  final Color color;

  ///
  ///
  ///
  const FollyCell({
    required this.child,
    required this.padding,
    this.align = Alignment.centerLeft,
    this.color = Colors.transparent,
    super.key,
  });

  ///
  ///
  ///
  const FollyCell.empty({
    this.color = Colors.transparent,
    this.padding = EdgeInsets.zero,
    super.key,
  })  : align = Alignment.center,
        child = const SizedBox.shrink();

  ///
  ///
  ///
  FollyCell._text(
    String text, {
    required this.padding,
    required this.align,
    required this.color,
    required TextAlign textAlign,
    required TextStyle? style,
    required bool selectable,
    super.key,
  }) : child = selectable
            ? SelectableText(
                text,
                textAlign: textAlign,
                style: style,
              )
            : Text(
                text,
                textAlign: textAlign,
                style: style,
              );

  ///
  ///
  ///
  FollyCell.textHeader(
    String text, {
    EdgeInsets padding = EdgeInsets.zero,
    Alignment align = Alignment.bottomLeft,
    Color color = Colors.transparent,
    TextAlign textAlign = TextAlign.left,
    TextStyle style = const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    bool selectable = false,
    Key? key,
  }) : this._text(
          text,
          padding: padding,
          align: align,
          color: color,
          textAlign: textAlign,
          style: style,
          selectable: selectable,
          key: key,
        );

  ///
  ///
  ///
  FollyCell.textHeaderCenter(
    String text, {
    EdgeInsets padding = EdgeInsets.zero,
    Alignment align = Alignment.bottomCenter,
    Color color = Colors.transparent,
    TextAlign textAlign = TextAlign.center,
    TextStyle style = const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    bool selectable = false,
    Key? key,
  }) : this._text(
          text,
          padding: padding,
          align: align,
          color: color,
          textAlign: textAlign,
          style: style,
          selectable: selectable,
          key: key,
        );

  ///
  ///
  ///
  FollyCell.textHeaderRight(
      String text, {
        EdgeInsets padding = EdgeInsets.zero,
        Alignment align = Alignment.bottomRight,
        Color color = Colors.transparent,
        TextAlign textAlign = TextAlign.right,
        TextStyle style = const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        bool selectable = false,
        Key? key,
      }) : this._text(
    text,
    padding: padding,
    align: align,
    color: color,
    textAlign: textAlign,
    style: style,
    selectable: selectable,
    key: key,
  );

  ///
  ///
  ///
  FollyCell.text(
    String text, {
    EdgeInsets padding = EdgeInsets.zero,
    Alignment align = Alignment.centerLeft,
    Color color = Colors.transparent,
    TextAlign textAlign = TextAlign.start,
    TextStyle? style,
    bool selectable = false,
    Key? key,
  }) : this._text(
          text,
          padding: padding,
          align: align,
          color: color,
          textAlign: textAlign,
          style: style,
          selectable: selectable,
          key: key,
        );

  ///
  ///
  ///
  FollyCell.textCenter(
    String text, {
    EdgeInsets padding = EdgeInsets.zero,
    Alignment align = Alignment.center,
    Color color = Colors.transparent,
    TextAlign textAlign = TextAlign.center,
    TextStyle? style,
    bool selectable = false,
    Key? key,
  }) : this._text(
          text,
          padding: padding,
          align: align,
          color: color,
          textAlign: textAlign,
          style: style,
          selectable: selectable,
          key: key,
        );

  ///
  ///
  ///
  FollyCell.number(
    num number, {
    EdgeInsets padding = EdgeInsets.zero,
    Alignment align = Alignment.centerRight,
    Color color = Colors.transparent,
    TextAlign textAlign = TextAlign.end,
    TextStyle? style,
    String locale = 'pt_br',
    String pattern = '#,##0.00',
    bool selectable = false,
    Key? key,
  }) : this._text(
          NumberFormat(pattern, locale).format(number),
          padding: padding,
          align: align,
          color: color,
          textAlign: textAlign,
          style: style,
          selectable: selectable,
          key: key,
        );

  ///
  ///
  ///
  FollyCell.integer(
    num number, {
    EdgeInsets padding = EdgeInsets.zero,
    Alignment align = Alignment.centerRight,
    Color color = Colors.transparent,
    TextAlign textAlign = TextAlign.end,
    TextStyle? style,
    String locale = 'pt_br',
    String pattern = '#,##0',
    bool selectable = false,
    Key? key,
  }) : this.number(
          number,
          padding: padding,
          align: align,
          color: color,
          textAlign: textAlign,
          style: style,
          locale: locale,
          pattern: pattern,
          selectable: selectable,
          key: key,
        );

  ///
  ///
  ///
  FollyCell.date(
    DateTime date, {
    EdgeInsets padding = EdgeInsets.zero,
    Alignment align = Alignment.center,
    Color color = Colors.transparent,
    TextAlign textAlign = TextAlign.center,
    TextStyle? style,
    String locale = 'pt_br',
    String pattern = 'dd/MM/yyyy',
    bool selectable = false,
    Key? key,
  }) : this._text(
          DateFormat(pattern, locale).format(date),
          padding: padding,
          align: align,
          color: color,
          textAlign: textAlign,
          style: style,
          selectable: selectable,
          key: key,
        );

  ///
  ///
  ///
  FollyCell.time(
    DateTime date, {
    EdgeInsets padding = EdgeInsets.zero,
    Alignment align = Alignment.center,
    Color color = Colors.transparent,
    TextAlign textAlign = TextAlign.center,
    TextStyle? style,
    String locale = 'pt_br',
    String pattern = 'HH:mm',
    bool selectable = false,
    Key? key,
  }) : this.date(
          date,
          padding: padding,
          align: align,
          color: color,
          textAlign: textAlign,
          style: style,
          locale: locale,
          pattern: pattern,
          selectable: selectable,
          key: key,
        );

  ///
  ///
  ///
  FollyCell.dateTime(
    DateTime date, {
    EdgeInsets padding = EdgeInsets.zero,
    Alignment align = Alignment.center,
    Color color = Colors.transparent,
    TextAlign textAlign = TextAlign.center,
    TextStyle? style,
    String locale = 'pt_br',
    String pattern = 'dd/MM/yyyy HH:mm',
    bool selectable = false,
    Key? key,
  }) : this.date(
          date,
          padding: padding,
          align: align,
          color: color,
          textAlign: textAlign,
          style: style,
          locale: locale,
          pattern: pattern,
          selectable: selectable,
          key: key,
        );

  ///
  ///
  ///
  FollyCell.iconButton(
    IconData iconData, {
    Function()? onPressed,
    this.padding = EdgeInsets.zero,
    this.align = Alignment.center,
    this.color = Colors.transparent,
    super.key,
  }) : child = FittedBox(
          child: IconButton(
            icon: Icon(iconData),
            onPressed: onPressed,
          ),
        );

  ///
  ///
  ///
  factory FollyCell.positive(
    dynamic value, {
    EdgeInsets padding = EdgeInsets.zero,
    Alignment align = Alignment.centerRight,
    Color color = Colors.transparent,
    TextAlign textAlign = TextAlign.end,
    TextStyle? style,
    String zeroText = '-  ',
    bool selectable = false,
    Key? key,
  }) =>
      value is num && value > 0
          ? FollyCell.number(
              value,
              padding: padding,
              align: align,
              color: color,
              textAlign: textAlign,
              style: style,
              selectable: selectable,
              key: key,
            )
          : FollyCell.text(
              zeroText,
              padding: padding,
              align: align,
              color: color,
              textAlign: textAlign,
              style: style,
              selectable: selectable,
              key: key,
            );

  ///
  ///
  ///
  factory FollyCell.notZero(
    dynamic value, {
    EdgeInsets padding = EdgeInsets.zero,
    Alignment align = Alignment.centerRight,
    Color color = Colors.transparent,
    TextAlign textAlign = TextAlign.end,
    TextStyle? style,
    String zeroText = '--',
    bool selectable = false,
    Key? key,
  }) =>
      value is num && value != 0
          ? FollyCell.integer(
              value,
              padding: padding,
              align: align,
              color: color,
              textAlign: textAlign,
              style: style,
              selectable: selectable,
              key: key,
            )
          : FollyCell.text(
              zeroText,
              padding: padding,
              align: align,
              color: color,
              textAlign: textAlign,
              style: style,
              selectable: selectable,
              key: key,
            );

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Align(
        alignment: align,
        child: child,
      ),
    );
  }
}
