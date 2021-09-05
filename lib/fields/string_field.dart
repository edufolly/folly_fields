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
  final String? Function(String value)? validator;
  final int minLines;
  final int maxLines;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatter;
  final TextAlign textAlign;
  final int? maxLength;
  final void Function(String value)? onSaved;
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
  final Color? fillColor;
  final Iterable<String>? autofillHints;
  final bool readOnly;
  final TextStyle? style;
  final InputDecoration? decoration;
  final EdgeInsets padding;

  ///
  ///
  ///
  const StringField({
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
    this.fillColor,
    this.autofillHints,
    this.readOnly = false,
    this.style,
    this.decoration,
    this.padding = const EdgeInsets.all(8.0),
  })  : assert(initialValue == null || controller == null),
        super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    TextStyle effectiveStyle = style ?? Theme.of(context).textTheme.subtitle1!;

    if (!enabled || readOnly) {
      effectiveStyle = effectiveStyle.copyWith(
        color: Theme.of(context).disabledColor,
      );
    }

    InputDecoration effectiveDecoration = (decoration ??
            InputDecoration(
              labelText: prefix.isEmpty ? label : '$prefix - $label',
              border: const OutlineInputBorder(),
              counterText: '',
              enabled: enabled,
              filled: filled,
              fillColor: fillColor,
            ))
        .applyDefaults(Theme.of(context).inputDecorationTheme);

    return Padding(
      padding: padding,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        decoration: effectiveDecoration,
        validator: enabled && validator != null
            ? (String? value) => validator!(value ?? '')
            : (_) => null,
        minLines: minLines,
        maxLines: maxLines,
        obscureText: obscureText,
        inputFormatters: inputFormatter,
        textAlign: textAlign,
        maxLength: maxLength,
        onSaved: enabled && onSaved != null
            ? (String? value) => onSaved!(value ?? '')
            : null,
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
        autofillHints: readOnly ? null : autofillHints,
        readOnly: readOnly,
        style: effectiveStyle,
      ),
    );
  }
}
