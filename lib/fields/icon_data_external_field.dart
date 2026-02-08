import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/icon_data_external_field_controller.dart';
import 'package:folly_fields/responsive/responsive_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconDataExternalField extends ResponsiveFormField<IconData> {
  final IconDataExternalFieldController? controller;
  final FocusNode? focusNode;
  final String Function(IconData value) iconLabel;
  final Future<IconData?> Function(BuildContext context, IconData? data)
  selection;
  final String? labelPrefix;
  final String? label;
  final Widget? labelWidget;
  final TextStyle? style;
  final double? iconSize;
  final InputDecoration? decoration;
  final EdgeInsets padding;
  final String? hintText;
  final EdgeInsets? contentPadding;
  final bool clearOnCancel;

  IconDataExternalField({
    required this.iconLabel,
    required this.selection,
    this.labelPrefix,
    this.label,
    this.labelWidget,
    this.controller,
    this.focusNode,
    super.onSaved,
    final FormFieldValidator<IconData?>? validator,
    final IconData? initialValue,
    super.enabled = true,
    super.autovalidateMode = AutovalidateMode.disabled,
    this.style,
    this.iconSize,
    this.decoration,
    this.padding = const EdgeInsets.all(8),
    this.hintText,
    this.contentPadding,
    this.clearOnCancel = false,
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
         builder: (_) => const SizedBox.shrink(),
       );

  @override
  FormFieldState<IconData> createState() => _IconDataExternalFieldState();
}

class _IconDataExternalFieldState extends FormFieldState<IconData> {
  IconDataExternalFieldController? _controller;
  FocusNode? _focusNode;
  bool _isHovering = false;

  @override
  IconDataExternalField get widget => super.widget as IconDataExternalField;

  IconDataExternalFieldController get _effectiveController =>
      widget.controller ?? _controller!;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = IconDataExternalFieldController(value: widget.initialValue);
    }
    _effectiveController.addListener(_handleControllerChanged);

    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    }
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  @override
  Widget build(final BuildContext context) {
    ThemeData theme = Theme.of(context);

    TextStyle? effectiveStyle =
        widget.style ??
        theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        );

    if (!widget.enabled) {
      effectiveStyle = effectiveStyle?.copyWith(color: theme.disabledColor);
    }

    final IconData? value = _effectiveController.value;

    final InputDecoration effectiveDecoration =
        (widget.decoration ??
                InputDecoration(
                  border: const OutlineInputBorder(),
                  label: widget.labelWidget,
                  labelText: <String?>[
                    widget.labelPrefix,
                    widget.label,
                  ].nonNulls.join(' - '),
                  counterText: '',
                  hintText: widget.hintText,
                  contentPadding: widget.contentPadding,
                  suffixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
                ))
            .applyDefaults(theme.inputDecorationTheme)
            .copyWith(
              prefixIcon: value != null
                  ? Icon(
                      value,
                      size: widget.iconSize,
                      color: _effectiveFocusNode.hasFocus
                          ? theme.colorScheme.primary
                          : null,
                    )
                  : null,
              enabled: widget.enabled,
              errorText: errorText,
            );

    return Padding(
      padding: widget.padding,
      child: Focus(
        focusNode: _effectiveFocusNode,
        canRequestFocus: widget.enabled,
        child: MouseRegion(
          cursor: widget.enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          child: GestureDetector(
            onTap: widget.enabled ? _handleTap : null,
            child: InputDecorator(
              decoration: effectiveDecoration,
              isEmpty: value == null,
              isFocused: _effectiveFocusNode.hasFocus,
              isHovering: _isHovering,
              child: Text(
                value == null ? '' : widget.iconLabel(value),
                style: effectiveStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }

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
