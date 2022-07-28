import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class FollyMenuGroup extends StatelessWidget {
  @Deprecated('Use "label" instead.')
  final String? name;
  final String? label;
  final IconData? iconData;
  final List<Widget> items;
  final bool initialExpanded;
  final ExpandableController? controller;
  final Color? color;
  final Color backgroundColor;

  ///
  ///
  ///
  const FollyMenuGroup({
    required this.items,
    // TODO(anyone): Remove in next version.
    @Deprecated('Use "label" instead.')
    this.name,
    this.label,
    this.iconData,
    this.initialExpanded = false,
    this.controller,
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

    return ExpandableTheme(
      data: ExpandableThemeData(
        iconColor: accentColor,
        collapseIcon: FontAwesomeIcons.caretUp,
        expandIcon: FontAwesomeIcons.caretDown,
        iconSize: 16,
        iconPadding: const EdgeInsets.only(right: 5),
      ),
      child: ExpandableNotifier(
        controller: controller ??
            ExpandableController(initialExpanded: initialExpanded),
        child: Column(
          children: <Widget>[
            ExpandableButton(
              child: ListTile(
                leading: iconData == null
                    ? null
                    : Icon(
                        iconData,
                        color: accentColor,
                      ),
                title: Text(
                  // TODO(anyone): Remove in next version.
                  // ignore: deprecated_member_use_from_same_package
                  label ?? name ?? '',
                  style: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                trailing: ExpandableIcon(),
                tileColor: backgroundColor,
              ),
            ),
            Expandable(
              collapsed: Container(),
              expanded: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  children: items,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
