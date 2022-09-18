import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/fields/validator_field.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/util/credit_card_type.dart';
import 'package:folly_fields/validators/credit_card_number_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class CreditCardNumberField extends ResponsiveStateful {
  final String labelPrefix;
  final String? label;
  final Widget? labelWidget;
  final TextEditingController? controller;
  final String? Function(String value)? validator;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatter;
  final TextAlign textAlign;
  final void Function(String? value)? onSaved;
  final String? initialValue;
  final bool enabled;
  final AutovalidateMode autoValidateMode;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final bool autocorrect;
  final bool enableSuggestions;
  final TextCapitalization textCapitalization;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final bool filled;
  final Color? fillColor;
  final bool required;
  final Iterable<String>? autofillHints;
  final bool readOnly;
  final TextStyle? style;
  final InputDecoration? decoration;
  final EdgeInsets padding;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool trimOnSaved;
  final Function(CreditCardType creditCardType)? onTypeChange;
  final String validatorMessage;
  final bool showDefaultType;
  final bool showWhenValid;

  ///
  ///
  ///
  const CreditCardNumberField({
    this.labelPrefix = '',
    this.label,
    this.labelWidget,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.inputFormatter,
    this.textAlign = TextAlign.start,
    this.onSaved,
    this.initialValue,
    this.enabled = true,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20),
    this.enableInteractiveSelection = true,
    this.filled = false,
    this.fillColor,
    this.required = true,
    this.autofillHints,
    this.readOnly = false,
    this.style,
    this.decoration,
    this.padding = const EdgeInsets.all(8),
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.trimOnSaved = true,
    this.onTypeChange,
    this.validatorMessage = 'Informe o número do cartão de crédito.',
    this.showDefaultType = true,
    this.showWhenValid = true,
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
        );

  ///
  ///
  ///
  @override
  State<CreditCardNumberField> createState() => _CreditCardNumberFieldState();
}

///
///
///
class _CreditCardNumberFieldState extends State<CreditCardNumberField> {
  final CreditCardNumberValidator validator = CreditCardNumberValidator();
  TextEditingController? _stateController;
  bool isValid = false;

  ///
  ///
  ///
  TextEditingController get effectiveController =>
      widget.controller ?? _stateController!;

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _stateController = TextEditingController(text: widget.initialValue);
    }

    effectiveController.addListener(onTextChange);
  }

  ///
  ///
  ///
  void onTextChange() {
    CreditCardType type = CreditCardType.detectType(effectiveController.text);
    if (validator.type != type) {
      setState(() => validator.type = type);
      widget.onTypeChange?.call(validator.type);
    }

    bool valid = validator.isValid(effectiveController.text);
    if (isValid != valid) {
      setState(() => isValid = valid);
    }
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return ValidatorField(
      abstractValidator: validator,
      validatorMessage: widget.validatorMessage,
      labelPrefix: widget.labelPrefix,
      label: widget.label,
      labelWidget: widget.labelWidget,
      controller: effectiveController,
      validator: widget.validator,
      obscureText: widget.obscureText,
      inputFormatter: widget.inputFormatter,
      textAlign: widget.textAlign,
      maxLength: validator.type.mask.length,
      onSaved: widget.onSaved,
      enabled: widget.enabled,
      autoValidateMode: widget.autoValidateMode,
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      textCapitalization: widget.textCapitalization,
      scrollPadding: widget.scrollPadding,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      filled: widget.filled,
      fillColor: widget.fillColor,
      required: widget.required,
      autofillHints: widget.autofillHints,
      readOnly: widget.readOnly,
      style: widget.style,
      decoration: widget.decoration,
      padding: widget.padding,
      hintText: widget.hintText,
      prefixIcon:
          widget.showDefaultType ? validator.type.icon : widget.prefixIcon,
      suffixIcon: widget.showWhenValid
          ? (isValid ? const Icon(FontAwesomeIcons.check) : null)
          : widget.prefixIcon,
      trimOnSaved: widget.trimOnSaved,
    );
  }

  ///
  ///
  ///
  @override
  void dispose() {
    effectiveController.removeListener(onTextChange);
    super.dispose();
  }
}