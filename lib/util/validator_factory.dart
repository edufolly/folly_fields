import 'package:folly_fields/util/abstract_validator.dart';
import 'package:folly_fields/util/cep_validator.dart';
import 'package:folly_fields/util/cnpj_validator.dart';
import 'package:folly_fields/util/cpf_cnpj_validator.dart';
import 'package:folly_fields/util/cpf_validator.dart';
import 'package:folly_fields/util/date_validator.dart';
import 'package:folly_fields/util/email_validator.dart';
import 'package:folly_fields/util/mac_address_validator.dart';
import 'package:folly_fields/util/ncm_validator.dart';
import 'package:folly_fields/util/phone_validator.dart';
import 'package:folly_fields/util/time_validator.dart';

///
///
///
class ValidatorFactory {
  ///
  ///
  ///
  static AbstractValidator<dynamic> build(String text) {
    switch (text.toLowerCase()) {
      case 'cpf':
        return CpfValidator();
      case 'cnpj':
        return CnpjValidator();
      case 'cpf_cnpj':
        return CpfCnpjValidator();
      case 'email':
        return EmailValidator();
      case 'phone':
        return PhoneValidator();
      case 'cep':
        return CepValidator();
      case 'date':
        return DateValidator();
      case 'time':
        return TimeValidator();
      case 'mac_address':
        return MacAddressValidator();
      case 'ncm':
        return NcmValidator();
    }
    return null;
  }
}
