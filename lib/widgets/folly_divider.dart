import 'package:flutter/material.dart';

///
///
///
class FollyDivider extends StatelessWidget {
  final double height;
  final Color? color;

  ///
  ///
  ///
  const FollyDivider({
    Key? key,
    this.height = 1.0,
    this.color,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) => Container(
        height: height,
        color: color ??
            (Theme.of(context).brightness == Brightness.light
                ? Colors.black38
                : Colors.white38),
      );
}
