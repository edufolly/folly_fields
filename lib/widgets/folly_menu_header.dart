import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/widgets/popup_icon_menu_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class FollyMenuHeader<O> extends StatelessWidget {
  final String name;
  final String email;
  final String companyName;
  final Widget? expanded;
  final Color? color;
  final Color? background;
  final List<PopupIconMenuItem<O>>? menuItems;
  final Function(O operation)? onMenuSelect;

  ///
  ///
  ///
  const FollyMenuHeader({
    required this.name,
    required this.email,
    this.companyName = '',
    this.expanded,
    this.color,
    this.background,
    this.menuItems,
    this.onMenuSelect,
    super.key,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    Color localForeground = color ?? Theme.of(context).colorScheme.onPrimary;

    Color localBackground = background ?? Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      color: localBackground,
      child: SafeArea(
        child: expanded != null
            ? ExpandableTheme(
                data: ExpandableThemeData(
                  iconColor: localForeground,
                  collapseIcon: FontAwesomeIcons.caretUp,
                  expandIcon: FontAwesomeIcons.caretDown,
                  iconSize: 16,
                  iconPadding: const EdgeInsets.only(right: 5),
                ),
                child: ExpandableNotifier(
                  child: Column(
                    children: <Widget>[
                      ExpandableButton(
                        child: FollyUserHeader<O>(
                          name,
                          email,
                          companyName,
                          localForeground,
                          localBackground,
                          menuItems,
                          onMenuSelect,
                          expandable: true,
                        ),
                      ),
                      Expandable(
                        collapsed: Container(),
                        expanded: expanded!,
                      ),
                    ],
                  ),
                ),
              )
            : FollyUserHeader<O>(
                name,
                email,
                companyName,
                localForeground,
                localBackground,
                menuItems,
                onMenuSelect,
              ),
      ),
    );
  }
}

///
///
///
class FollyUserHeader<O> extends StatelessWidget {
  final String name;
  final String email;
  final String companyName;
  final Color foreground;
  final Color background;
  final bool expandable;
  final List<PopupIconMenuItem<O>>? menuItems;
  final Function(O operation)? onMenuSelect;

  ///
  ///
  ///
  const FollyUserHeader(
    this.name,
    this.email,
    this.companyName,
    this.foreground,
    this.background,
    this.menuItems,
    this.onMenuSelect, {
    this.expandable = false,
    super.key,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 6, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Avatar
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: CircleAvatar(
                  backgroundColor: Colors.black38,
                  radius: 36,
                  child: Text(
                    _initials(name, email).toUpperCase(),
                    style: TextStyle(
                      color: foreground,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              /// Edit Button
              if (menuItems != null && onMenuSelect != null)
                PopupMenuButton<O>(
                  icon: FaIcon(
                    FontAwesomeIcons.solidPenToSquare,
                    color: foreground,
                    size: 14,
                  ),
                  itemBuilder: (BuildContext context) => menuItems!
                      .map((PopupIconMenuItem<O> item) => item.widget)
                      .toList(),
                  onSelected: (O operation) => onMenuSelect!(operation),
                ),
            ],
          ),

          /// Name
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(
                    FontAwesomeIcons.solidUser,
                    color: foreground,
                    size: 14,
                  ),
                ),
                Expanded(
                  child: Text(
                    name,
                    style:
                        Theme.of(context).primaryTextTheme.bodyLarge?.copyWith(
                              color: foreground,
                            ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          /// Email
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(
                    FontAwesomeIcons.solidEnvelope,
                    color: foreground,
                    size: 14,
                  ),
                ),
                Expanded(
                  child: Text(
                    email,
                    style:
                        Theme.of(context).primaryTextTheme.bodyMedium?.copyWith(
                              color: foreground,
                            ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (expandable && companyName.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ExpandableIcon(),
                  ),
              ],
            ),
          ),

          /// Company Name
          if (companyName.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(
                      FontAwesomeIcons.building,
                      color: foreground,
                      size: 14,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      companyName,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyMedium
                          ?.copyWith(
                            color: foreground,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (expandable)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ExpandableIcon(),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  ///
  ///
  ///
  String _initials(String name, String email) {
    if (name.length < 2) {
      if (email.length < 2) {
        return '??';
      }

      return email.substring(0, 2);
    }

    List<String> parts = name.split(' ');

    if (parts.length < 2) {
      return name.substring(0, 2);
    }

    return parts.first[0] + parts.last[0];
  }
}
