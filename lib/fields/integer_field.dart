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
    String prefix = '',
    String label = '',
    IntegerEditingController? controller,
    FormFieldValidator<int?>? validator,
    TextAlign textAlign = TextAlign.end,
    int? maxLength,
    FormFieldSetter<int>? onSaved,
    int? initialValue,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    ValueChanged<String>? onChanged,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    ValueChanged<String>? onFieldSubmitted,
    EdgeInsets scrollPadding = const EdgeInsets.all(20),
    bool enableInteractiveSelection = true,
    bool filled = false,
    Color? fillColor,
    Iterable<String>? autofillHints,
    bool readOnly = false,
    TextStyle? style,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8),
    int? sizeExtraSmall,
    int? sizeSmall,
    int? sizeMedium,
    int? sizeLarge,
    int? sizeExtraLarge,
    double? minHeight,
    Key? key,
  })  : assert(initialValue == null || controller == null,
            'initialValue or controller must be null.'),
        super(
          prefix: prefix,
          label: label,
          controller: controller,
          keyboard: TextInputType.number,
          validator: (String? value) {
            if (enabled && validator != null) {
              return validator(int.tryParse(value ?? ''));
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
          onSaved: (String? value) {
            if (enabled && onSaved != null) {
              return onSaved(int.tryParse(value ?? ''));
            }
          },
          initialValue: initialValue?.toString(),
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
          fillColor: fillColor,
          autofillHints: autofillHints,
          readOnly: readOnly,
          style: style,
          decoration: decoration,
          padding: padding,
          sizeExtraSmall: sizeExtraSmall,
          sizeSmall: sizeSmall,
          sizeMedium: sizeMedium,
          sizeLarge: sizeLarge,
          sizeExtraLarge: sizeExtraLarge,
          minHeight: minHeight,
          key: key,
        );
}

///
///
///
class IntegerEditingController extends TextEditingController {
  ///
  ///
  ///
  int? get integer => int.tryParse(text);

  ///
  ///
  ///
  set integer(int? integer) => text = integer.toString();
}
