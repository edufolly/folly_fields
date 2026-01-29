import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TableIconButton extends ResponsiveStateless {
  final VoidCallback onPressed;
  final bool enabled;
  final IconData iconData;
  final String? tooltip;

  const TableIconButton({
    required this.onPressed,
    required this.enabled,
    required this.iconData,
    this.tooltip,
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    ListTileThemeData tileTheme = ListTileTheme.of(context);

    Color? iconColor =
        tileTheme.iconColor ??
        switch (Theme.of(context).brightness) {
          Brightness.light => Colors.black45,
          Brightness.dark => null,
        };

    return Flexible(
      flex: 0,
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: IconButton(
          tooltip: tooltip,
          icon: FaIcon(iconData, color: iconColor),
          onPressed: enabled ? onPressed : null,
          mouseCursor: enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.forbidden,
        ),
      ),
    );
  }
}
