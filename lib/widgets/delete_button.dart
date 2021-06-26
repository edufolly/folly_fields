import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool enabled;

  ///
  ///
  ///
  const DeleteButton({
    Key? key,
    required this.onPressed,
    required this.enabled,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ListTileTheme tileTheme = ListTileTheme.of(context);

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
        padding: EdgeInsets.only(
          top: 12.0,
        ),
        child: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.trashAlt,
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
