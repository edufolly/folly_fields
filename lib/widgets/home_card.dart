import 'package:flutter/material.dart';
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
  final List<PopupIconMenuItem<O>>? menuItems;
  final Function(T item, O operation)? onMenuSelect;
  final Color? backgroundColor;
  final String? tooltip;
  final double fontSize;
  final FontWeight? fontWeight;
  final double iconSize;
  final BoxShadow boxShadow;

  ///
  ///
  ///
  const HomeCard({
    required this.item,
    required this.name,
    required this.iconData,
    required this.onTap,
    this.menuItems,
    this.onMenuSelect,
    this.backgroundColor,
    this.tooltip,
    this.fontSize = 16,
    this.fontWeight,
    this.iconSize = 42,
    this.boxShadow = const BoxShadow(
      color: Colors.black26,
      offset: Offset(1, 0.5),
      blurRadius: 6,
    ),
    super.key,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    Color onSurface = backgroundColor ??
        (Theme.of(context).brightness == Brightness.light
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.onSurface);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[boxShadow],
      ),
      child: InkWell(
        onTap: () => onTap(item),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: SizedBox(
                    height: iconSize,
                    width: iconSize,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: FaIcon(
                        iconData,
                        color: onSurface,
                      ),
                    ),
                  ),
                ),
                if (menuItems != null && menuItems!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: PopupMenuButton<O>(
                      tooltip: tooltip ?? 'Opções do Favorito',
                      icon: const FaIcon(
                        FontAwesomeIcons.ellipsisVertical,
                        color: Colors.black12,
                      ),
                      itemBuilder: (BuildContext context) => menuItems!
                          .map((PopupIconMenuItem<O> item) => item.widget)
                          .toList(),
                      onSelected: (O operation) =>
                          onMenuSelect?.call(item, operation),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: onSurface,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
