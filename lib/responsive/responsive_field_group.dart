import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/responsive/responsive_grid.dart';

class ResponsiveFieldGroup extends ResponsiveStateless {
  final List<Responsive> children;
  final String? labelText;
  final bool edit;
  final EdgeInsets padding;
  final InputDecoration? decoration;
  final int maxColumns;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final EdgeInsetsGeometry? gridMargin;
  final EdgeInsetsGeometry? gridPadding;

  const ResponsiveFieldGroup({
    required this.children,
    this.labelText,
    this.edit = true,
    this.padding = const EdgeInsets.all(8),
    this.decoration,
    this.maxColumns = 12,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.gridMargin,
    this.gridPadding,
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  }) : assert(
         labelText == null || decoration == null,
         'labelText or decoration must be null.',
       );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: InputDecorator(
        decoration:
            decoration ??
            InputDecoration(
              border: const OutlineInputBorder(),
              labelText: labelText,
              enabled: edit,
            ),
        child: ResponsiveGrid(
          maxColumns: maxColumns,
          rowCrossAxisAlignment: rowCrossAxisAlignment,
          margin: gridMargin,
          padding: gridPadding,
          sizeMedium: 12,
          children: children,
        ),
      ),
    );
  }
}
