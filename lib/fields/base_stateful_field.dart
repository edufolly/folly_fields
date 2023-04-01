import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/validator_editing_controller.dart';
import 'package:folly_fields/responsive/responsive.dart';

///
///
///
abstract class BaseStatefulField<T, C extends ValidatorEditingController<T>>
    extends ResponsiveStateful {
  final String labelPrefix;
  final String? label;
  final Widget? labelWidget;
  final C? controller;
  final FormFieldValidator<T?>? validator;
  final TextAlign textAlign;
  final FormFieldSetter<T?>? onSaved;
  final T? initialValue;
  final bool enabled;
  final AutovalidateMode autoValidateMode;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String?>? onFieldSubmitted;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final bool filled;
  final Color? fillColor;
  final bool readOnly;
  final TextStyle? style;
  final InputDecoration? decoration;
  final EdgeInsets padding;
  final String? hintText;
  final EdgeInsets? contentPadding;
  final int? maxLength;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget Function(
    BuildContext context,
    T? value,
    Widget? prefixIcon,
  )? updatePrefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final IconData? suffixIconData;
  final void Function()? onTap;
  final void Function(T?)? lostFocus;
  final bool required;
  final bool clearOnCancel;

  ///
  ///
  ///
  const BaseStatefulField({
    this.labelPrefix = '',
    this.label,
    this.labelWidget,
    this.controller,
    this.validator,
    this.textAlign = TextAlign.start,
    this.onSaved,
    this.initialValue,
    this.enabled = true,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.scrollPadding = const EdgeInsets.all(20),
    this.enableInteractiveSelection = true,
    this.filled = false,
    this.fillColor,
    this.readOnly = false,
    this.style,
    this.decoration,
    this.padding = const EdgeInsets.all(8),
    this.hintText,
    this.contentPadding,
    this.maxLength,
    this.prefix,
    this.prefixIcon,
    this.updatePrefixIcon,
    this.suffix,
    this.suffixIcon,
    this.suffixIconData,
    this.onTap,
    this.lostFocus,
    this.required = true,
    this.clearOnCancel = true,
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
  C createController();

  ///
  ///
  ///
  Future<T?> selectData({
    required BuildContext context,
    required C controller,
  }) async =>
      null;

  ///
  ///
  ///
  @override
  BaseStatefulFieldState<T, C> createState() => BaseStatefulFieldState<T, C>();
}

///
///
///
class BaseStatefulFieldState<T, C extends ValidatorEditingController<T>>
    extends State<BaseStatefulField<T, C>> {
  C? _controller;
  FocusNode? _focusNode;

  ValueNotifier<T?>? _updatePrefixIconNotifier;
  bool fromButton = false;

  ///
  ///
  ///
  C get _effectiveController => widget.controller ?? _controller!;

  ///
  ///
  ///
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode!;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _controller = widget.createController();
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

  ///
  ///
  ///
  void _controllerListener() {
    _updatePrefixIconNotifier?.value = _effectiveController.data;
  }

  ///
  ///
  ///
  void _handleFocus() {
    if (_effectiveFocusNode.hasFocus) {
      _effectiveController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _effectiveController.text.length,
      );
    }

    if (!fromButton &&
        !_effectiveFocusNode.hasFocus &&
        widget.lostFocus != null) {
      widget.lostFocus!(_effectiveController.data);
    }
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    TextStyle effectiveStyle =
        widget.style ?? Theme.of(context).textTheme.titleMedium!;

    if (!widget.enabled || widget.readOnly) {
      effectiveStyle = effectiveStyle.copyWith(
        color: Theme.of(context).disabledColor,
      );
    }

    InputDecoration effectiveDecoration = (widget.decoration ??
            InputDecoration(
              prefix: widget.prefix,
              prefixIcon: _updatePrefixIconNotifier != null
                  ? ValueListenableBuilder<T?>(
                      valueListenable: _updatePrefixIconNotifier!,
                      builder: (BuildContext context, T? value, _) => widget
                          .updatePrefixIcon!(context, value, widget.prefixIcon),
                    )
                  : widget.prefixIcon,
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
              hintText: widget.hintText,
              contentPadding: widget.contentPadding,
            ))
        .applyDefaults(Theme.of(context).inputDecorationTheme);

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
                        if (kDebugMode) {
                          print('$e\n$s');
                        }
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
            ? (String? value) {
                if (!widget.required && (value == null || value.isEmpty)) {
                  return null;
                }

                String? message = _effectiveController.validator.valid(value!);

                if (message != null) {
                  return message;
                }

                if (widget.validator != null) {
                  return widget
                      .validator!(_effectiveController.validator.parse(value));
                }

                return null;
              }
            : null,
        minLines: 1,
        inputFormatters: _effectiveController.validator.inputFormatters,
        textAlign: widget.textAlign,
        maxLength: widget.maxLength,
        onSaved: (String? value) => widget.enabled && widget.onSaved != null
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

  ///
  ///
  ///
  @override
  void dispose() {
    _effectiveController.removeListener(_controllerListener);

    _effectiveFocusNode.removeListener(_handleFocus);

    _controller?.dispose();
    _focusNode?.dispose();

    super.dispose();
  }
}
