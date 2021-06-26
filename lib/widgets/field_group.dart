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
    Key? key,
    this.padding = const EdgeInsets.all(8.0),
    required this.decoration,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    required this.children,
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
