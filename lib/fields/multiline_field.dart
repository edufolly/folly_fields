import 'package:flutter/material.dart';
import 'package:folly_fields/fields/string_field.dart';

///
///
///
class MultilineField extends StringField {
  ///
  ///
  ///
  const MultilineField({
    super.labelPrefix,
    super.label,
    super.labelWidget,
    super.controller,
    super.validator,
    super.minLines = 2,
    super.maxLines = 999,
    super.maxLength,
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
    super.autocorrect = false,
    super.enableSuggestions = false,
    super.textCapitalization,
    super.scrollPadding,
    super.enableInteractiveSelection,
    super.filled,
    super.fillColor,
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
          keyboard: TextInputType.multiline,
          obscureText: false,
        );
}
