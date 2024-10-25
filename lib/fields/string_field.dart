import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/responsive/responsive.dart';

///
///
///
class StringField extends ResponsiveStateless {
  final String? labelPrefix;
  final String? label;
  final Widget? labelWidget;
  final TextEditingController? controller;
  final TextInputType keyboard;
  final String? Function(String? value)? validator;
  final int minLines;
  final int maxLines;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatter;
  final TextAlign textAlign;
  final int? maxLength;
  final void Function(String? value)? onSaved;
  final String? initialValue;
  final bool enabled;
  final AutovalidateMode autoValidateMode;
  final ValueChanged<String?>? onChanged;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String?>? onFieldSubmitted;
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
  final String? hintText;
  final EdgeInsets? contentPadding;
  final String? counterText;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final bool trimOnSaved;
  final void Function()? onTap;

  ///
  ///
  ///
  const StringField({
    this.labelPrefix,
    this.label,
    this.labelWidget,
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
    this.scrollPadding = const EdgeInsets.all(20),
    this.enableInteractiveSelection = true,
    this.filled = false,
    this.fillColor,
    this.autofillHints,
    this.readOnly = false,
    this.style,
    this.decoration,
    this.padding = const EdgeInsets.all(8),
    this.hintText,
    this.contentPadding,
    this.counterText = '',
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.trimOnSaved = true,
    this.onTap,
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
        );

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    TextStyle effectiveStyle =
        style ?? Theme.of(context).textTheme.titleMedium!;

    if (!enabled || readOnly) {
      effectiveStyle = effectiveStyle.copyWith(
        color: Theme.of(context).disabledColor,
      );
    }

    InputDecoration effectiveDecoration = (decoration ??
            InputDecoration(
              prefix: prefix,
              prefixIcon: prefixIcon,
              suffix: suffix,
              suffixIcon: suffixIcon,
              label: labelWidget,
              labelText: (labelPrefix?.isEmpty ?? true)
                  ? label
                  : '$labelPrefix - $label',
              border: const OutlineInputBorder(),
              counterText: counterText,
              enabled: enabled,
              filled: filled,
              fillColor: fillColor,
              hintText: hintText,
              contentPadding: contentPadding,
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
            : null,
        minLines: minLines,
        maxLines: maxLines,
        obscureText: obscureText,
        inputFormatters: inputFormatter,
        textAlign: textAlign,
        maxLength: maxLength,
        onSaved: enabled && onSaved != null ? _internalSave : null,
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
        onTap: onTap,
        style: effectiveStyle,
      ),
    );
  }

  ///
  ///
  ///
  void _internalSave(String? value) =>
      onSaved?.call(trimOnSaved ? value?.trim() : value);
}
