import 'dart:math';

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
  static final Random rnd = Random();

  Decimal decimal = Decimal(precision: 2);
  int integer;
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
  Color color;

  ///
  ///
  ///
  ExampleModel();

  ///
  ///
  ///
  @override
  ExampleModel.fromJson(Map<String, dynamic> map)
      : decimal = Decimal(initialValue: map['decimal'], precision: 2),
        integer = map['integer'],
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
        color = Color(int.tryParse(map['color'], radix: 16)),
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
    if (integer != null) map['integer'] = integer;
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
    if (color != null) map['color'] = color.value.toRadixString(16);
    return map;
  }

  ///
  ///
  ///
  @override
  String get searchTerm => text;

  // ///
  // ///
  // /// Para fazer debug da geração do hash.
  // @override
  // int get hashCode => super.hashIterable(toMap().values, 1, true);

  ///
  ///
  /// Método exclusivo para geração aleatória de objetos.
  static ExampleModel generate({int seed = 1}) {
    DateTime now = DateTime.now();

    int ms = seed * 1000 + now.millisecond;

    ExampleModel model = ExampleModel();
    model.id = ms;
    model.updatedAt = now.millisecondsSinceEpoch;
    model.decimal = Decimal(initialValue: ms, precision: 2);
    model.integer = ms;
    model.text = 'Exemplo $ms';
    model.email = 'exemplo$ms@exemplo.com.br';
    model.password = '123456$ms';
    model.cpf = CpfValidator.generate();
    model.cnpj = CnpjValidator.generate();
    model.document =
        ms % 2 == 0 ? CpfValidator.generate() : CnpjValidator.generate();
    model.phone = '889' + complete(8);
    model.localPhone = '9' + complete(8);
    model.date = DateTime(now.year, now.month, now.day);
    model.time = TimeOfDay(hour: now.hour, minute: now.minute);
    model.macAddress = MacAddressValidator.generate();
    model.ncm = complete(8);
    model.cep = complete(8);
    model.color = randomColor;
    return model;
  }

  ///
  ///
  ///
  static String complete(int length) =>
      List<String>.generate(length, (_) => rnd.nextInt(10).toString()).join();

  ///
  ///
  ///
  static final Map<Color, String> colors = <Color, String>{
    Colors.red: 'Vermelho',
    Colors.green: 'Verde',
    Colors.blue: 'Azul',
  };

  ///
  ///
  ///
  static Color get randomColor =>
      colors.keys.elementAt(rnd.nextInt(colors.length));
}
