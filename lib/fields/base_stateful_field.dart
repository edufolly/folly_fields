import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/validator_editing_controller.dart';
import 'package:folly_fields/responsive/responsive.dart';

abstract class BaseStatefulField<T, C extends ValidatorEditingController<T?>>
    extends ResponsiveStateful {
  final bool required;
  final String? labelPrefix;
  final String? label;
  final Widget? labelWidget;
  final C? controller;

  // Keyboard
  final FormFieldValidator<T?>? validator;

  // minLines
  // maxLines
  // obscureText
  // inputFormatter
  final TextAlign textAlign;
  final int? maxLength;
  final FormFieldSetter<T?>? onSaved;
  final T? initialValue;
  final bool enabled;
  final AutovalidateMode autoValidateMode;

  // onChanged
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String?>? onFieldSubmitted;

  // autocorrect
  // enableSuggestions
  // textCapitalization
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

  // TODO(edufolly): Document
  final Widget Function(BuildContext context, T? value, Widget? prefixIcon)?
  updatePrefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;

  // TODO(edufolly): Remove
  // @Deprecated('Remove this field')
  final IconData? suffixIconData;
  final VoidCallback? onTap;
  final bool clearOnCancel;

  const BaseStatefulField({
    this.required = true,
    this.labelPrefix,
    this.label,
    this.labelWidget,
    this.controller,
    this.validator,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.onSaved,
    this.initialValue,
    this.enabled = true,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
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
    this.updatePrefixIcon,
    this.suffix,
    this.suffixIcon,
    this.suffixIconData,
    this.onTap,
    this.clearOnCancel = true,
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

  C createController(final T? value);

  Future<T?> selectData({
    required final BuildContext context,
    required final C controller,
  }) async => null;

  @override
  State<BaseStatefulField<T, C>> createState() =>
      _BaseStatefulFieldState<T, C>();
}

class _BaseStatefulFieldState<T, C extends ValidatorEditingController<T?>>
    extends State<BaseStatefulField<T, C>> {
  C? _controller;
  FocusNode? _focusNode;

  ValueNotifier<T?>? _updatePrefixIconNotifier;
  bool fromButton = false;

  C get _effectiveController => widget.controller ?? _controller!;

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode!;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _controller = widget.createController(widget.initialValue);
    }
    _effectiveController.addListener(_controllerListener);

    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    }
    _effectiveFocusNode.addListener(_handleFocus);

    if (widget.updatePrefixIcon != null) {
      _updatePrefixIconNotifier = ValueNotifier<T?>(_effectiveController.data);
    }
  }

  void _controllerListener() {
    _updatePrefixIconNotifier?.value = _effectiveController.data;
  }

  void _handleFocus() {
    if (_effectiveFocusNode.hasFocus) {
      // TODO(edufolly): Create a property to set up.
      _effectiveController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _effectiveController.text.length,
      );
    }
  }

  Widget? _prefixIcon() {
    if (_updatePrefixIconNotifier == null) {
      return widget.prefixIcon;
    }

    return ValueListenableBuilder<T?>(
      valueListenable: _updatePrefixIconNotifier!,
      builder: (final BuildContext context, final T? value, _) =>
          widget.updatePrefixIcon!(context, value, widget.prefixIcon),
    );
  }

  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final TextStyle? effectiveStyle =
        (widget.style ?? theme.textTheme.titleMedium)?.copyWith(
          color: (!widget.enabled || widget.readOnly)
              ? theme.disabledColor
              : null,
        );

    InputDecoration effectiveDecoration =
        (widget.decoration ??
                InputDecoration(
                  border: const OutlineInputBorder(),
                  prefix: widget.prefix,
                  prefixIcon: _prefixIcon(),
                  label: widget.labelWidget,
                  labelText: <String?>[
                    widget.labelPrefix,
                    widget.label,
                  ].nonNulls.join(' - '),
                  counterText: widget.counterText,
                  enabled: widget.enabled,
                  hintText: widget.hintText,
                  contentPadding: widget.contentPadding,
                ))
            .applyDefaults(theme.inputDecorationTheme);

    /// Add suffix icon button
    effectiveDecoration = widget.suffixIconData != null
        ? effectiveDecoration.copyWith(
            suffixIcon: IconButton(
              icon: Icon(widget.suffixIconData),
              onPressed: widget.enabled && !widget.readOnly
                  ? () async {
                      try {
                        fromButton = true;
                        T? value = await widget.selectData(
                          context: context,
                          controller: _effectiveController,
                        );
                        fromButton = false;
                        if (value != null ||
                            (value == null && widget.clearOnCancel)) {
                          _effectiveController.data = value;
                        }
                        if (_effectiveFocusNode.canRequestFocus) {
                          _effectiveFocusNode.requestFocus();
                        }
                      } on Exception catch (e, s) {
                        debugPrintStack(label: e.toString(), stackTrace: s);
                      }
                    }
                  : null,
            ),
          )
        : effectiveDecoration.copyWith(
            suffix: widget.suffix,
            suffixIcon: widget.suffixIcon,
          );

    return Padding(
      padding: widget.padding,
      child: TextFormField(
        controller: _effectiveController,
        keyboardType: _effectiveController.validator.keyboard,
        decoration: effectiveDecoration,
        validator: widget.enabled
            ? (final String? value) {
                if (!widget.required && (value == null || value.isEmpty)) {
                  return null;
                }

                String? message = _effectiveController.validator.valid(value);

                if (message != null) {
                  return message;
                }

                if (widget.validator != null) {
                  return widget.validator!(
                    _effectiveController.validator.parse(value),
                  );
                }

                return null;
              }
            : null,
        minLines: 1,
        inputFormatters: _effectiveController.validator.inputFormatters,
        textAlign: widget.textAlign,
        maxLength: widget.maxLength,
        onSaved: (final String? value) =>
            widget.enabled && widget.onSaved != null
            ? widget.onSaved!(_effectiveController.validator.parse(value))
            : null,
        enabled: widget.enabled,
        autovalidateMode: widget.autoValidateMode,
        focusNode: _effectiveFocusNode,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        autocorrect: false,
        enableSuggestions: false,
        scrollPadding: widget.scrollPadding,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        style: effectiveStyle,
      ),
    );
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_controllerListener);

    _effectiveFocusNode.removeListener(_handleFocus);

    _controller?.dispose();
    _focusNode?.dispose();

    super.dispose();
  }
}
