import 'dart:math';

import 'package:flutter/services.dart';
import 'package:folly_fields/extensions/string_extension.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/util/credit_card_type.dart';
import 'package:sprintf/sprintf.dart';

class CreditCardCodeField extends StringField {
  CreditCardCodeField({
    required CreditCardType creditCardType,
    String validatorMessage = 'Informe o %s.',
    super.labelPrefix,
    String? label,
    super.controller,
    String? Function(String? value)? validator,
    super.textAlign,
    void Function(String? value)? onSaved,
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
    bool required = true,
    super.style,
    super.decoration,
    super.padding,
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
       super(
         keyboard: TextInputType.number,
         label: label ?? creditCardType.code.name,
         validator: enabled
             ? (String? value) {
                 if (!required && (value == null || value.isEmpty)) {
                   return null;
                 }

                 if (value == null || !creditCardType.cvvCheck(value)) {
                   return sprintf(validatorMessage, <dynamic>[
                     label ?? creditCardType.code.name,
                   ]);
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
             ? (String? value) => onSaved?.call(
                 !required && isNullOrBlank(value) ? null : value,
               )
             : null,
       );
}
