import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/validators/cnpj_validator.dart';
import 'package:folly_fields/validators/cpf_validator.dart';
import 'package:folly_fields/validators/mac_address_validator.dart';
import 'package:folly_fields/validators/time_validator.dart';

///
///
///
class ExampleModel extends AbstractModel {
  static final TimeValidator timeValidator = TimeValidator();

  Decimal decimal;
  String text;
  String email;
  String password;
  String cpf;
  String cnpj;
  String document;
  String phone;
  String localPhone;
  DateTime date;
  TimeOfDay time;
  String macAddress;
  String ncm;
  String cep;

  ///
  ///
  ///
  ExampleModel();

  ///
  ///
  ///
  @override
  ExampleModel.fromJson(Map<String, dynamic> map)
      : decimal = Decimal(
            initialValue: int.tryParse(map['decimal']) ?? 0, precision: 2),
        text = map['text'],
        email = map['email'],
        password = map['password'],
        cpf = map['cpf'],
        cnpj = map['cnpj'],
        document = map['document'],
        phone = map['phone'],
        localPhone = map['localPhone'],
        date = map['date'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['date']),
        time = map['date'] == null ? null : timeValidator.parse(map['time']),
        macAddress = map['macAddress'],
        ncm = map['ncm'],
        cep = map['cep'],
        super.fromJson(map);

  ///
  ///
  ///
  @override
  ExampleModel fromJson(Map<String, dynamic> map) => ExampleModel.fromJson(map);

  ///
  ///
  ///
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    if (decimal != null) map['decimal'] = decimal.integer;
    if (text != null) map['text'] = text;
    if (email != null) map['email'] = email;
    if (password != null) map['password'] = password;
    if (cpf != null) map['cpf'] = cpf;
    if (cnpj != null) map['cnpj'] = cnpj;
    if (document != null) map['document'] = document;
    if (phone != null) map['phone'] = phone;
    if (localPhone != null) map['localPhone'] = localPhone;
    if (date != null) map['date'] = date.millisecondsSinceEpoch;
    if (time != null) map['time'] = timeValidator.format(time);
    if (macAddress != null) map['macAddress'] = macAddress;
    if (ncm != null) map['ncm'] = ncm;
    if (cep != null) map['cep'] = cep;
    return map;
  }

  ///
  ///
  ///
  @override
  String get searchTerm => text;

  ///
  ///
  /// Método exclusivo para geração aleatória de objetos.
  static ExampleModel generate() {
    DateTime now = DateTime.now();
    int ms = now.millisecond;

    ExampleModel model = ExampleModel();
    model.id = ms;
    model.updatedAt = now.millisecondsSinceEpoch;
    model.decimal = Decimal(initialValue: ms, precision: 2);
    model.text = 'Exemplo$ms';
    model.email = 'exemplo$ms@exemplo.com.br';
    model.password = '123456$ms';
    model.cpf = CpfValidator.generate();
    model.cnpj = CnpjValidator.generate();
    model.document =
        ms % 2 == 0 ? CpfValidator.generate() : CnpjValidator.generate();
    model.phone = '88987654$ms';
    model.localPhone = '912345$ms';
    model.date = now;
    model.time = TimeOfDay.now();
    model.macAddress = MacAddressValidator.generate();
    model.ncm = '99998$ms';
    model.cep = '22333$ms';

    return model;
  }
}
