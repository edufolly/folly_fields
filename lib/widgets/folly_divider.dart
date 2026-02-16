import 'package:flutter/material.dart';

@Deprecated('This class will be removed.')
class FollyDivider extends StatelessWidget {
  final double height;
  final Color? color;
  final bool enabled;

  const FollyDivider({
    super.key,
    this.height = 1.0,
    this.color,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) => Container(
    height: height,
    color:
        color ??
        (Theme.of(context).brightness == Brightness.light
            ? enabled
                  ? Colors.black38
                  : Colors.black12
            : enabled
            ? Colors.white38
            : Colors.white12),
  );
}
