// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive_form_field.dart';

///
///
///
class BoolField extends ResponsiveFormField<bool> {
  final ValueNotifier<bool>? controller;
  final Function(bool value)? onChanged;

  ///
  ///
  ///
  BoolField({
    String? labelPrefix,
    String? label,
    Widget? labelWidget,
    this.controller,
    String? Function(bool value)? validator,
    void Function(bool value)? onSaved,
    bool? initialValue,
    super.enabled,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    this.onChanged,
    bool filled = false,
    Color? fillColor,
    bool adaptive = false,
    Color? activeColor,
    InputDecoration? decoration,
    EdgeInsets padding = const EdgeInsets.all(8),
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? hintText,
    EdgeInsets? contentPadding,
    TextOverflow textOverflow = TextOverflow.ellipsis,
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
        ),
        super(
          initialValue: controller != null ? controller.value : initialValue,
          validator: enabled && validator != null
              ? (bool? value) => validator(value ?? false)
              : (_) => null,
          onSaved: enabled && onSaved != null
              ? (bool? value) => onSaved(value ?? false)
              : null,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<bool> field) {
            _BoolFieldState state = field as _BoolFieldState;

            InputDecoration effectiveDecoration = (decoration ??
                    InputDecoration(
                      border: const OutlineInputBorder(),
                      filled: filled,
                      fillColor: fillColor,
                      counterText: '',
                      enabled: enabled,
                      contentPadding: contentPadding ??
                          const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 8,
                          ),
                      prefixIcon: prefixIcon,
                      suffixIcon: suffixIcon,
                      hintText: hintText,
                    ))
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            Color? textColor =
                Theme.of(field.context).textTheme.titleMedium?.color;

            TextStyle textStyle =
                Theme.of(field.context).textTheme.titleMedium!.copyWith(
                      color: textColor?.withOpacity(enabled ? 1 : 0.4),
                      overflow: textOverflow,
                    );

            return Padding(
              padding: padding,
              child: Builder(
                builder: (BuildContext context) {
                  return InkWell(
                    canRequestFocus: false,
                    onTap: enabled
                        ? () => state.didChange(!(state.value ?? false))
                        : null,
                    child: InputDecorator(
                      decoration: effectiveDecoration.copyWith(
                        errorText: enabled ? field.errorText : null,
                        enabled: enabled,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: label == null
                                  ? labelWidget
                                  : Text(
                                      labelPrefix?.isEmpty ?? true
                                          ? label
                                          : '$labelPrefix - $label',
                                      style: textStyle,
                                    ),
                            ),
                          ),
                          if (adaptive)
                            Switch.adaptive(
                              value: state._effectiveController.value,
                              onChanged: enabled ? state.didChange : null,
                              activeColor: activeColor,
                            )
                          else
                            Switch(
                              value: state._effectiveController.value,
                              onChanged: enabled ? state.didChange : null,
                              activeColor: activeColor,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );

  ///
  ///
  ///
  @override
  FormFieldState<bool> createState() => _BoolFieldState();
}

///
///
///
class _BoolFieldState extends FormFieldState<bool> {
  ValueNotifier<bool>? _controller;

  ///
  ///
  ///
  @override
  BoolField get widget => super.widget as BoolField;

  ///
  ///
  ///
  ValueNotifier<bool> get _effectiveController =>
      widget.controller ?? _controller!;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = ValueNotifier<bool>(widget.initialValue ?? false);
    } else {
      widget.controller?.addListener(_handleControllerChanged);
    }
  }

  ///
  ///
  ///
  @override
  void didUpdateWidget(BoolField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);

      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = ValueNotifier<bool>(oldWidget.controller!.value);
      }

      if (widget.controller != null) {
        setValue(widget.controller!.value);

        if (oldWidget.controller == null) {
          _controller = null;
        }
      }
    }
  }

  ///
  ///
  ///
  @override
  void didChange(bool? value) {
    super.didChange(value);
    if (_effectiveController.value != value) {
      _effectiveController.value = value ?? false;
      widget.onChanged?.call(value ?? false);
    }
  }

  ///
  ///
  ///
  @override
  void reset() {
    super.reset();
    setState(() => _effectiveController.value = widget.initialValue ?? false);
  }

  ///
  ///
  ///
  void _handleControllerChanged() {
    if (_effectiveController.value != value) {
      didChange(_effectiveController.value);
    }
  }

  ///
  ///
  ///
  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }
}
