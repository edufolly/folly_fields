import 'package:flutter/widgets.dart';
import 'package:folly_fields/responsive/responsive.dart';

@Deprecated('Should I remove?')
class ResponsiveFutureBuilder<T> extends FutureBuilder<T> with Responsive {
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

  const ResponsiveFutureBuilder({
    required super.builder,
    super.future,
    super.initialData,
    this.sizeExtraSmall,
    this.sizeSmall,
    this.sizeMedium,
    this.sizeLarge,
    this.sizeExtraLarge,
    this.minHeight,
    super.key,
  });
}
