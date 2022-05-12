import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class TableIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool enabled;
  final IconData iconData;

  ///
  ///
  ///
  const TableIconButton({
    required this.onPressed,
    required this.enabled,
    required this.iconData,
    Key? key,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ListTileThemeData tileTheme = ListTileTheme.of(context);

    Color? iconColor = Colors.black45;
    if (tileTheme.iconColor != null) {
      iconColor = tileTheme.iconColor;
    } else {
      switch (theme.brightness) {
        case Brightness.light:
          iconColor = Colors.black45;
          break;
        case Brightness.dark:
          iconColor = null;
          break;
      }
    }

    return Flexible(
      flex: 0,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12,
        ),
        child: IconButton(
          icon: FaIcon(
            iconData,
            color: iconColor,
          ),
          onPressed: enabled ? onPressed : null,
          mouseCursor:
              enabled ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
        ),
      ),
    );
  }
}
