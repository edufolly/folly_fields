import 'package:flutter/material.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomSheetHeader extends StatelessWidget {
  final String title;
  final IconData? iconData;
  final EdgeInsets padding;

  const BottomSheetHeader(
    this.title, {
    this.iconData,
    this.padding = const EdgeInsets.fromLTRB(16, 4, 16, 0),
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          if (isNotNull(iconData))
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                iconData,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(FontAwesomeIcons.xmark),
          ),
        ],
      ),
    );
  }
}
