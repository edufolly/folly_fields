import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:folly_fields/util/decimal.dart';

///
///
///
class DecimalFormField extends FormField<Decimal> {
  final DecimalEditingController controller;
  final FocusNode focusNode;

  ///
  ///
  ///
  DecimalFormField({
    Key key,
    String prefix,
    String label,
    this.controller,
    FormFieldValidator<Decimal> validator,
    TextAlign textAlign = TextAlign.end,
    int maxLength,
    FormFieldSetter<Decimal> onSaved,
    Decimal initialValue,
    bool enabled = true,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
    // TODO - onChanged
    this.focusNode,
    TextInputAction textInputAction,
    ValueChanged<String> onFieldSubmitted,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    bool filled = false,
  }) : super(
          key: key,
          initialValue: controller != null
              ? controller.decimalValue
              : (initialValue ?? Decimal(precision: 2)),
          onSaved: onSaved,
          validator: enabled ? validator : (_) => null,
          enabled: enabled,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<Decimal> field) {
            final _DecimalFieldState state = field as _DecimalFieldState;

            final InputDecoration effectiveDecoration = InputDecoration(
              border: OutlineInputBorder(),
              filled: filled,
              labelText: prefix == null || prefix.isEmpty
                  ? label
                  : '${prefix} - ${label}',
            ).applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: state._effectiveController,
                focusNode: state._effectiveFocusNode,
                decoration: effectiveDecoration.copyWith(
                  errorText: enabled ? field.errorText : null,
                ),
                keyboardType: TextInputType.number,
                minLines: 1,
                maxLines: 1,
                obscureText: false,
                textAlign: textAlign,
                maxLength: maxLength,
                enabled: enabled,
                textInputAction: textInputAction,
                onSubmitted: onFieldSubmitted,
                autocorrect: false,
                enableSuggestions: false,
                textCapitalization: TextCapitalization.none,
                scrollPadding: scrollPadding,
                enableInteractiveSelection: enableInteractiveSelection,
                style: enabled ? null : TextStyle(color: Colors.black26),
              ),
            );
          },
        );

  ///
  ///
  ///
  @override
  _DecimalFieldState createState() => _DecimalFieldState();
}

///
///
///
class _DecimalFieldState extends FormFieldState<Decimal> {
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
  DecimalFormField get widget => super.widget as DecimalFormField;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = DecimalEditingController(widget.initialValue);
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }

    if (widget.focusNode == null) {
      _focusNode = FocusNode();
      _focusNode.addListener(_handleFocusChanged);
    } else {
      widget.focusNode.addListener(_handleFocusChanged);
    }
  }

  ///
  ///
  ///
  @override
  void didUpdateWidget(DecimalFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      oldWidget.focusNode?.removeListener(_handleFocusChanged);

      widget.controller?.addListener(_handleControllerChanged);
      widget.focusNode?.addListener(_handleFocusChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = DecimalEditingController(
          oldWidget.controller.decimalValue,
        );
      }

      if (widget.controller != null) {
        setValue(widget.controller.decimalValue);

        if (oldWidget.controller == null) {
          _controller = null;
        }

        if (oldWidget.focusNode == null) {
          _focusNode = null;
        }
      }
    }
  }

  ///
  ///
  ///
  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    widget.focusNode?.removeListener(_handleFocusChanged);
    super.dispose();
  }

  ///
  ///
  ///
  @override
  void didChange(Decimal decimal) {
    super.didChange(decimal);

    if (_effectiveController.decimalValue.value != decimal.value) {
      _effectiveController.updateValue(decimal);
    }
  }

  ///
  ///
  ///
  @override
  void reset() {
    super.reset();
    setState(() => _effectiveController.updateValue(widget.initialValue));
  }

  ///
  ///
  ///
  void _handleControllerChanged() {
    if (_effectiveController.decimalValue.value != value.value) {
      didChange(widget.controller.decimalValue);
    }
  }

  ///
  ///
  ///
  void _handleFocusChanged() {
    _effectiveController.selection = TextSelection(
      baseOffset: 0,
      extentOffset:
          _effectiveFocusNode.hasFocus ? _effectiveController.text.length : 0,
    );
  }
}

///
///
///
class DecimalEditingController extends TextEditingController {
  final String decimalSeparator;
  final String thousandSeparator;
  final String rightSymbol;
  final String leftSymbol;
  final int precision;

  double _lastValue = 0.0;

  ///
  ///
  ///
  DecimalEditingController(
    Decimal decimal, {
    this.decimalSeparator = ',',
    this.thousandSeparator = '.',
    this.rightSymbol = '',
    this.leftSymbol = '',
  }) : precision = decimal.precision {
    _validateConfig();

    addListener(() => updateValue(decimalValue));

    updateValue(decimal);
  }

  ///
  ///
  ///
  void updateValue(Decimal decimal) {
    double valueToUse = decimal.value;

    if (decimal.value.toStringAsFixed(0).length > 12) {
      valueToUse = _lastValue;
    } else {
      _lastValue = decimal.value;
    }

    String masked = _applyMask(valueToUse);

    if (rightSymbol.isNotEmpty) {
      masked += rightSymbol;
    }

    if (leftSymbol.isNotEmpty) {
      masked = leftSymbol + masked;
    }

    if (masked != text) {
      text = masked;

      int cursorPosition = super.text.length - rightSymbol.length;
      selection = TextSelection.fromPosition(
        TextPosition(offset: cursorPosition),
      );
    }
  }

  ///
  ///
  ///
  Decimal get decimalValue {
    bool hasNoValue = text.isEmpty ||
        (text.length <= (rightSymbol.length + leftSymbol.length));

    Decimal decimal = Decimal(precision: precision);

    if (hasNoValue) {
      return decimal;
    }

    List<String> parts = _getOnlyNumbers(text).split('').toList(growable: true);

    for (int i = parts.length; i <= precision; i++) {
      parts.insert(0, '0');
    }

    parts.insert(parts.length - precision, '.');

    decimal.value = double.parse(parts.join());

    return decimal;
  }

  ///
  ///
  ///
  void _validateConfig() {
    bool rightSymbolHasNumbers = _getOnlyNumbers(rightSymbol).isNotEmpty;

    if (rightSymbolHasNumbers) {
      throw ArgumentError('rightSymbol must not have numbers.');
    }
  }

  ///
  ///
  ///
  String _getOnlyNumbers(String text) {
    String cleanedText = text;

    RegExp onlyNumbersRegex = RegExp(r'[^\d]');

    cleanedText = cleanedText.replaceAll(onlyNumbersRegex, '');

    return cleanedText;
  }

  ///
  ///
  ///
  String _applyMask(double value) {
    List<String> textRepresentation = value
        .toStringAsFixed(precision)
        .replaceAll('.', '')
        .split('')
        .reversed
        .toList(growable: true);

    textRepresentation.insert(precision, decimalSeparator);

    for (int i = precision + 4; true; i = i + 4) {
      if (textRepresentation.length > i) {
        textRepresentation.insert(i, thousandSeparator);
      } else {
        break;
      }
    }

    return textRepresentation.reversed.join('');
  }
}
