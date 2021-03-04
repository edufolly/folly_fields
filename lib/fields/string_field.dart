import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
///
///
class StringField extends StatelessWidget {
  final String prefix;
  final String label;
  final TextEditingController? controller;
  final TextInputType keyboard;
  final FormFieldValidator<String>? validator;
  final int minLines;
  final int maxLines;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatter;
  final TextAlign textAlign;
  final int? maxLength;
  final FormFieldSetter<String>? onSaved;
  final String? initialValue;
  final bool enabled;
  final AutovalidateMode autoValidateMode;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final bool autocorrect;
  final bool enableSuggestions;
  final TextCapitalization textCapitalization;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final bool filled;
  final Iterable<String>? autofillHints;

  ///
  ///
  ///
  StringField({
    Key? key,
    this.prefix = '',
    this.label = '',
    this.controller,
    this.keyboard = TextInputType.text,
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
    this.obscureText = false,
    this.inputFormatter,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.onSaved,
    this.initialValue,
    this.enabled = true,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.filled = false,
    this.autofillHints,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: prefix.isEmpty ? label : '$prefix - $label',
          border: OutlineInputBorder(),
          counterText: '',
          enabled: enabled,
          filled: filled,
        ),
        validator: enabled ? validator : (_) => null,
        minLines: minLines,
        maxLines: maxLines,
        obscureText: obscureText,
        inputFormatters: inputFormatter,
        textAlign: textAlign,
        maxLength: maxLength,
        onSaved: onSaved,
        initialValue: initialValue,
        enabled: enabled,
        autovalidateMode: autoValidateMode,
        onChanged: onChanged,
        focusNode: focusNode,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        textCapitalization: textCapitalization,
        scrollPadding: scrollPadding,
        enableInteractiveSelection: enableInteractiveSelection,
        autofillHints: autofillHints,
        style: enabled
            ? null
            : Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
      ),
    );
  }
}
