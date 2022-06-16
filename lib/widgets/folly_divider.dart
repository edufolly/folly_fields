import 'package:flutter/material.dart';

///
///
///
class FollyDivider extends StatelessWidget {
  final double height;
  final Color? color;
  final bool enabled;

  ///
  ///
  ///
  const FollyDivider({
    super.key,
    this.height = 1.0,
    this.color,
    this.enabled = true,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    Color? effectiveColor;

    if (color != null) {
      effectiveColor = color;
    } else {
      if (Theme.of(context).brightness == Brightness.light) {
        if (enabled) {
          effectiveColor = Colors.black38;
        } else {
          effectiveColor = Colors.black12;
        }
      } else {
        if (enabled) {
          effectiveColor = Colors.white38;
        } else {
          effectiveColor = Colors.white12;
        }
      }
    }

    return Container(
      height: height,
      color: effectiveColor,
    );
  }
}
