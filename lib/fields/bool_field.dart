// To force override parameter.
// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive_form_field.dart';

class BoolField extends ResponsiveFormField<bool> {
  final ValueNotifier<bool>? controller;
  final Function(bool value)? onChanged;

  BoolField({
    final String? labelPrefix,
    final String? label,
    final Widget? labelWidget,
    this.controller,
    final String? Function(bool value)? validator,
    final void Function(bool value)? onSaved,
    final bool? initialValue,
    super.enabled,
    final AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    this.onChanged,
    final bool filled = false,
    final Color? fillColor,
    final bool adaptive = false,
    final Color? activeColor,
    final InputDecoration? decoration,
    final EdgeInsets padding = const EdgeInsets.all(8),
    final Widget? prefixIcon,
    final Widget? suffixIcon,
    final String? hintText,
    final EdgeInsets? contentPadding,
    final TextOverflow textOverflow = TextOverflow.ellipsis,
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
       ),
       super(
         initialValue: controller != null ? controller.value : initialValue,
         validator: enabled && validator != null
             ? (final bool? value) => validator(value ?? false)
             : null,
         onSaved: enabled && onSaved != null
             ? (final bool? value) => onSaved(value ?? false)
             : null,
         autovalidateMode: autoValidateMode,
         builder: (final FormFieldState<bool> field) {
           _BoolFieldState state = field as _BoolFieldState;

           InputDecoration effectiveDecoration =
               (decoration ??
                       InputDecoration(
                         border: const OutlineInputBorder(),
                         filled: filled,
                         fillColor: fillColor,
                         counterText: '',
                         enabled: enabled,
                         contentPadding:
                             contentPadding ??
                             const EdgeInsets.symmetric(
                               vertical: 10,
                               horizontal: 8,
                             ),
                         prefixIcon: prefixIcon,
                         suffixIcon: suffixIcon,
                         hintText: hintText,
                       ))
                   .applyDefaults(Theme.of(field.context).inputDecorationTheme);

           Color? textColor = Theme.of(
             field.context,
           ).textTheme.titleMedium?.color;

           TextStyle textStyle = Theme.of(field.context).textTheme.titleMedium!
               .copyWith(
                 color: textColor?.withValues(alpha: enabled ? 1 : 0.4),
                 overflow: textOverflow,
               );

           return Padding(
             padding: padding,
             child: Builder(
               builder: (final BuildContext context) {
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
                             padding: const EdgeInsets.symmetric(horizontal: 4),
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
                             // TODO(edufolly): Use activeThumbColor or
                             //  activeTrackColor instead.
                             activeThumbColor: activeColor,
                             activeTrackColor: activeColor,
                           )
                         else
                           Switch(
                             value: state._effectiveController.value,
                             onChanged: enabled ? state.didChange : null,
                             // TODO(edufolly): Use activeThumbColor or
                             //  activeTrackColor instead.
                             activeThumbColor: activeColor,
                             activeTrackColor: activeColor,
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

  @override
  FormFieldState<bool> createState() => _BoolFieldState();
}

class _BoolFieldState extends FormFieldState<bool> {
  ValueNotifier<bool>? _controller;

  @override
  BoolField get widget => super.widget as BoolField;

  ValueNotifier<bool> get _effectiveController =>
      widget.controller ?? _controller!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = ValueNotifier<bool>(widget.initialValue ?? false);
    } else {
      widget.controller?.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(final BoolField oldWidget) {
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

  @override
  void didChange(final bool? value) {
    super.didChange(value);
    if (_effectiveController.value != value) {
      _effectiveController.value = value ?? false;
      widget.onChanged?.call(value ?? false);
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() => _effectiveController.value = widget.initialValue ?? false);
  }

  void _handleControllerChanged() {
    if (_effectiveController.value != value) {
      didChange(_effectiveController.value);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }
}
