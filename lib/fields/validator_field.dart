import 'package:flutter/services.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class ValidatorField extends StringField {
  ///
  ///
  ///
  ValidatorField({
    required AbstractValidator<String> abstractValidator,
    required String validatorMessage,
    super.labelPrefix,
    super.label,
    super.labelWidget,
    super.controller,
    String? Function(String? value)? validator,
    super.obscureText,
    List<TextInputFormatter>? inputFormatter,
    super.textAlign,
    super.maxLength,
    void Function(String?)? onSaved,
    String? initialValue,
    super.enabled,
    super.autoValidateMode,
    super.onChanged,
    super.focusNode,
    super.textInputAction,
    super.onFieldSubmitted,
    super.autocorrect = false,
    super.enableSuggestions = false,
    super.textCapitalization,
    super.scrollPadding,
    super.enableInteractiveSelection,
    super.filled,
    super.fillColor,
    bool required = true,
    super.autofillHints,
    super.readOnly,
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
    super.trimOnSaved = false,
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
          keyboard: abstractValidator.keyboard,
          validator: enabled
              ? (String? value) {
                  if (!required && (value == null || value.isEmpty)) {
                    return null;
                  }

                  if (value == null || !abstractValidator.isValid(value)) {
                    return validatorMessage;
                  }

                  if (validator != null) {
                    return validator(value);
                  }

                  return null;
                }
              : null,
          minLines: 1,
          maxLines: 1,
          inputFormatter: <TextInputFormatter>[
            ...abstractValidator.inputFormatters ?? <TextInputFormatter>[],
            ...inputFormatter ?? <TextInputFormatter>[],
          ],
          onSaved: enabled
              ? (String? value) {
                  if (value != null) {
                    value = abstractValidator.strip(value);
                  }

                  if (!required && value != null && value.isEmpty) {
                    value = null;
                  }

                  onSaved?.call(value);
                }
              : null,
          initialValue: initialValue != null
              ? abstractValidator.format(initialValue)
              : null,
        );
}
