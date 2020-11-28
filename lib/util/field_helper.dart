import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:folly_fields/util/cep_validator.dart';
import 'package:folly_fields/util/cpf_cnpj_validator.dart';
import 'package:folly_fields/util/mac_address_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/util/ncm_validator.dart';
import 'package:folly_fields/util/phone_validator.dart';

///
///
///
enum FieldType {
  cpf,
  cnpj,
  cpf_cnpj,
  email,
  mobile,
  phone,
  cep,
  date,
  time,
  mac_address,
  ncm,
}

///
///
///
extension ParserFieldType on FieldType {
  ///
  ///
  ///
  String toShort() {
    return toString().split('.').last;
  }

  ///
  ///
  ///
  static FieldType fromText(String text) {
    switch (text.toLowerCase()) {
      case 'cpf':
        return FieldType.cpf;
      case 'cnpj':
        return FieldType.cnpj;
      case 'cpf_cnpj':
        return FieldType.cpf_cnpj;
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
      case 'time':
        return FieldType.time;
      case 'mac_address':
        return FieldType.mac_address;
      case 'ncm':
        return FieldType.ncm;
    }
    return null;
  }
}

///
///
///
class FieldHelper {
  ///
  ///
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

    /// CPF CNPJ
    FieldType.cpf_cnpj: ChangeMask(
      firstMask: '###.###.###-##',
      secondMask: '##.###.###/####-##',
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

    /// Time
    FieldType.time: MaskTextInputFormatter(
      mask: 'AB:CB',
      filter: <String, RegExp>{
        'A': RegExp(r'[0-2]'),
        'B': RegExp(r'[0-9]'),
        'C': RegExp(r'[0-5]'),
      },
    ),

    /// Mac Address
    FieldType.mac_address: MaskTextInputFormatter(
      mask: '##:##:##:##:##:##',
      filter: <String, RegExp>{
        '#': RegExp(r'[a-fA-F0-9]'),
      },
    ),

    /// NCM
    FieldType.ncm: MaskTextInputFormatter(
      mask: '####.##.##',
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

    /// CPF CNPJ
    FieldType.cpf_cnpj: (dynamic value) => CpfCnpjValidator.format(value),

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

    /// Time
    FieldType.time: null,

    /// Mac Address
    FieldType.mac_address: (dynamic value) => MacAddressValidator.format(value),

    /// NCM
    FieldType.ncm: (dynamic value) => NcmValidator.format(value),
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

    /// CPF CNPJ
    FieldType.cpf_cnpj: (dynamic value) => CpfCnpjValidator.strip(value),

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

    /// Time
    FieldType.time: null,

    /// Mac Address
    FieldType.mac_address: (dynamic value) => MacAddressValidator.strip(value),

    /// NCM
    FieldType.ncm: (dynamic value) => NcmValidator.strip(value),
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

    /// CPF CNPJ
    FieldType.cpf_cnpj: (dynamic value) => CpfCnpjValidator.isValid(value),

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

    /// Time
    FieldType.time: null, // TODO - Verificar utilização

    /// Mac Address
    FieldType.mac_address: (dynamic value) =>
        MacAddressValidator.isValid(value),

    /// NCM
    FieldType.ncm: (dynamic value) => NcmValidator.isValid(value),
  };
}
