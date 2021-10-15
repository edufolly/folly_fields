import 'package:flutter/material.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/responsive/responsive.dart';

///
///
///
class ResponsiveGrid extends StatelessResponsive {
  final List<Responsive> children;
  final CrossAxisAlignment rowCrossAxisAlignment;

  ///
  ///
  ///
  const ResponsiveGrid({
    required this.children,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    int? sizeExtraSmall,
    int? sizeSmall,
    int? sizeMedium,
    int? sizeLarge,
    int? sizeExtraLarge,
    double? minHeight,
    Key? key,
  }) : super(
          sizeExtraSmall: sizeExtraSmall,
          sizeSmall: sizeSmall,
          sizeMedium: sizeMedium,
          sizeLarge: sizeLarge,
          sizeExtraLarge: sizeExtraLarge,
          minHeight: minHeight,
          key: key,
        );

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    ResponsiveSize rSize = FollyFields().checkResponsiveSize(context);

    List<Widget> columnChildren = <Widget>[];

    int total = 0;

    double minHeight = -1;

    List<Widget> rowChildren = <Widget>[];

    for (Responsive child in children) {
      int size = child.responsiveSize(rSize);

      if (total + size > 12) {
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
          child: child,
        ),
      );
    }

    if (rowChildren.isNotEmpty) {
      columnChildren.add(_createRow(rowChildren, minHeight));
    }

    return Column(children: columnChildren);
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
