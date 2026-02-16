import 'package:flutter/widgets.dart';
import 'package:folly_fields/responsive/responsive.dart';

class ResponsiveBuilder extends StatelessWidget {
  final List<double> responsiveSizes;
  final Widget Function(BuildContext context, ResponsiveSize responsiveSize)
  builder;

  const ResponsiveBuilder({
    required this.builder,
    required this.responsiveSizes,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      builder(context, _checkResponsiveSize(context));

  ResponsiveSize _checkResponsiveSize(final BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width < responsiveSizes[0]) {
      return ResponsiveSize.extraSmall;
    }

    if (width >= responsiveSizes[0] && width < responsiveSizes[1]) {
      return ResponsiveSize.small;
    }

    if (width >= responsiveSizes[1] && width < responsiveSizes[2]) {
      return ResponsiveSize.medium;
    }

    if (width >= responsiveSizes[2] && width < responsiveSizes[3]) {
      return ResponsiveSize.large;
    }

    return ResponsiveSize.extraLarge;
  }
}
