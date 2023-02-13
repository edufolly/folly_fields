import 'package:flutter/material.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/validators/new_decimal_validator.dart';

///
///
///
class NewDecimalField extends StatefulWidget {
  final NewDecimalEditingController? controller;
  final Decimal? initialValue;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final void Function(Decimal)? lostFocus;

  ///
  ///
  ///
  const NewDecimalField({
    this.controller,
    this.initialValue,
    this.textAlign = TextAlign.end,
    this.focusNode,
    this.lostFocus,
    super.key,
  }) : assert(
          initialValue == null || controller == null,
          'initialValue or controller must be null.',
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
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: widget.textAlign,
      controller: _effectiveController,
      focusNode: _effectiveFocusNode,
      keyboardType: _effectiveController.validator.keyboard,
      minLines: 1,
      inputFormatters: _effectiveController.validator.inputFormatters,
      autocorrect: false,
      enableSuggestions: false,
    );
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
  String format(Decimal decimal) => validator.format(decimal);
}
