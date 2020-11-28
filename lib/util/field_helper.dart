import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:folly_fields/util/cep_validator.dart';
import 'package:folly_fields/util/mac_address_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/util/phone_validator.dart';

///
///
///
enum FieldType {
  cpf,
  cnpj,
  email,
  mobile,
  phone,
  cep,
  date,
  mac_address,
  time,
}

///
///
///
class FieldHelper {
  ///
  ///
  ///
  static FieldType fromText(String text) {
    switch (text.toLowerCase()) {
      case 'cpf':
        return FieldType.cpf;
      case 'cnpj':
        return FieldType.cnpj;
      case 'email':
        return FieldType.email;
      case 'mobile':
        return FieldType.mobile;
      case 'phone':
        return FieldType.phone;
      case 'cep':
        return FieldType.cep;
      case 'date':
        return FieldType.date;
      case 'mac_address':
        return FieldType.mac_address;
      case 'time':
        return FieldType.time;
    }
    return null;
  }

  ///
  ///
  ///
  static final Map<FieldType, MaskTextInputFormatter> masks =
  <FieldType, MaskTextInputFormatter>{
    /// CPF
    FieldType.cpf: MaskTextInputFormatter(
      mask: '###.###.###-##',
    ),

    /// CNPJ
    FieldType.cnpj: MaskTextInputFormatter(
      mask: '##.###.###/####-##',
    ),

    /// E-mail
    FieldType.email: null,

    /// Mobile
    FieldType.mobile: MaskTextInputFormatter(
      mask: '(##) #####-####',
    ),

    /// Phone
    FieldType.phone: MaskTextInputFormatter(
      mask: '(##) ####-####',
    ),

    /// CEP
    FieldType.cep: MaskTextInputFormatter(
      mask: '##.###-###',
    ),

    /// Date
    FieldType.date: MaskTextInputFormatter(
      mask: '##/##/####',
    ),

    /// Mac Address
    FieldType.mac_address: MaskTextInputFormatter(
      mask: '##:##:##:##:##:##',
      filter: <String, RegExp>{
        '#': RegExp(r'[a-fA-F0-9]'),
      },
    ),

    /// Time
    FieldType.time: MaskTextInputFormatter(
      mask: 'AB:CB',
      filter: <String, RegExp>{
        'A': RegExp(r'[0-2]'),
        'B': RegExp(r'[0-9]'),
        'C': RegExp(r'[0-5]'),
      },
    ),
  };

  ///
  ///
  ///
  static final Map<FieldType, dynamic Function(dynamic value)> formats =
  <FieldType, dynamic Function(dynamic value)>{
    /// CPF
    FieldType.cpf: (dynamic value) => CPFValidator.format(value),

    /// CNPJ
    FieldType.cnpj: (dynamic value) => CNPJValidator.format(value),

    /// E-mail
    FieldType.email: null,

    /// Mobile
    FieldType.mobile: (dynamic value) => PhoneValidator.format(value),

    /// Phone
    FieldType.phone: (dynamic value) => PhoneValidator.format(value),

    /// CEP
    FieldType.cep: (dynamic value) => CepValidator.format(value),

    /// Date
    FieldType.date: null,

    /// Mac Address
    FieldType.mac_address: (dynamic value) => MacAddressValidator.format(value),

    /// Time
    FieldType.time: null,
  };

  ///
  ///
  ///
  static final Map<FieldType, dynamic Function(dynamic value)> strippers =
  <FieldType, dynamic Function(dynamic value)>{
    /// CPF
    FieldType.cpf: (dynamic value) => CPFValidator.strip(value),

    /// CNPJ
    FieldType.cnpj: (dynamic value) => CNPJValidator.strip(value),

    /// E-mail
    FieldType.email: null,

    /// Mobile
    FieldType.mobile: (dynamic value) => PhoneValidator.strip(value),

    /// Phone
    FieldType.phone: (dynamic value) => PhoneValidator.strip(value),

    /// CEP
    FieldType.cep: (dynamic value) => CepValidator.strip(value),

    /// Date
    FieldType.date: null,

    /// Mac Address
    FieldType.mac_address: (dynamic value) => MacAddressValidator.strip(value),

    /// Time
    FieldType.time: null,
  };

  ///
  ///
  ///
  static final Map<FieldType, bool Function(dynamic value)> validators =
  <FieldType, bool Function(dynamic value)>{
    /// CPF
    FieldType.cpf: (dynamic value) => CPFValidator.isValid(value),

    /// CNPJ
    FieldType.cnpj: (dynamic value) => CNPJValidator.isValid(value),

    /// E-mail
    FieldType.email: (dynamic value) => EmailValidator.validate(value),

    /// Mobile
    FieldType.mobile: (dynamic value) => PhoneValidator.isValid(value),

    /// Phone
    FieldType.phone: (dynamic value) => PhoneValidator.isValid(value),

    /// CEP
    FieldType.cep: (dynamic value) => CepValidator.isValid(value),

    /// Date
    FieldType.date: null, // TODO - Verificar utilização

    /// Mac Address
    FieldType.mac_address: (dynamic value) =>
        MacAddressValidator.isValid(value),

    /// Time
    FieldType.time: null, // TODO - Verificar utilização
  };
}
