import 'package:flutter/services.dart';
import 'package:folly_fields/util/credit_card_type.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class CreditCardNumberValidator extends AbstractValidator<String> {
  CreditCardType _type;

  CreditCardNumberValidator({
    final CreditCardType type = CreditCardType.unknown,
  }) : _type = type,
       super(<TextInputFormatter>[MaskTextInputFormatter(mask: type.mask)]);

  CreditCardType get type => _type;

  set type(final CreditCardType value) {
    _type = value;

    (inputFormatters!.first as MaskTextInputFormatter).updateMask(
      mask: type.mask,
    );
  }

  @override
  String format(final String value) => strip(value);

  @override
  TextInputType get keyboard => TextInputType.number;

  @override
  bool isValid(final String value) =>
      _type.validLength(value) && _type.validNumber(value);
}
