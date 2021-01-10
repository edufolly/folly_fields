import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:folly_fields/validators/cep_validator.dart';
import 'package:folly_fields/validators/cnpj_validator.dart';
import 'package:folly_fields/validators/cpf_cnpj_validator.dart';
import 'package:folly_fields/validators/cpf_validator.dart';
import 'package:folly_fields/validators/date_validator.dart';
import 'package:folly_fields/validators/email_validator.dart';
import 'package:folly_fields/validators/empty_validator.dart';
import 'package:folly_fields/validators/local_phone_validator.dart';
import 'package:folly_fields/validators/mac_address_validator.dart';
import 'package:folly_fields/validators/ncm_validator.dart';
import 'package:folly_fields/validators/phone_validator.dart';
import 'package:folly_fields/validators/time_validator.dart';

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
      case 'local_phone':
        return LocalPhoneValidator();
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
      default:
        return EmptyValidator();
    }
  }
}
