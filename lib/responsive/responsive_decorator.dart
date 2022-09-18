import 'package:flutter/widgets.dart';
import 'package:folly_fields/responsive/responsive.dart';

///
///
///
class ResponsiveDecorator extends ResponsiveStateless {
  final Widget child;

  ///
  ///
  ///
  const ResponsiveDecorator({
    required this.child,
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
  Widget build(BuildContext context) => child;
}
