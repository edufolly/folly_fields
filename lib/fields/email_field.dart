import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/validators/email_validator.dart';
import 'package:folly_fields/fields/validator_field.dart';

///
///
///
class EmailField extends ValidatorField {
  ///
  ///
  ///
  EmailField({
    Key? key,
    String validatorMessage = 'Informe o e-mail.',
    String prefix = '',
    String label = '',
    TextEditingController? controller,
    String? Function(String value)? validator,
    List<TextInputFormatter>? inputFormatter,
    TextAlign textAlign = TextAlign.start,
    int? maxLength,
    void Function(String value)? onSaved,
    String? initialValue,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    ValueChanged<String>? onChanged,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    ValueChanged<String>? onFieldSubmitted,
    bool autocorrect = false,
    bool enableSuggestions = true,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    bool filled = false,
    Color? fillColor,
    bool required = true,
    Iterable<String>? autofillHints,
    TextStyle? style,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8.0),
  })  : assert(initialValue == null || controller == null),
        super(
          key: key,
          abstractValidator: EmailValidator(),
          validatorMessage: validatorMessage,
          prefix: prefix,
          label: label,
          controller: controller,
          validator: validator,
          inputFormatter: inputFormatter,
          textAlign: textAlign,
          maxLength: maxLength,
          onSaved:
              onSaved != null ? (String? value) => onSaved(value ?? '') : null,
          initialValue: initialValue,
          enabled: enabled,
          autoValidateMode: autoValidateMode,
          onChanged: onChanged,
          focusNode: focusNode,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          autocorrect: autocorrect,
          enableSuggestions: enableSuggestions,
          textCapitalization: TextCapitalization.none,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          filled: filled,
          fillColor: fillColor,
          required: required,
          autofillHints: autofillHints,
          style: style,
          decoration: decoration,
          padding: padding,
        );
}
