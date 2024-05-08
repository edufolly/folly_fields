import 'package:flutter/material.dart';

///
///
///
class HeaderText extends StatelessWidget {
  final String text;
  final bool enabled;

  ///
  ///
  ///
  const HeaderText(
    this.text, {
    this.enabled = true,
    super.key,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    TextStyle? columnHeaderTheme = Theme.of(context).textTheme.titleSmall;

    if (columnHeaderTheme != null && !enabled) {
      columnHeaderTheme = columnHeaderTheme.copyWith(
        color: Theme.of(context).disabledColor,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(width: double.infinity, child: Text(text)),
    );
  }
}
