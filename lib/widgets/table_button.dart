import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class TableButton extends StatelessResponsive {
  final String label;
  final VoidCallback onPressed;
  final bool enabled;
  final IconData iconData;
  final EdgeInsetsGeometry padding;

  ///
  ///
  ///
  const TableButton({
    required this.label,
    required this.onPressed,
    required this.enabled,
    required this.iconData,
    this.padding = const EdgeInsets.fromLTRB(12, 12, 12, 0),
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
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(12),
            ),
            icon: FaIcon(iconData),
            label: Text(
              label.toUpperCase(),
              overflow: TextOverflow.ellipsis,
            ),
            onPressed: enabled ? onPressed : null,
          ),
        ),
      );
}
