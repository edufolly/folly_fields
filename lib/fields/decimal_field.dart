import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/validators/decimal_validator.dart';

///
///
///
class DecimalField extends StatefulWidget {
  final String prefix;
  final String label;
  final DecimalEditingController controller;
  final FormFieldValidator<Decimal> validator;
  final TextAlign textAlign;
  final int maxLength;
  final FormFieldSetter<Decimal> onSaved;
  final Decimal initialValue;
  final bool enabled;
  final AutovalidateMode autoValidateMode;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final bool filled;
  final void Function(Decimal) lostFocus;

  ///
  ///
  ///
  DecimalField({
    Key key,
    this.prefix,
    this.label,
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
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.filled = false,
    this.lostFocus,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  _DecimalFieldState createState() => _DecimalFieldState();
}

///
///
///
class _DecimalFieldState extends State<DecimalField> {
  DecimalEditingController _controller;
  FocusNode _focusNode;

  ///
  ///
  ///
  DecimalEditingController get _effectiveController =>
      widget.controller ?? _controller;

  ///
  ///
  ///
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = DecimalEditingController(decimal: widget.initialValue);
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
    }

    if (!_effectiveFocusNode.hasFocus && widget.lostFocus != null) {
      widget.lostFocus(_effectiveController.getDecimal());
    }
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocus);

    if (_controller != null) _controller.dispose();
    if (_focusNode != null) _focusNode.dispose();

    super.dispose();
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    final InputDecoration effectiveDecoration = InputDecoration(
      border: OutlineInputBorder(),
      filled: widget.filled,
      labelText: widget.prefix == null || widget.prefix.isEmpty
          ? widget.label
          : '${widget.prefix} - ${widget.label}',
      counterText: '',
    ).applyDefaults(Theme.of(context).inputDecorationTheme);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _effectiveController,
        decoration: effectiveDecoration,
        validator: widget.enabled
            ? (String value) => widget.validator != null
                ? widget.validator(
                    _effectiveController.validator.parse(value),
                  )
                : null
            : (_) => null,
        keyboardType: _effectiveController.validator.keyboard,
        minLines: 1,
        maxLines: 1,
        obscureText: false,
        inputFormatters: _effectiveController.validator.inputFormatters,
        textAlign: widget.textAlign,
        maxLength: widget.maxLength,
        onSaved: widget.enabled
            ? (String value) => widget.onSaved != null
                ? widget.onSaved(_effectiveController.validator.parse(value))
                : null
            : null,
        enabled: widget.enabled,
        autovalidateMode: widget.autoValidateMode,
        focusNode: _effectiveFocusNode,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        autocorrect: false,
        enableSuggestions: false,
        textCapitalization: TextCapitalization.none,
        scrollPadding: widget.scrollPadding,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        style: widget.enabled
            ? null
            : Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
      ),
    );
  }
}

///
///
///
class DecimalEditingController extends TextEditingController {
  final DecimalValidator validator;

  double _lastValue = 0.0;

  ///
  ///
  ///
  DecimalEditingController({@required Decimal decimal})
      : validator = DecimalValidator(decimal.precision) {
    addListener(_changeListener);
    setDecimal(decimal);
  }

  ///
  ///
  ///
  void setDecimal(Decimal dec) {
    /// TODO - Remover esse limitador?
    if (dec.value.toStringAsFixed(0).length > 12) {
      dec.value = _lastValue;
    } else {
      _lastValue = dec.value;
    }

    String masked = validator.format(dec);

    if (masked != super.text) {
      super.text = masked;

      int cursorPosition = super.text.length - validator.rightSymbol.length;
      super.selection = TextSelection.fromPosition(
        TextPosition(
          offset: cursorPosition,
        ),
      );
    }
  }

  ///
  ///
  ///
  Decimal getDecimal() => validator.parse(text);

  ///
  ///
  ///
  void _changeListener() => setDecimal(getDecimal());

  ///
  ///
  ///
  @override
  void dispose() {
    removeListener(_changeListener);
    super.dispose();
  }
}
