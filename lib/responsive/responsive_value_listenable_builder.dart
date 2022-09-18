import 'package:flutter/widgets.dart';
import 'package:folly_fields/responsive/responsive.dart';

///
///
///
class ResponsiveValueListenableBuilder<T> extends ValueListenableBuilder<T>
    with Responsive {
  @override
  final int? sizeExtraSmall;

  @override
  final int? sizeSmall;

  @override
  final int? sizeMedium;

  @override
  final int? sizeLarge;

  @override
  final int? sizeExtraLarge;

  @override
  final double? minHeight;

  ///
  ///
  ///
  const ResponsiveValueListenableBuilder({
    required super.valueListenable,
    required super.builder,
    super.child,
    this.sizeExtraSmall,
    this.sizeSmall,
    this.sizeMedium,
    this.sizeLarge,
    this.sizeExtraLarge,
    this.minHeight,
    super.key,
  });
}
