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
    super.key,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    final ListTileThemeData tileTheme = ListTileTheme.of(context);

    final Color? iconColor = tileTheme.iconColor ??
        switch (Theme.of(context).brightness) {
          Brightness.light => Colors.black45,
          Brightness.dark => null
        };

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
