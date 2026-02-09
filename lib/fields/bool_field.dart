// To force override parameter.
// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/responsive/responsive_form_field.dart';

class BoolField extends ResponsiveFormField<bool> {
  final ValueNotifier<bool>? controller;
  final FocusNode? focusNode;
  final Function(bool value)? onChanged;

  BoolField({
    this.controller,
    this.focusNode,
    this.onChanged,
    final String? labelPrefix,
    final String? label,
    final Widget? labelWidget,
    final void Function(bool value)? onSaved,
    final String? Function(bool value)? validator,
    final bool? initialValue,
    super.enabled = true,
    super.autovalidateMode = AutovalidateMode.disabled,
    final TextStyle? style,
    final InputDecoration? decoration,
    final EdgeInsets padding = const EdgeInsets.all(8),
    final Widget? prefixIcon,
    final Widget? suffixIcon,
    final EdgeInsets? contentPadding,
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
         initialValue: controller?.value ?? initialValue,
         validator: enabled && validator != null
             ? (final bool? value) => validator(value ?? false)
             : null,
         onSaved: enabled && onSaved != null
             ? (final bool? value) => onSaved(value ?? false)
             : null,
         builder: (final FormFieldState<bool> field) {
           _BoolFieldState state = field as _BoolFieldState;

           final ThemeData theme = Theme.of(state.context);

           final bool hasFocus = state._effectiveFocusNode.hasFocus;

           final Color? color = enabled
               ? hasFocus
                     ? theme.colorScheme.primary
                     : null
               : theme.disabledColor;

           final TextStyle? effectiveStyle =
               (style ??
                       theme.textTheme.titleMedium?.copyWith(
                         color: theme.colorScheme.onSurfaceVariant,
                       ))
                   ?.copyWith(color: color);

           final InputDecoration effectiveDecoration =
               (decoration ??
                       InputDecoration(
                         border: const OutlineInputBorder(),
                         counterText: '',
                         contentPadding:
                             contentPadding ??
                             const EdgeInsets.symmetric(horizontal: 8),
                         prefixIcon: prefixIcon,
                         suffixIcon: suffixIcon,
                       ))
                   .applyDefaults(theme.inputDecorationTheme)
                   .copyWith(enabled: enabled, errorText: state.errorText);

           return Padding(
             padding: padding,
             child: Focus(
               focusNode: state._effectiveFocusNode,
               canRequestFocus: enabled,
               skipTraversal: !enabled,
               child: MouseRegion(
                 cursor: enabled
                     ? SystemMouseCursors.click
                     : SystemMouseCursors.basic,
                 onEnter: (_) => state.hovering(enter: true),
                 onExit: (_) => state.hovering(enter: false),
                 child: GestureDetector(
                   onTap: enabled ? state._handleTap : null,
                   child: InputDecorator(
                     decoration: effectiveDecoration,
                     isFocused: hasFocus,
                     isHovering: state._isHovering,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         labelWidget ??
                             Text(
                               <String?>[
                                 labelPrefix,
                                 label,
                               ].nonNulls.join(' - '),
                               style: effectiveStyle,
                             ),
                         Switch(
                           focusNode: state.disabledFocusNode,
                           padding: EdgeInsets.zero,
                           value: state.value ?? false,
                           onChanged: enabled
                               ? (_) => state._handleTap()
                               : null,
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             ),
           );
         },
       );

  @override
  FormFieldState<bool> createState() => _BoolFieldState();
}

class _BoolFieldState extends FormFieldState<bool> {
  final FocusNode disabledFocusNode = FocusNode(
    canRequestFocus: false,
    skipTraversal: true,
  );

  // TODO(edufolly): Create controller.
  ValueNotifier<bool>? _controller;
  FocusNode? _focusNode;
  bool _isHovering = false;

  @override
  BoolField get widget => super.widget as BoolField;

  ValueNotifier<bool> get _effectiveController =>
      widget.controller ?? _controller!;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode!;

  @override
  void initState() {
    super.initState();
    if (isNull(widget.controller)) {
      _controller = ValueNotifier<bool>(widget.initialValue ?? false);
    }
    _effectiveController.addListener(_handleControllerChanged);

    if (isNull(widget.focusNode)) {
      _focusNode = FocusNode();
    }
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  void hovering({required final bool enter}) =>
      setState(() => _isHovering = enter);

  void _handleTap() {
    _effectiveFocusNode.requestFocus();
    didChange(!(value ?? false));
  }

  @override
  void didChange(final bool? value) {
    super.didChange(value);
    if (_effectiveController.value != value) {
      _effectiveController.value = value ?? false;
      widget.onChanged?.call(value ?? false);
    }
  }

  void _handleControllerChanged() {
    if (_effectiveController.value != value) {
      didChange(_effectiveController.value);
    }
  }

  void _handleFocusChanged() => setState(() {});

  @override
  void reset() {
    super.reset();
    _effectiveController.value = widget.initialValue ?? false;
  }

  @override
  void dispose() {
    disabledFocusNode.dispose();

    _effectiveController.removeListener(_handleControllerChanged);
    _controller?.dispose();

    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();

    super.dispose();
  }
}
