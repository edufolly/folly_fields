import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class ValidatorField extends StringField {
  ValidatorField({
    required final AbstractValidator<String> abstractValidator,
    required final String validatorMessage,
    final bool required = true,
    super.labelPrefix,
    super.label,
    super.labelWidget,
    super.controller,
    final FormFieldValidator<String>? validator,
    super.obscureText,
    final List<TextInputFormatter>? inputFormatter,
    super.textAlign,
    super.maxLength,
    final FormFieldSetter<String>? onSaved,
    final String? initialValue,
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
    super.onTap,
    super.autofillHints,
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  }) : assert(
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
             ? (final String? value) {
                 if (!required && (value == null || value.isEmpty)) {
                   return null;
                 }

                 if (validator != null) {
                   return validator(value);
                 }

                 if (!abstractValidator.isValid(value)) {
                   return validatorMessage;
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

                 onSaved?.call(value);
               }
             : null,
         initialValue: initialValue != null
             ? abstractValidator.format(initialValue)
             : null,
       );
}
