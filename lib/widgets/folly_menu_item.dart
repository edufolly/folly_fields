import 'package:flutter/material.dart';

///
///
///
class FollyMenuItem extends StatelessWidget {
  final String label;
  final IconData? iconData;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final Color? color;
  final Color backgroundColor;

  ///
  ///
  ///
  const FollyMenuItem({
    required this.label,
    required this.onTap,
    this.iconData,
    this.onLongPress,
    this.color,
    this.backgroundColor = Colors.transparent,
    super.key,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    Color accentColor = color ??
        (Theme.of(context).brightness == Brightness.light
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.onSurface);

    return ListTile(
      leading: iconData == null
          ? null
          : Icon(
              iconData,
              color: accentColor,
            ),
      title: Text(
        label,
        style: TextStyle(
          color: accentColor,
        ),
      ),
      onTap: onTap,
      onLongPress: onLongPress,
      tileColor: backgroundColor,
    );
  }
}
