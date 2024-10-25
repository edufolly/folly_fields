import 'package:flutter/widgets.dart';

import 'package:folly_fields/responsive/responsive.dart';

///
///
///
abstract class ResponsiveFormField<T> extends FormField<T> with Responsive {
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
  const ResponsiveFormField({
    required super.builder,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.enabled = true,
    super.autovalidateMode,
    super.restorationId,
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
