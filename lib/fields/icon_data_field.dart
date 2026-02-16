import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/icon_data_external_field_controller.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/responsive/responsive_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconDataField extends ResponsiveFormField<IconData> {
  final IconDataExternalFieldController? controller;
  final FocusNode? focusNode;
  final String Function(IconData value) iconLabel;
  final Future<IconData?> Function(BuildContext context, IconData? data)
  selection;
  final bool clearOnCancel;

  IconDataField({
    required this.iconLabel,
    required this.selection,
    this.controller,
    this.focusNode,
    this.clearOnCancel = false,
    final String? labelPrefix,
    final String? label,
    final Widget? labelWidget,
    super.onSaved,
    final FormFieldValidator<IconData>? validator,
    final IconData? initialValue,
    super.enabled = true,
    super.autovalidateMode = AutovalidateMode.disabled,
    final TextStyle? style,
    final double? iconSize,
    final InputDecoration? decoration,
    final EdgeInsets padding = const EdgeInsets.all(8),
    final Widget? suffixIcon = const Icon(FontAwesomeIcons.magnifyingGlass),
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
         validator: enabled ? validator : null,
         builder: (final FormFieldState<IconData> field) {
           _IconDataExternalFieldState state =
               field as _IconDataExternalFieldState;

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
                         label: labelWidget,
                         labelText: <String?>[
                           labelPrefix,
                           label,
                         ].nonNulls.join(' - '),
                         counterText: '',
                         contentPadding: contentPadding,
                         suffixIcon: suffixIcon,
                       ))
                   .applyDefaults(theme.inputDecorationTheme)
                   .copyWith(
                     prefixIcon: state.value != null
                         ? Icon(state.value, size: iconSize, color: color)
                         : null,
                     enabled: enabled,
                     errorText: state.errorText,
                   );

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
                     isEmpty: state.value == null,
                     isFocused: hasFocus,
                     isHovering: state._isHovering,
                     child: isNull(state.value)
                         ? null
                         : Text(iconLabel(state.value!), style: effectiveStyle),
                   ),
                 ),
               ),
             ),
           );
         },
       );

  @override
  FormFieldState<IconData> createState() => _IconDataExternalFieldState();
}

class _IconDataExternalFieldState extends FormFieldState<IconData> {
  IconDataExternalFieldController? _controller;
  FocusNode? _focusNode;
  bool _isHovering = false;

  @override
  IconDataField get widget => super.widget as IconDataField;

  IconDataExternalFieldController get _effectiveController =>
      widget.controller ?? _controller!;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode!;

  @override
  void initState() {
    super.initState();
    if (isNull(widget.controller)) {
      _controller = IconDataExternalFieldController(value: widget.initialValue);
    }
    _effectiveController.addListener(_handleControllerChanged);

    if (isNull(widget.focusNode)) {
      _focusNode = FocusNode();
    }
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  void hovering({required final bool enter}) =>
      setState(() => _isHovering = enter);

  Future<void> _handleTap() async {
    _effectiveFocusNode.requestFocus();

    final IconData? newValue = await widget.selection(context, value);

    if (newValue == null && !widget.clearOnCancel) {
      return;
    }

    didChange(newValue);
  }

  @override
  void didChange(final IconData? value) {
    super.didChange(value);
    if (_effectiveController.value != value) {
      _effectiveController.value = value;
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
    _effectiveController.value = widget.initialValue;
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_handleControllerChanged);
    _controller?.dispose();

    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();

    super.dispose();
  }
}
