import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/responsive/responsive.dart';

class StringField extends ResponsiveStateless {
  final String? labelPrefix;
  final String? label;
  final Widget? labelWidget;
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
  final ValueChanged<String?>? onChanged;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String?>? onFieldSubmitted;
  final bool autocorrect;
  final bool enableSuggestions;
  final TextCapitalization textCapitalization;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
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
  final bool emptyIsNull;
  final VoidCallback? onTap;
  final Iterable<String>? autofillHints;

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
    this.emptyIsNull = true,
    this.onTap,
    this.autofillHints,
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  }) : assert(
         initialValue == null || controller == null,
         'initialValue or controller must be null.',
       ),
       assert(
         label == null || labelWidget == null,
         'label or labelWidget must be null.',
       );

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    TextStyle? effectiveStyle = style ?? theme.textTheme.titleMedium;

    if (!enabled || readOnly) {
      effectiveStyle = effectiveStyle?.copyWith(color: theme.disabledColor);
    }

    InputDecoration effectiveDecoration =
        (decoration ??
                InputDecoration(
                  prefix: prefix,
                  prefixIcon: prefixIcon,
                  suffix: suffix,
                  suffixIcon: suffixIcon,
                  label: labelWidget,
                  labelText: <String?>[labelPrefix, label].nonNulls.join(' - '),
                  border: const OutlineInputBorder(),
                  counterText: counterText,
                  enabled: enabled,
                  hintText: hintText,
                  contentPadding: contentPadding,
                ))
            .applyDefaults(theme.inputDecorationTheme);

    return Padding(
      padding: padding,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        decoration: effectiveDecoration,
        validator: enabled && isNotNull(validator) ? _internalValidator : null,
        minLines: minLines,
        maxLines: maxLines,
        obscureText: obscureText,
        inputFormatters: inputFormatter,
        textAlign: textAlign,
        maxLength: maxLength,
        onSaved: enabled && isNotNull(onSaved) ? _internalOnSave : null,
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
        readOnly: readOnly,
        onTap: onTap,
        autofillHints: autofillHints,
        style: effectiveStyle,
      ),
    );
  }

  String? _realValue(final String value) {
    if (emptyIsNull && value.isEmpty) return null;

    if (trimOnSaved) return value.trim();

    return value;
  }

  String? _internalValidator(final String? value) =>
      validator?.call(value?.let(_realValue));

  void _internalOnSave(final String? value) =>
      onSaved?.call(value?.let(_realValue));
}
