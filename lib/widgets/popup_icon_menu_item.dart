import 'package:flutter/material.dart';
import 'package:folly_fields/util/icon_helper.dart';

@Deprecated('This class will be removed.')
class PopupIconMenuItem<O> {
  final O operation;
  final String name;
  final String iconName;

  const PopupIconMenuItem({
    required this.operation,
    required this.name,
    required this.iconName,
  });

  PopupMenuItem<O> get widget => PopupMenuItem<O>(
    value: operation,
    child: ListTile(
      leading: Icon(IconHelper.iconData(iconName)),
      title: Text(name),
    ),
  );
}
