import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/fields/string_field.dart';

///
///
///
class IntegerField extends StringField {
  ///
  ///
  ///
  IntegerField({
    Key key,
    String prefix,
    String label,
    TextEditingController controller,
    FormFieldValidator<int> validator,
    TextAlign textAlign = TextAlign.end,
    int maxLength,
    FormFieldSetter<int> onSaved,
    int initialValue,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    ValueChanged<String> onChanged,
    FocusNode focusNode,
    TextInputAction textInputAction,
    ValueChanged<String> onFieldSubmitted,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    bool filled = false,
  }) : super(
          key: key,
          prefix: prefix,
          label: label,
          controller: controller,
          keyboard: TextInputType.number,
          validator: (String value) {
            int integer = int.tryParse(value);
            if (validator != null) {
              return validator(integer);
            }
            return null;
          },
          minLines: 1,
          maxLines: 1,
          obscureText: false,
          inputFormatter: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          textAlign: textAlign,
          maxLength: maxLength,
          onSaved: (String value) {
            int integer = int.tryParse(value);
            if (onSaved != null) {
              return onSaved(integer);
            }
          },
          initialValue: initialValue == null ? null : initialValue.toString(),
          enabled: enabled,
          autoValidateMode: autoValidateMode,
          onChanged: onChanged,
          focusNode: focusNode,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          autocorrect: false,
          enableSuggestions: false,
          textCapitalization: TextCapitalization.none,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          filled: filled,
        );
}
