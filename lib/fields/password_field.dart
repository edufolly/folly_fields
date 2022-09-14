import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/fields/string_field.dart';

///
///
///
class PasswordField extends StringField {
  ///
  ///
  ///
  const PasswordField({
    super.labelPrefix,
    super.label,
    super.labelWidget,
    super.controller,
    super.validator,
    super.inputFormatter,
    super.textAlign,
    super.maxLength,
    super.onSaved,
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
  }) : super(
          keyboard: TextInputType.visiblePassword,
          minLines: 1,
          maxLines: 1,
          obscureText: true,
          trimOnSaved: false,
        );
}
