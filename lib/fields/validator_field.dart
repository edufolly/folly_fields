import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:folly_fields/fields/string_field.dart';

///
///
///
class ValidatorField extends StringField {
  ///
  ///
  ///
  ValidatorField({
    Key key,
    @required AbstractValidator<String> abstractValidator,
    @required String validatorMessage,
    String prefix,
    String label,
    TextEditingController controller,
    FormFieldValidator<String> validator,
    List<TextInputFormatter> inputFormatter,
    TextAlign textAlign = TextAlign.start,
    int maxLength,
    FormFieldSetter<String> onSaved,
    String initialValue,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    ValueChanged<String> onChanged,
    FocusNode focusNode,
    TextInputAction textInputAction,
    ValueChanged<String> onFieldSubmitted,
    bool autocorrect = false,
    bool enableSuggestions = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    bool filled = false,
  }) : super(
          key: key,
          prefix: prefix,
          label: label,
          controller: controller,
          keyboard: abstractValidator.keyboard ?? TextInputType.text,
          validator: (String value) => !abstractValidator.isValid(value)
              ? validatorMessage
              : validator != null
                  ? validator(value)
                  : null,
          minLines: 1,
          maxLines: 1,
          obscureText: false,
          inputFormatter: abstractValidator.mask != null
              ? <TextInputFormatter>[
                  abstractValidator.mask,
                  ...inputFormatter ?? <TextInputFormatter>[]
                ]
              : inputFormatter,
          textAlign: textAlign,
          maxLength: maxLength,
          onSaved: (String value) {
            if (onSaved != null) {
              if (abstractValidator.strip != null) {
                value = abstractValidator.strip(value);
              }
              onSaved(value);
            }
          },
          initialValue: initialValue != null
              ? abstractValidator.format(initialValue)
              : null,
          enabled: enabled,
          autoValidateMode: autoValidateMode,
          onChanged: onChanged,
          focusNode: focusNode,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          autocorrect: autocorrect,
          enableSuggestions: enableSuggestions,
          textCapitalization: textCapitalization,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          filled: filled,
        );
}
