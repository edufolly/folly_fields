import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FollyCell extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;
  final AlignmentGeometry align;
  final Color color;

  const FollyCell({
    required this.child,
    required this.padding,
    this.align = Alignment.centerLeft,
    this.color = Colors.transparent,
    super.key,
  });

  const FollyCell.empty({
    this.color = Colors.transparent,
    this.padding = EdgeInsets.zero,
    super.key,
  }) : align = Alignment.center,
       child = const SizedBox.shrink();

  FollyCell._text(
    final String text, {
    required this.padding,
    required this.align,
    required this.color,
    required final TextAlign textAlign,
    required final TextStyle? style,
    required final bool selectable,
    super.key,
  }) : child = selectable
           ? SelectableText(text, textAlign: textAlign, style: style)
           : Text(text, textAlign: textAlign, style: style);

  FollyCell.textHeader(
    final String text, {
    final EdgeInsets padding = EdgeInsets.zero,
    final Alignment align = Alignment.bottomLeft,
    final Color color = Colors.transparent,
    final TextAlign textAlign = TextAlign.left,
    final TextStyle style = const TextStyle(fontWeight: FontWeight.bold),
    final bool selectable = false,
    final Key? key,
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

  FollyCell.textHeaderCenter(
    final String text, {
    final EdgeInsets padding = EdgeInsets.zero,
    final Alignment align = Alignment.bottomCenter,
    final Color color = Colors.transparent,
    final TextAlign textAlign = TextAlign.center,
    final TextStyle style = const TextStyle(fontWeight: FontWeight.bold),
    final bool selectable = false,
    final Key? key,
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

  FollyCell.textHeaderRight(
    final String text, {
    final EdgeInsets padding = EdgeInsets.zero,
    final Alignment align = Alignment.bottomRight,
    final Color color = Colors.transparent,
    final TextAlign textAlign = TextAlign.right,
    final TextStyle style = const TextStyle(fontWeight: FontWeight.bold),
    final bool selectable = false,
    final Key? key,
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

  FollyCell.text(
    final String text, {
    final EdgeInsets padding = EdgeInsets.zero,
    final Alignment align = Alignment.centerLeft,
    final Color color = Colors.transparent,
    final TextAlign textAlign = TextAlign.start,
    final TextStyle? style,
    final bool selectable = false,
    final Key? key,
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

  FollyCell.textCenter(
    final String text, {
    final EdgeInsets padding = EdgeInsets.zero,
    final Alignment align = Alignment.center,
    final Color color = Colors.transparent,
    final TextAlign textAlign = TextAlign.center,
    final TextStyle? style,
    final bool selectable = false,
    final Key? key,
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

  FollyCell.number(
    final num number, {
    final EdgeInsets padding = EdgeInsets.zero,
    final Alignment align = Alignment.centerRight,
    final Color color = Colors.transparent,
    final TextAlign textAlign = TextAlign.end,
    final TextStyle? style,
    final String locale = 'pt_br',
    final String pattern = '#,##0.00',
    final bool selectable = false,
    final Key? key,
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

  FollyCell.integer(
    final num number, {
    final EdgeInsets padding = EdgeInsets.zero,
    final Alignment align = Alignment.centerRight,
    final Color color = Colors.transparent,
    final TextAlign textAlign = TextAlign.end,
    final TextStyle? style,
    final String locale = 'pt_br',
    final String pattern = '#,##0',
    final bool selectable = false,
    final Key? key,
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

  FollyCell.date(
    final DateTime date, {
    final EdgeInsets padding = EdgeInsets.zero,
    final Alignment align = Alignment.center,
    final Color color = Colors.transparent,
    final TextAlign textAlign = TextAlign.center,
    final TextStyle? style,
    final String locale = 'pt_br',
    final String pattern = 'dd/MM/yyyy',
    final bool selectable = false,
    final Key? key,
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

  FollyCell.time(
    final DateTime date, {
    final EdgeInsets padding = EdgeInsets.zero,
    final Alignment align = Alignment.center,
    final Color color = Colors.transparent,
    final TextAlign textAlign = TextAlign.center,
    final TextStyle? style,
    final String locale = 'pt_br',
    final String pattern = 'HH:mm',
    final bool selectable = false,
    final Key? key,
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

  FollyCell.dateTime(
    final DateTime date, {
    final EdgeInsets padding = EdgeInsets.zero,
    final Alignment align = Alignment.center,
    final Color color = Colors.transparent,
    final TextAlign textAlign = TextAlign.center,
    final TextStyle? style,
    final String locale = 'pt_br',
    final String pattern = 'dd/MM/yyyy HH:mm',
    final bool selectable = false,
    final Key? key,
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

  FollyCell.iconButton(
    final IconData iconData, {
    final Function()? onPressed,
    this.padding = EdgeInsets.zero,
    this.align = Alignment.center,
    this.color = Colors.transparent,
    super.key,
  }) : child = FittedBox(
         child: IconButton(icon: Icon(iconData), onPressed: onPressed),
       );

  factory FollyCell.positive(
    final dynamic value, {
    final EdgeInsets padding = EdgeInsets.zero,
    final Alignment align = Alignment.centerRight,
    final Color color = Colors.transparent,
    final TextAlign textAlign = TextAlign.end,
    final TextStyle? style,
    final String zeroText = '-  ',
    final bool selectable = false,
    final Key? key,
  }) => value is num && value > 0
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

  factory FollyCell.notZero(
    final dynamic value, {
    final EdgeInsets padding = EdgeInsets.zero,
    final Alignment align = Alignment.centerRight,
    final Color color = Colors.transparent,
    final TextAlign textAlign = TextAlign.end,
    final TextStyle? style,
    final String zeroText = '--',
    final bool selectable = false,
    final Key? key,
  }) => value is num && value != 0
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

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: padding,
      child: Align(alignment: align, child: child),
    );
  }
}
