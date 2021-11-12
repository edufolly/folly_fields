import 'package:flutter/material.dart';

///
///
///
class ActionFunction<T> {
  final Future<bool> Function(BuildContext context, T? object) showButton;

  final Future<Widget> Function(BuildContext context, T? object) onPressed;

  ///
  ///
  ///
  ActionFunction({
    required this.showButton,
    required this.onPressed,
  });
}
