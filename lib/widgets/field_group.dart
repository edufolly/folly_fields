import 'package:flutter/material.dart';

///
///
///
class FieldGroup extends StatelessWidget {
  final EdgeInsets padding;
  final bool edit;
  final String? labelText;
  final InputDecoration? decoration;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;

  ///
  ///
  ///
  const FieldGroup({
    required this.children,
    this.decoration,
    this.padding = const EdgeInsets.all(8),
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.edit = true,
    this.labelText,
    super.key,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InputDecorator(
        decoration: decoration ??
            InputDecoration(
              border: const OutlineInputBorder(),
              labelText: labelText,
              enabled: edit,
            ),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        ),
      ),
    );
  }
}
