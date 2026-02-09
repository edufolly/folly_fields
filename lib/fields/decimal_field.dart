import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/decimal_editing_controller.dart';
import 'package:folly_fields/fields/base_stateful_field.dart';

import 'package:folly_fields/util/decimal.dart';

class DecimalField
    extends BaseStatefulField<Decimal, DecimalEditingController> {
  final String decimalSeparator;
  final String thousandSeparator;

  const DecimalField({
    required final Decimal initialValue,
    this.decimalSeparator = ',',
    this.thousandSeparator = '.',
    super.labelPrefix,
    super.label,
    super.labelWidget,
    super.controller,
    super.validator,
    super.textAlign = TextAlign.end,
    super.onSaved,
    // super.initialValue,
    super.enabled = true,
    super.autoValidateMode = AutovalidateMode.disabled,
    super.focusNode,
    super.textInputAction,
    super.onFieldSubmitted,
    super.scrollPadding = const EdgeInsets.all(20),
    super.enableInteractiveSelection = true,
    super.readOnly = false,
    super.style,
    super.decoration,
    super.padding = const EdgeInsets.all(8),
    super.hintText,
    super.contentPadding,
    super.counterText,
    super.prefix,
    super.prefixIcon,
    super.suffix,
    super.suffixIcon,
    super.onTap,
    super.lostFocus,
    super.required = true,
    super.clearOnCancel = true,
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  }) : super(initialValue: initialValue);

  @override
  DecimalEditingController createController() => DecimalEditingController(
    initialValue!,
    decimalSeparator: decimalSeparator,
    thousandSeparator: thousandSeparator,
  );
}
