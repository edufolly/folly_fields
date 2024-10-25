import 'package:flutter/material.dart';

///
///
///
class ChildBuilder extends StatelessWidget {
  final Widget child;
  final Widget Function(BuildContext context, Widget child) builder;

  ///
  ///
  ///
  const ChildBuilder({
    required this.child,
    required this.builder,
    super.key,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) => builder(context, child);
}
