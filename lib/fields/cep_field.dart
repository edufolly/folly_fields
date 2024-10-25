import 'package:flutter/material.dart';
import 'package:folly_fields/fields/validator_field.dart';
import 'package:folly_fields/validators/cep_validator.dart';

///
///
///
class CepField extends ValidatorField {
  ///
  ///
  ///
  CepField({
    CepValidator? cepValidator,
    super.validatorMessage = 'Informe o CEP.',
    super.labelPrefix,
    super.label,
    super.labelWidget,
    super.controller,
    super.validator,
    super.inputFormatter,
    super.textAlign,
    super.onSaved,
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
    super.hintText,
    super.contentPadding,
    super.counterText,
    super.prefix,
    super.prefixIcon,
    super.suffix,
    super.suffixIcon,
    super.onTap,
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
          abstractValidator: cepValidator ?? CepValidator(),
          maxLength: 10,
          textCapitalization: TextCapitalization.none,
        );
}
