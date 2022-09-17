import 'package:flutter/material.dart';
import 'package:folly_fields/fields/validator_field.dart';
import 'package:folly_fields/responsive/responsive.dart';
import 'package:folly_fields/util/credit_card_type.dart';
import 'package:folly_fields/validators/credit_card_number_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///
///
///
class CreditCardNumberField extends ResponsiveStateful {
  final String? initialValue;
  final TextEditingController? controller;
  final Function(CreditCardType creditCardType)? onTypeChange;
  final String validatorMessage;
  final bool showDefaultType;
  final bool showWhenValid;

  ///
  ///
  ///
  const CreditCardNumberField({
    this.initialValue,
    this.controller,
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
      label: 'Número do Cartão',
      controller: effectiveController,
      maxLength: validator.type.mask.length,
      prefixIcon: widget.showDefaultType ? validator.type.icon : null,
      suffixIcon: widget.showWhenValid && isValid
          ? const Icon(FontAwesomeIcons.check)
          : null,
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
