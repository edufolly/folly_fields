// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/services.dart';
import 'package:folly_fields/util/credit_card_type.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class CreditCardNumberValidator extends AbstractValidator<String> {
  CreditCardType _type;

  ///
  ///
  ///
  CreditCardNumberValidator({CreditCardType type = CreditCardType.unknown})
      : _type = type,
        super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: type.mask,
            ),
          ],
        );

  ///
  ///
  ///
  CreditCardType get type => _type;

  ///
  ///
  ///
  set type(CreditCardType value) {
    _type = value;

    (inputFormatters!.first as MaskTextInputFormatter)
        .updateMask(mask: type.mask);
  }

  ///
  ///
  ///
  @override
  String format(String value) => strip(value);

  ///
  ///
  ///
  @override
  TextInputType get keyboard => TextInputType.number;

  ///
  ///
  ///
  @override
  bool isValid(String ccNum) =>
      _type.validLength(ccNum) && _type.validNumber(ccNum);
}
