import 'package:flutter/material.dart';

///
///
///
class FieldGroup extends StatelessWidget {
  final EdgeInsets padding;
  final InputDecoration decoration;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;

  ///
  ///
  ///
  const FieldGroup({
    required this.children,
    required this.decoration,
    this.padding = const EdgeInsets.all(8),
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    Key? key,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InputDecorator(
        decoration: decoration,
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        ),
      ),
    );
  }
}
