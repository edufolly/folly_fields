import 'package:flutter/services.dart';
import 'package:folly_fields/fields/string_field.dart';

///
///
///
class UppercaseField extends StringField {
  ///
  ///
  ///
  UppercaseField({
    super.labelPrefix,
    super.label,
    super.labelWidget,
    super.controller,
    super.keyboard,
    super.validator,
    super.minLines,
    super.maxLines,
    super.obscureText,
    List<TextInputFormatter>? inputFormatter,
    super.textAlign,
    super.maxLength,
    super.onSaved,
    super.initialValue,
    super.enabled,
    super.autoValidateMode,
    super.onChanged,
    super.focusNode,
    super.textInputAction,
    super.onFieldSubmitted,
    super.autocorrect,
    super.enableSuggestions,
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
    super.trimOnSaved,
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
          inputFormatter: <TextInputFormatter>[
            TextInputFormatter.withFunction(
              (
                TextEditingValue oldValue,
                TextEditingValue newValue,
              ) =>
                  newValue.copyWith(text: newValue.text.toUpperCase()),
            ),
            ...inputFormatter ?? <TextInputFormatter>[],
          ],
        );
}
