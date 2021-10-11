import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive_widget.dart';

///
///
///
enum ResponsiveSize {
  extraSmall,
  small,
  medium,
  large,
  extraLarge,
}

///
///
///
class ResponsiveGrid extends StatelessWidget {
  final List<double> sizes;
  final List<ResponsiveWidget> children;

  ///
  ///
  ///
  const ResponsiveGrid({
    required this.sizes,
    required this.children,
    Key? key,
  })  : assert(sizes.length == 4, 'Sizes length must be equal to 4.'),
        super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    ResponsiveSize rSize = _checkResponsiveSize(context);

    List<Widget> columnChildren = <Widget>[];

    int total = 0;

    double minHeight = 0;

    List<Widget> rowChildren = <Widget>[];

    for (ResponsiveWidget child in children) {
      int size = child.responsiveSize(rSize);

      if (total + size > 12) {
        columnChildren.add(_createRow(rowChildren, minHeight));
        rowChildren = <Widget>[];
        total = 0;
        minHeight = 0;
      }

      if (child.minHeight > minHeight) {
        minHeight = child.minHeight;
      }

      total += size;

      rowChildren.add(
        Flexible(
          flex: size,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: child,
          ),
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
      SizedBox(
        height: minHeight,
        child: Row(
          children: rowData,
        ),
      );

  ///
  ///
  ///
  ResponsiveSize _checkResponsiveSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width < sizes[0]) {
      return ResponsiveSize.extraSmall;
    }

    if (width >= sizes[0] && width < sizes[1]) {
      return ResponsiveSize.small;
    }

    if (width >= sizes[1] && width < sizes[2]) {
      return ResponsiveSize.medium;
    }

    if (width >= sizes[2] && width < sizes[3]) {
      return ResponsiveSize.large;
    }

    return ResponsiveSize.extraLarge;
  }
}
