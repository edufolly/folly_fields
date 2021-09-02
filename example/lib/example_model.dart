import 'dart:math';

import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:folly_fields/util/icon_helper.dart';
import 'package:folly_fields/validators/cnpj_validator.dart';
import 'package:folly_fields/validators/cpf_validator.dart';
import 'package:folly_fields/validators/mac_address_validator.dart';
import 'package:folly_fields/validators/time_validator.dart';

///
///
///
class ExampleModel extends AbstractModel<int> {
  static final TimeValidator timeValidator = TimeValidator();
  static final Random rnd = Random();

  Decimal decimal = Decimal(precision: 2);
  int integer = 0;
  String text = '';
  String email = '';
  String password = '';
  String cpf = '';
  String cnpj = '';
  String document = '';
  String phone = '';
  String localPhone = '';
  DateTime? dateTime;
  DateTime? date;
  TimeOfDay? time;
  String? macAddress;
  String? ncm;
  String? cest;
  String? cnae;
  String? cep;
  Color? color;
  bool active = true;
  IconData? icon;
  String multiline = '';

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
        integer = map['integer'] ?? 0,
        text = map['text'] ?? '',
        email = map['email'] ?? '',
        password = map['password'] ?? '',
        cpf = map['cpf'] ?? '',
        cnpj = map['cnpj'] ?? '',
        document = map['document'] ?? '',
        phone = map['phone'] ?? '',
        localPhone = map['localPhone'] ?? '',
        dateTime = map['dateTime'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
        date = map['date'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['date']),
        time = map['date'] == null ? null : timeValidator.parse(map['time']),
        macAddress = map['macAddress'],
        ncm = map['ncm'],
        cest = map['cest'],
        cnae = map['cnae'],
        cep = map['cep'],
        color = map['color'] == null
            ? null
            : Color(int.parse(map['color'], radix: 16)),
        active = map['active'] ?? true,
        icon = map['icon'] == null ? null : IconHelper.iconData(map['icon']),
        multiline = map['multiline'] ?? '',
        super.fromJson(map);

  ///
  ///
  ///
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['decimal'] = decimal.integer;
    map['integer'] = integer;
    map['text'] = text;
    map['email'] = email;
    map['password'] = password;
    map['cpf'] = cpf;
    map['cnpj'] = cnpj;
    map['document'] = document;
    map['phone'] = phone;
    map['localPhone'] = localPhone;
    if (dateTime != null) map['dateTime'] = dateTime!.millisecondsSinceEpoch;
    if (date != null) map['date'] = date!.millisecondsSinceEpoch;
    if (time != null) map['time'] = timeValidator.format(time!);
    if (macAddress != null) map['macAddress'] = macAddress;
    if (ncm != null) map['ncm'] = ncm;
    if (cest != null) map['cest'] = cest;
    if (cnae != null) map['cnae'] = cnae;
    if (cep != null) map['cep'] = cep;
    if (color != null) map['color'] = color!.value.toRadixString(16);
    map['active'] = active;
    if (icon != null) map['icon'] = IconHelper.iconName(icon!);
    map['multiline'] = multiline;
    return map;
  }

  ///
  ///
  ///
  @override
  String get searchTerm => text;

  ///
  ///
  ///
  @override
  String toString() => text;

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
    model.dateTime =
        FollyUtils.dateMergeStart(date: model.date!, time: model.time!);
    model.macAddress = MacAddressValidator.generate();
    model.ncm = complete(8);
    model.cest = complete(7);
    model.cnae = complete(7);
    model.cep = complete(8);
    model.color = randomColor;
    model.active = ms.isEven;

    int iconNumber = rnd.nextInt(IconHelper.data.keys.length);
    String iconName = IconHelper.data.keys.elementAt(iconNumber);
    model.icon = IconHelper.iconData(iconName);

    model.multiline = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
        ' Curabitur ullamcorper, nisi nec ultrices congue, ante metus congue '
        'mi, a congue tortor nisl sed odio. Curabitur lacinia elit ac dolor '
        'luctus vulputate. Quisque lectus purus, egestas quis augue nec, '
        'rhoncus consequat nisi. Praesent tempor fringilla leo. Aliquam id '
        'ipsum eu sapien tincidunt eleifend. Nullam convallis iaculis mattis. '
        'Sed semper nunc eget dui sagittis commodo.';

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
