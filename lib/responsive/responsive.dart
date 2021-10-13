import 'package:flutter/widgets.dart';

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
  int responsiveSize(ResponsiveSize size) {
    switch (size) {
      case ResponsiveSize.extraSmall:
        return safeSizeExtraSmall;
      case ResponsiveSize.small:
        return safeSizeSmall;
      case ResponsiveSize.medium:
        return safeSizeMedium;
      case ResponsiveSize.large:
        return safeSizeLarge;
      case ResponsiveSize.extraLarge:
        return safeSizeExtraLarge;
    }
  }
}

///
///
///
abstract class StatelessResponsive extends StatelessWidget with Responsive {
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
  const StatelessResponsive({
    this.sizeExtraSmall,
    this.sizeSmall,
    this.sizeMedium,
    this.sizeLarge,
    this.sizeExtraLarge,
    this.minHeight,
    Key? key,
  })  : assert(
            sizeExtraSmall == null ||
                (sizeExtraSmall >= 1 && sizeExtraSmall <= 12),
            'sizeExtraSmall must be between 1 and 12.'),
        assert(sizeSmall == null || (sizeSmall >= 1 && sizeSmall <= 12),
            'sizeSmall must be between 1 and 12.'),
        assert(sizeMedium == null || (sizeMedium >= 1 && sizeMedium <= 12),
            'sizeMedium must be between 1 and 12.'),
        assert(sizeLarge == null || (sizeLarge >= 1 && sizeLarge <= 12),
            'sizeLarge must be between 1 and 12.'),
        assert(
            sizeExtraLarge == null ||
                (sizeExtraLarge >= 1 && sizeExtraLarge <= 12),
            'sizeExtraLarge must be between 1 and 12.'),
        assert(minHeight == null || minHeight >= 0,
            'minHeight must be equal or greater than zero.'),
        super(key: key);
}

///
///
///
abstract class StatefulResponsive extends StatefulWidget with Responsive {
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
  const StatefulResponsive({
    this.sizeExtraSmall,
    this.sizeSmall,
    this.sizeMedium,
    this.sizeLarge,
    this.sizeExtraLarge,
    this.minHeight,
    Key? key,
  })  : assert(
            sizeExtraSmall == null ||
                (sizeExtraSmall >= 1 && sizeExtraSmall <= 12),
            'sizeExtraSmall must be between 1 and 12.'),
        assert(sizeSmall == null || (sizeSmall >= 1 && sizeSmall <= 12),
            'sizeSmall must be between 1 and 12.'),
        assert(sizeMedium == null || (sizeMedium >= 1 && sizeMedium <= 12),
            'sizeMedium must be between 1 and 12.'),
        assert(sizeLarge == null || (sizeLarge >= 1 && sizeLarge <= 12),
            'sizeLarge must be between 1 and 12.'),
        assert(
            sizeExtraLarge == null ||
                (sizeExtraLarge >= 1 && sizeExtraLarge <= 12),
            'sizeExtraLarge must be between 1 and 12.'),
        assert(minHeight == null || minHeight >= 0,
            'minHeight must be equal or greater than zero.'),
        super(key: key);
}

///
///
///
abstract class FormFieldResponsive<T> extends FormField<T> with Responsive {
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
  const FormFieldResponsive({
    required FormFieldBuilder<T> builder,
    FormFieldSetter<T>? onSaved,
    FormFieldValidator<T>? validator,
    T? initialValue,
    bool enabled = true,
    AutovalidateMode? autovalidateMode,
    String? restorationId,
    this.sizeExtraSmall,
    this.sizeSmall,
    this.sizeMedium,
    this.sizeLarge,
    this.sizeExtraLarge,
    this.minHeight,
    Key? key,
  })  : assert(
            sizeExtraSmall == null ||
                (sizeExtraSmall >= 1 && sizeExtraSmall <= 12),
            'sizeExtraSmall must be between 1 and 12.'),
        assert(sizeSmall == null || (sizeSmall >= 1 && sizeSmall <= 12),
            'sizeSmall must be between 1 and 12.'),
        assert(sizeMedium == null || (sizeMedium >= 1 && sizeMedium <= 12),
            'sizeMedium must be between 1 and 12.'),
        assert(sizeLarge == null || (sizeLarge >= 1 && sizeLarge <= 12),
            'sizeLarge must be between 1 and 12.'),
        assert(
            sizeExtraLarge == null ||
                (sizeExtraLarge >= 1 && sizeExtraLarge <= 12),
            'sizeExtraLarge must be between 1 and 12.'),
        assert(minHeight == null || minHeight >= 0,
            'minHeight must be equal or greater than zero.'),
        super(
          builder: builder,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          enabled: enabled,
          autovalidateMode: autovalidateMode,
          restorationId: restorationId,
          key: key,
        );
}
