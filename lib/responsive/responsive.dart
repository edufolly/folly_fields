import 'package:flutter/widgets.dart';

mixin Responsive on Widget {
  int? get sizeExtraSmall;

  int get safeSizeExtraSmall => sizeExtraSmall ?? safeSizeSmall;

  int? get sizeSmall;

  int get safeSizeSmall => sizeSmall ?? safeSizeMedium;

  int? get sizeMedium;

  int get safeSizeMedium => sizeMedium ?? 12;

  int? get sizeLarge;

  int get safeSizeLarge => sizeLarge ?? safeSizeMedium;

  int? get sizeExtraLarge;

  int get safeSizeExtraLarge => sizeExtraLarge ?? safeSizeLarge;

  double? get minHeight;

  double get safeMinHeight => minHeight ?? -1;

  int responsiveSize(final ResponsiveSize size) => switch (size) {
    ResponsiveSize.extraSmall => safeSizeExtraSmall,
    ResponsiveSize.small => safeSizeSmall,
    ResponsiveSize.medium => safeSizeMedium,
    ResponsiveSize.large => safeSizeLarge,
    ResponsiveSize.extraLarge => safeSizeExtraLarge,
  };
}

enum ResponsiveSize {
  extraSmall(1),
  small(2),
  medium(3),
  large(4),
  extraLarge(5);

  final int value;

  const ResponsiveSize(this.value);

  bool operator >(final ResponsiveSize other) => value > other.value;

  bool operator >=(final ResponsiveSize other) => value >= other.value;

  bool operator <(final ResponsiveSize other) => value < other.value;

  bool operator <=(final ResponsiveSize other) => value <= other.value;

  bool equals(final ResponsiveSize other) => value == other.value;
}

abstract class ResponsiveStateless extends StatelessWidget with Responsive {
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

  const ResponsiveStateless({
    this.sizeExtraSmall,
    this.sizeSmall,
    this.sizeMedium,
    this.sizeLarge,
    this.sizeExtraLarge,
    this.minHeight,
    super.key,
  }) : assert(
         sizeExtraSmall == null || sizeExtraSmall > 0,
         'sizeExtraSmall must be greater than zero.',
       ),
       assert(
         sizeSmall == null || sizeSmall > 0,
         'sizeSmall must be greater than zero.',
       ),
       assert(
         sizeMedium == null || sizeMedium > 0,
         'sizeMedium must be greater than zero.',
       ),
       assert(
         sizeLarge == null || sizeLarge > 0,
         'sizeLarge must be greater than zero.',
       ),
       assert(
         sizeExtraLarge == null || sizeExtraLarge > 0,
         'sizeExtraLarge must be greater than zero.',
       ),
       assert(
         minHeight == null || minHeight >= 0,
         'minHeight must be equal or greater than zero.',
       );
}

abstract class ResponsiveStateful extends StatefulWidget with Responsive {
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

  const ResponsiveStateful({
    this.sizeExtraSmall,
    this.sizeSmall,
    this.sizeMedium,
    this.sizeLarge,
    this.sizeExtraLarge,
    this.minHeight,
    super.key,
  }) : assert(
         sizeExtraSmall == null || sizeExtraSmall > 0,
         'sizeExtraSmall must be greater than zero.',
       ),
       assert(
         sizeSmall == null || sizeSmall > 0,
         'sizeSmall must be greater than zero.',
       ),
       assert(
         sizeMedium == null || sizeMedium > 0,
         'sizeMedium must be greater than zero.',
       ),
       assert(
         sizeLarge == null || sizeLarge > 0,
         'sizeLarge must be greater than zero.',
       ),
       assert(
         sizeExtraLarge == null || sizeExtraLarge > 0,
         'sizeExtraLarge must be greater than zero.',
       ),
       assert(
         minHeight == null || minHeight >= 0,
         'minHeight must be equal or greater than zero.',
       );
}
