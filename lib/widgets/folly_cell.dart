import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
///
///
class FollyCell extends StatelessWidget {
  final AlignmentGeometry align;
  final Color color;
  final Widget child;

  ///
  ///
  ///
  const FollyCell({
    required this.child,
    this.align = Alignment.centerLeft,
    this.color = Colors.transparent,
    super.key,
  });

  ///
  ///
  ///
  const FollyCell.empty({
    this.color = Colors.transparent,
    super.key,
  })  : align = Alignment.center,
        child = const SizedBox.shrink();

  ///
  ///
  ///
  FollyCell._text(
    String text, {
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
    Alignment align = Alignment.bottomLeft,
    Color color = Colors.transparent,
    TextAlign textAlign = TextAlign.start,
    TextStyle style = const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    bool selectable = false,
    Key? key,
  }) : this._text(
          text,
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
    Alignment align = Alignment.centerLeft,
    Color color = Colors.transparent,
    TextAlign textAlign = TextAlign.start,
    TextStyle? style,
    bool selectable = false,
    Key? key,
  }) : this._text(
          text,
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
    Alignment align = Alignment.center,
    Color color = Colors.transparent,
    TextAlign textAlign = TextAlign.center,
    TextStyle? style,
    bool selectable = false,
    Key? key,
  }) : this._text(
          text,
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
              align: align,
              color: color,
              textAlign: textAlign,
              style: style,
              selectable: selectable,
              key: key,
            )
          : FollyCell.text(
              zeroText,
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
              align: align,
              color: color,
              textAlign: textAlign,
              style: style,
              selectable: selectable,
              key: key,
            )
          : FollyCell.text(
              zeroText,
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
    return Align(
      alignment: align,
      child: child,
    );
  }
}
