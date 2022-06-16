import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/widgets/field_group.dart';

///
///
///
class ResponsiveFieldGroup extends StatelessResponsive {
  final EdgeInsets padding;
  final String? labelText;
  final bool edit;
  final InputDecoration? decoration;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;

  ///
  ///
  ///
  const ResponsiveFieldGroup({
    required this.children,
    this.labelText,
    this.edit = true,
    this.decoration,
    this.padding = const EdgeInsets.all(8),
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    super.key,
  }) : assert(
          labelText == null || decoration == null,
          'labelText or decoration must be null.',
        );

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return FieldGroup(
      decoration: decoration ??
          InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
            enabled: edit,
          ),
      padding: padding,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }
}
