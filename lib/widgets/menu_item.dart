import 'package:flutter/material.dart';

///
///
///
class MenuItem extends StatelessWidget {
  final String label;
  final IconData iconData;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final Color? color;
  final Color backgroundColor;

  ///
  ///
  ///
  const MenuItem({
    Key? key,
    required this.label,
    required this.iconData,
    required this.onTap,
    this.onLongPress,
    this.color,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

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
      leading: Icon(
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
