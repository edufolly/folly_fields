import 'dart:math';

import 'package:flutter/material.dart';
import 'package:folly_fields/extensions/date_time_extension.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/icon_helper.dart';
import 'package:folly_fields/validators/cnpj_validator.dart';
import 'package:folly_fields/validators/cpf_validator.dart';
import 'package:folly_fields/validators/mac_address_validator.dart';
import 'package:folly_fields_example/example_enum.dart';

class ExampleModel {
  static final Random rnd = Random();

  int? id;
  Decimal decimal = Decimal(precision: 2);
  int? integer;
  String? text;
  String? email;
  String? password;
  String? visiblePassword;
  String? cpf;
  String? cnpj;
  String? document;
  String? phone;
  String? localPhone;
  String? mobilePhone;
  DateTime? dateTime;
  DateTime? date;
  TimeOfDay? time;
  Duration? duration;
  String? macAddress;
  String? ncm;
  String? cest;
  String? cnae;
  String? licencePlate;
  String? cep;
  ExampleEnum? ordinal;
  Color? color;
  bool active = true;
  IconData? icon;
  String? multiline;
  int? fruitIndex;
  String? ipv4;

  ExampleModel();

  @override
  String toString() => '$text';

  /// Geração aleatória de objetos.
  ExampleModel.generate({int seed = 1}) {
    DateTime now = DateTime.now();

    int ms = seed * 1000 + now.millisecond;

    id = ms;
    decimal = Decimal(intValue: ms, precision: 2);
    integer = ms;
    text = 'Exemplo $ms';
    email = 'exemplo$ms@exemplo.com.br';
    password = '123456$ms';
    visiblePassword = 'aBc$ms';
    cpf = CpfValidator.generate();
    cnpj = CnpjValidator.generate();
    document = ms.isEven ? CpfValidator.generate() : CnpjValidator.generate();
    phone = '889${complete(8)}';
    localPhone = '9${complete(8)}';
    mobilePhone = '119${complete(8)}';
    date = DateTime(now.year, now.month, now.day);
    time = TimeOfDay(hour: now.hour, minute: now.minute);
    dateTime = (date ?? now).mergeStart(time: time);
    macAddress = MacAddressValidator.generate();
    ncm = complete(8);
    cest = complete(7);
    cnae = complete(7);
    licencePlate = '${generateUpperString(3)}${complete(4)}';
    cep = complete(8);
    color = randomColor;
    ordinal = ExampleEnum.random;
    active = ms.isEven;

    int iconNumber = rnd.nextInt(IconHelper.data.keys.length);
    String iconName = IconHelper.data.keys.elementAt(iconNumber);
    icon = IconHelper.iconData(iconName);

    multiline =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
        ' Curabitur ullamcorper, nisi nec ultrices congue, ante metus congue '
        'mi, a congue tortor nisl sed odio. Curabitur lacinia elit ac dolor '
        'luctus vulputate. Quisque lectus purus, egestas quis augue nec, '
        'rhoncus consequat nisi. Praesent tempor fringilla leo. Aliquam id '
        'ipsum eu sapien tincidunt eleifend. Nullam convallis iaculis mattis. '
        'Sed semper nunc eget dui sagittis commodo.';

    ipv4 =
        '${complete(1, max: 256)}.'
        '${complete(1, max: 256)}.'
        '${complete(1, max: 256)}.'
        '${complete(1, max: 256)}';
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
    'id': id,
    'decimal': decimal,
    'integer': integer,
    'text': text,
    'email': email,
    'password': password,
    'visiblePassword': visiblePassword,
    'cpf': cpf,
    'cnpj': cnpj,
    'document': document,
    'phone': phone,
    'localPhone': localPhone,
    'mobilePhone': mobilePhone,
    'dateTime': dateTime,
    'date': date,
    'time': time,
    'duration': duration,
    'macAddress': macAddress,
    'ncm': ncm,
    'cest': cest,
    'cnae': cnae,
    'licencePlate': licencePlate,
    'cep': cep,
    'ordinal': ordinal,
    'color': color,
    'active': active,
    'icon': icon,
    'multiline': multiline,
    'fruitIndex': fruitIndex,
    'ipv4': ipv4,
  };

  static String complete(int length, {int max = 10}) =>
      List<String>.generate(length, (_) => rnd.nextInt(max).toString()).join();

  static String generateUpperString(
    int length, {
    String domain = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
  }) => List<String>.generate(
    length,
    (_) => domain[rnd.nextInt(domain.length)],
  ).join();

  static final Map<Color, String> _colors = <Color, String>{
    Colors.red.shade500: 'Vermelho',
    Colors.green.shade500: 'Verde',
    Colors.blue.shade500: 'Azul',
  };

  static Color get randomColor =>
      _colors.keys.elementAt(rnd.nextInt(_colors.length));
}
