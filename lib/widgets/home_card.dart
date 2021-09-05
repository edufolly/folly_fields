import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:folly_fields/widgets/popup_icon_menu_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class HomeCard<T, O> extends StatelessWidget {
  final T item;
  final String name;
  final IconData iconData;
  final Function(T item) onTap;
  final List<PopupIconMenuItem<O>> menuItems;
  final Function(T item, O operation) onMenuSelect;
  final Color? backgroundColor;
  final String? tooltip;

  ///
  ///
  ///
  const HomeCard({
    Key? key,
    required this.item,
    required this.name,
    required this.iconData,
    required this.onTap,
    required this.menuItems,
    required this.onMenuSelect,
    this.backgroundColor,
    this.tooltip,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    Color onSurface = backgroundColor ??
        (Theme.of(context).brightness == Brightness.light
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.onSurface);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            offset: Offset(1.0, 0.5),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => onTap(item),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: SizedBox(
                    height: 42.0,
                    width: 42.0,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: FaIcon(
                        iconData,
                        color: onSurface,
                      ),
                    ),
                  ),
                ),
                if (menuItems.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: PopupMenuButton<O>(
                      tooltip: tooltip ?? 'Opções do Favorito',
                      icon: const FaIcon(
                        FontAwesomeIcons.ellipsisV,
                        color: Colors.black12,
                      ),
                      itemBuilder: (BuildContext context) => menuItems
                          .map((PopupIconMenuItem<O> item) => item.widget)
                          .toList(),
                      onSelected: (O operation) =>
                          onMenuSelect(item, operation),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: onSurface,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
