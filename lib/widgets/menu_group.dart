import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/widgets/menu_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class MenuGroup extends StatelessWidget {
  final String name;
  final List<MenuItem> items;
  final bool initialExpanded;
  final Color? color;

  ///
  ///
  ///
  const MenuGroup({
    required this.name,
    required this.items,
    this.initialExpanded = false,
    this.color,
    Key? key,
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

    return ExpandableTheme(
      data: ExpandableThemeData(
        iconColor: accentColor,
        collapseIcon: FontAwesomeIcons.caretUp,
        expandIcon: FontAwesomeIcons.caretDown,
        iconSize: 16,
        iconPadding: const EdgeInsets.only(right: 5),
      ),
      child: ExpandableNotifier(
        initialExpanded: initialExpanded,
        child: Column(
          children: <Widget>[
            ExpandableButton(
              child: ListTile(
                title: Text(
                  name,
                  style: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                trailing: ExpandableIcon(),
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
