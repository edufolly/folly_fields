import 'package:flutter/material.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/validators/new_decimal_validator.dart';

///
///
///
class NewDecimalField extends ResponsiveStateful {
  final String labelPrefix;
  final String? label;
  final Widget? labelWidget;
  final NewDecimalEditingController? controller;
  final Decimal? initialValue;
  final String? Function(Decimal value)? validator;
  final void Function(Decimal value)? onSaved;
  final TextAlign textAlign;
  final int? maxLength;
  final bool enabled;
  final AutovalidateMode autoValidateMode;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String?>? onFieldSubmitted;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final bool filled;
  final Color? fillColor;
  final void Function(Decimal)? lostFocus;
  final bool readOnly;
  final InputDecoration? decoration;
  final EdgeInsets padding;
  final String? hintText;
  final EdgeInsets? contentPadding;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;

  ///
  ///
  ///
  const NewDecimalField({
    this.labelPrefix = '',
    this.label,
    this.labelWidget,
    this.controller,
    this.validator,
    this.textAlign = TextAlign.end,
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
    this.filled = false,
    this.fillColor,
    this.lostFocus,
    this.readOnly = false,
    this.decoration,
    this.padding = const EdgeInsets.all(8),
    this.hintText,
    this.contentPadding,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
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
  NewDecimalFieldState createState() => NewDecimalFieldState();
}

///
///
///
class NewDecimalFieldState extends State<NewDecimalField> {
  late NewDecimalEditingController? _controller;
  late FocusNode? _focusNode;

  ///
  ///
  ///
  NewDecimalEditingController get _effectiveController =>
      widget.controller ?? _controller!;

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
      _controller = NewDecimalEditingController(widget.initialValue!);
    }

    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    }

    _effectiveFocusNode.addListener(_handleFocus);
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
    } else {
      widget.lostFocus?.call(_effectiveController.decimal);
    }
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    InputDecoration effectiveDecoration = (widget.decoration ??
            InputDecoration(
              border: const OutlineInputBorder(),
              filled: widget.filled,
              fillColor: widget.fillColor,
              label: widget.labelWidget,
              labelText: widget.labelPrefix.isEmpty
                  ? widget.label
                  : '${widget.labelPrefix} - ${widget.label}',
              counterText: '',
              hintText: widget.hintText,
              contentPadding: widget.contentPadding,
              prefix: widget.prefix,
              prefixIcon: widget.prefixIcon,
              suffix: widget.suffix,
              suffixIcon: widget.suffixIcon,
            ))
        .applyDefaults(Theme.of(context).inputDecorationTheme);

    return Padding(
      padding: widget.padding,
      child: TextFormField(
        controller: _effectiveController,
        decoration: effectiveDecoration,
        validator: (String? value) => widget.enabled && widget.validator != null
            ? widget.validator!(
                _effectiveController.parse(value),
              )
            : null,
        keyboardType: _effectiveController.validator.keyboard,
        minLines: 1,
        inputFormatters: _effectiveController.validator.inputFormatters,
        textAlign: widget.textAlign,
        maxLength: widget.maxLength,
        onSaved: (String? value) => widget.enabled && widget.onSaved != null
            ? widget.onSaved!(_effectiveController.parse(value))
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
        style: widget.enabled && !widget.readOnly
            ? null
            : Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
      ),
    );
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocus);
    _controller?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }
}

///
///
///
class NewDecimalEditingController extends TextEditingController {
  final NewDecimalValidator validator;

  ///
  ///
  ///
  NewDecimalEditingController(Decimal value)
      : validator = NewDecimalValidator(value.precision) {
    decimal = value;
  }

  ///
  ///
  ///
  set decimal(Decimal dec) {
    String masked = format(dec);
    if (masked != text) {
      text = masked;
    }
  }

  ///
  ///
  ///
  Decimal get decimal => parse(text);

  ///
  ///
  ///
  Decimal parse(String? text) =>
      validator.parse(text) ?? Decimal(precision: validator.precision);

  ///
  ///
  ///
  set intValue(int intValue) {
    decimal = Decimal(precision: validator.precision, intValue: intValue);
  }

  ///
  ///
  ///
  int get intValue => decimal.intValue;

  ///
  ///
  ///
  set doubleValue(double doubleValue) {
    decimal = Decimal(precision: validator.precision, doubleValue: doubleValue);
  }

  ///
  ///
  ///
  double get doubleValue => decimal.doubleValue;

  ///
  ///
  ///
  String format(Decimal decimal) => validator.format(decimal);
}
