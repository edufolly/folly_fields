import 'package:flutter/widgets.dart';
import 'package:folly_fields/responsive/responsive.dart';

class ResponsiveStreamBuilder<T> extends StreamBuilder<T> with Responsive {
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

  const ResponsiveStreamBuilder({
    required super.builder,
    super.initialData,
    super.stream,
    this.sizeExtraSmall,
    this.sizeSmall,
    this.sizeMedium,
    this.sizeLarge,
    this.sizeExtraLarge,
    this.minHeight,
    super.key,
  });
}
