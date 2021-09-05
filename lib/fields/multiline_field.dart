import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/fields/string_field.dart';

///
///
///
class MultilineField extends StringField {
  ///
  ///
  ///
  const MultilineField({
    Key? key,
    String prefix = '',
    String label = '',
    TextEditingController? controller,
    String? Function(String value)? validator,
    int minLines = 2,
    int maxLines = 999,
    int? maxLength,
    List<TextInputFormatter>? inputFormatter,
    TextAlign textAlign = TextAlign.start,
    void Function(String value)? onSaved,
    String? initialValue,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    ValueChanged<String>? onChanged,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    ValueChanged<String>? onFieldSubmitted,
    bool autocorrect = false,
    bool enableSuggestions = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    bool filled = false,
    Color? fillColor,
    Iterable<String>? autofillHints,
    bool readOnly = false,
    TextStyle? style,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8.0),
  })  : assert(initialValue == null || controller == null),
        super(
          key: key,
          prefix: prefix,
          label: label,
          controller: controller,
          keyboard: TextInputType.multiline,
          validator: validator,
          minLines: minLines,
          maxLines: maxLines,
          obscureText: false,
          inputFormatter: inputFormatter,
          textAlign: textAlign,
          maxLength: maxLength,
          onSaved: onSaved,
          initialValue: initialValue,
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
          fillColor: fillColor,
          autofillHints: autofillHints,
          readOnly: readOnly,
          style: style,
          decoration: decoration,
          padding: padding,
        );
}
