import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/responsive/responsive_builder.dart';

///
///
///
class ResponsiveGrid extends ResponsiveStateless {
  final List<Responsive> children;
  final int maxColumns;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  ///
  ///
  ///
  const ResponsiveGrid({
    required this.children,
    this.maxColumns = 12,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.margin,
    this.padding,
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  });

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (
        BuildContext context,
        ResponsiveSize responsiveSize,
      ) {
        List<Widget> columnChildren = <Widget>[];

        int total = 0;

        double minHeight = -1;

        List<Widget> rowChildren = <Widget>[];

        for (Responsive child in children) {
          int size = child.responsiveSize(responsiveSize);

          if (size > 0) {
            if (total + size > maxColumns) {
              columnChildren.add(_createRow(rowChildren, minHeight));
              rowChildren = <Widget>[];
              total = 0;
              minHeight = -1;
            }

            if (child.safeMinHeight > minHeight) {
              minHeight = child.safeMinHeight;
            }

            total += size;

            rowChildren.add(
              Flexible(
                flex: size,
                child: padding != null
                    ? Padding(
                        padding: padding!,
                        child: child,
                      )
                    : child,
              ),
            );
          }
        }

        if (rowChildren.isNotEmpty) {
          columnChildren.add(_createRow(rowChildren, minHeight));
        }

        Widget column = Column(
          children: columnChildren,
        );

        if (margin != null) {
          column = Padding(
            padding: margin!,
            child: column,
          );
        }

        return column;
      },
    );
  }

  ///
  ///
  ///
  Widget _createRow(
    List<Widget> rowData,
    double minHeight,
  ) =>
      minHeight >= 0
          ? SizedBox(
              height: minHeight,
              child: Row(
                crossAxisAlignment: rowCrossAxisAlignment,
                children: rowData,
              ),
            )
          : Row(
              crossAxisAlignment: rowCrossAxisAlignment,
              children: rowData,
            );
}
