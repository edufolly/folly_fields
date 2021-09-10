import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_model.dart';

///
///
///
class ActionFunction<T extends AbstractModel<Object>> {

  final Future<bool> Function(BuildContext context, T model) showButton;

  final Future<Widget> Function(BuildContext context, T model) onPressed;

  ActionFunction({
    required this.showButton,
    required this.onPressed,
  });
}
