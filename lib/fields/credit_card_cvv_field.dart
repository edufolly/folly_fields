import 'dart:math';

import 'package:flutter/services.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/util/credit_card_type.dart';
import 'package:sprintf/sprintf.dart';

///
///
///
class CreditCardCodeField extends StringField {
  ///
  ///
  ///
  CreditCardCodeField({
    required CreditCardType creditCardType,
    String validatorMessage = 'Informe o %s.',
    super.labelPrefix,
    String? label,
    super.controller,
    String? Function(String value)? validator,
    super.textAlign,
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
    super.style,
    super.decoration,
    super.padding,
    super.prefixIcon,
    super.suffixIcon,
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
        super(
          keyboard: TextInputType.number,
          label: label ?? creditCardType.code.name,
          validator: enabled
              ? (String? value) {
                  if (!required && (value == null || value.isEmpty)) {
                    return null;
                  }

                  if (value == null || !creditCardType.cvvCheck(value)) {
                    return sprintf(
                      validatorMessage,
                      <dynamic>[label ?? creditCardType.code.name],
                    );
                  }

                  if (validator != null) {
                    return validator(value);
                  }

                  return null;
                }
              : null,
          minLines: 1,
          maxLines: 1,
          maxLength: creditCardType.code.size.fold<int>(0, max),
          hintText: List<String>.generate(
            creditCardType.code.size.fold<int>(0, max),
            (_) => 'X',
          ).join(),
          obscureText: false,
          inputFormatter: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          onSaved: enabled
              ? (String? value) {
                  if (onSaved != null) {
                    if (!required && value != null && value.isEmpty) {
                      value = null;
                    }

                    onSaved(value);
                  }
                }
              : null,
        );
}
