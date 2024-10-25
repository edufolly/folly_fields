import 'package:flutter/widgets.dart';

///
///
///
mixin Responsive on Widget {
  ///
  ///
  ///
  int? get sizeExtraSmall;

  ///
  ///
  ///
  int get safeSizeExtraSmall => sizeExtraSmall ?? safeSizeSmall;

  ///
  ///
  ///
  int? get sizeSmall;

  ///
  ///
  ///
  int get safeSizeSmall => sizeSmall ?? safeSizeMedium;

  ///
  ///
  ///
  int? get sizeMedium;

  ///
  ///
  ///
  int get safeSizeMedium => sizeMedium ?? 12;

  ///
  ///
  ///
  int? get sizeLarge;

  ///
  ///
  ///
  int get safeSizeLarge => sizeLarge ?? safeSizeMedium;

  ///
  ///
  ///
  int? get sizeExtraLarge;

  ///
  ///
  ///
  int get safeSizeExtraLarge => sizeExtraLarge ?? safeSizeLarge;

  ///
  ///
  ///
  double? get minHeight;

  ///
  ///
  ///
  double get safeMinHeight => minHeight ?? -1;

  ///
  ///
  ///
  int responsiveSize(ResponsiveSize size) => switch (size) {
        ResponsiveSize.extraSmall => safeSizeExtraSmall,
        ResponsiveSize.small => safeSizeSmall,
        ResponsiveSize.medium => safeSizeMedium,
        ResponsiveSize.large => safeSizeLarge,
        ResponsiveSize.extraLarge => safeSizeExtraLarge,
      };
}

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
extension ResponsiveSizeExtension on ResponsiveSize {
  ///
  ///
  ///
  int get value => switch (this) {
        ResponsiveSize.extraSmall => 1,
        ResponsiveSize.small => 2,
        ResponsiveSize.medium => 3,
        ResponsiveSize.large => 4,
        ResponsiveSize.extraLarge => 5
      };

  ///
  ///
  ///
  bool operator >(ResponsiveSize other) => value > other.value;

  ///
  ///
  ///
  bool operator >=(ResponsiveSize other) => value >= other.value;

  ///
  ///
  ///
  bool operator <(ResponsiveSize other) => value < other.value;

  ///
  ///
  ///
  bool operator <=(ResponsiveSize other) => value <= other.value;

  ///
  ///
  ///
  bool equals(ResponsiveSize other) => value == other.value;
}

///
///
///
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

  ///
  ///
  ///
  const ResponsiveStateless({
    this.sizeExtraSmall,
    this.sizeSmall,
    this.sizeMedium,
    this.sizeLarge,
    this.sizeExtraLarge,
    this.minHeight,
    super.key,
  })  : assert(
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

///
///
///
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

  ///
  ///
  ///
  const ResponsiveStateful({
    this.sizeExtraSmall,
    this.sizeSmall,
    this.sizeMedium,
    this.sizeLarge,
    this.sizeExtraLarge,
    this.minHeight,
    super.key,
  })  : assert(
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
