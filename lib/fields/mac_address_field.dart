import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/fields/validator_field.dart';
import 'package:folly_fields/validators/mac_address_validator.dart';

///
///
///
class MacAddressField extends ValidatorField {
  ///
  ///
  ///
  MacAddressField({
    super.validatorMessage = 'Informe o MAC Address.',
    super.labelPrefix,
    super.label,
    super.labelWidget,
    super.controller,
    super.validator,
    super.inputFormatter,
    super.textAlign,
    void Function(String value)? onSaved,
    super.initialValue,
    super.enabled,
    super.autoValidateMode,
    super.onChanged,
    super.focusNode,
    super.textInputAction,
    super.onFieldSubmitted,
    super.autocorrect,
    super.enableSuggestions = true,
    super.scrollPadding,
    super.enableInteractiveSelection,
    super.filled,
    super.fillColor,
    super.required,
    super.autofillHints,
    super.style,
    super.decoration,
    super.padding,
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  })  : assert(
          initialValue == null || controller == null,
          'initialValue or controller must be null.',
        ),
        assert(
          label == null || labelWidget == null,
          'label or labelWidget must be null.',
        ),
        super(
          abstractValidator: MacAddressValidator(),
          maxLength: 17,
          onSaved:
              onSaved != null ? (String? value) => onSaved(value ?? '') : null,
          textCapitalization: TextCapitalization.characters,
        );
}
