import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/responsive/responsive.dart';

///
///
///
class PasswordVisibleField extends StatefulResponsive {
  final String labelPrefix;
  final String? label;
  final Widget? labelWidget;
  final TextEditingController? controller;
  final String? Function(String value)? validator;
  final List<TextInputFormatter>? inputFormatter;
  final TextAlign textAlign;
  final int? maxLength;
  final void Function(String? value)? onSaved;
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
  final TextStyle? style;
  final InputDecoration? decoration;
  final EdgeInsets padding;
  final bool startObscured;

  ///
  ///
  ///
  const PasswordVisibleField({
    this.labelPrefix = '',
    this.label,
    this.labelWidget,
    this.controller,
    this.validator,
    this.inputFormatter,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.onSaved,
    this.enabled = true,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autocorrect = false,
    this.enableSuggestions = false,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20),
    this.enableInteractiveSelection = true,
    this.filled = false,
    this.fillColor,
    this.autofillHints,
    this.style,
    this.decoration,
    this.padding = const EdgeInsets.all(8),
    this.startObscured = true,
    super.sizeExtraSmall,
    super.sizeSmall,
    super.sizeMedium,
    super.sizeLarge,
    super.sizeExtraLarge,
    super.minHeight,
    super.key,
  }) : assert(
          label == null || labelWidget == null,
          'label or labelWidget must be null.',
        );

  ///
  ///
  ///
  @override
  _PasswordToggleFieldState createState() => _PasswordToggleFieldState();
}

///
///
///
class _PasswordToggleFieldState extends State<PasswordVisibleField> {
  final ValueNotifier<bool?> obscuredNotifier = ValueNotifier<bool?>(null);

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    obscuredNotifier.value = widget.startObscured;
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    TextStyle effectiveStyle =
        widget.style ?? Theme.of(context).textTheme.subtitle1!;

    if (!widget.enabled) {
      effectiveStyle = effectiveStyle.copyWith(
        color: Theme.of(context).disabledColor,
      );
    }

    return ValueListenableBuilder<bool?>(
      valueListenable: obscuredNotifier,
      builder: (BuildContext context, bool? value, _) {
        InputDecoration effectiveDecoration = (widget.decoration ??
                InputDecoration(
                  label: widget.labelWidget,
                  labelText: widget.label == null
                      ? null
                      : widget.labelPrefix.isEmpty
                          ? widget.label
                          : '${widget.labelPrefix} - ${widget.label}',
                  border: const OutlineInputBorder(),
                  counterText: '',
                  enabled: widget.enabled,
                  filled: widget.filled,
                  fillColor: widget.fillColor,
                  suffixIcon: IconButton(
                    icon: Icon(
                      value ?? true ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => obscuredNotifier.value =
                        !(obscuredNotifier.value ?? true),
                  ),
                ))
            .applyDefaults(Theme.of(context).inputDecorationTheme);

        return Padding(
          padding: widget.padding,
          child: TextFormField(
            controller: widget.controller,
            keyboardType: TextInputType.visiblePassword,
            decoration: effectiveDecoration,
            validator: widget.enabled && widget.validator != null
                ? (String? value) => widget.validator!(value ?? '')
                : (_) => null,
            obscureText: value ?? true,
            inputFormatters: widget.inputFormatter,
            textAlign: widget.textAlign,
            maxLength: widget.maxLength,
            onSaved: widget.enabled && widget.onSaved != null
                ? widget.onSaved
                : null,
            enabled: widget.enabled,
            autovalidateMode: widget.autoValidateMode,
            onChanged: widget.onChanged,
            focusNode: widget.focusNode,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted,
            autocorrect: widget.autocorrect,
            enableSuggestions: widget.enableSuggestions,
            textCapitalization: widget.textCapitalization,
            scrollPadding: widget.scrollPadding,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            autofillHints: widget.autofillHints,
            style: effectiveStyle,
          ),
        );
      },
    );
  }

  ///
  ///
  ///
  @override
  void dispose() {
    obscuredNotifier.dispose();
    super.dispose();
  }
}
