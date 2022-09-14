import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:folly_fields/util/icon_helper.dart';
import 'package:folly_fields/util/model_utils.dart';
import 'package:folly_fields/validators/cnpj_validator.dart';
import 'package:folly_fields/validators/color_validator.dart';
import 'package:folly_fields/validators/cpf_validator.dart';
import 'package:folly_fields/validators/mac_address_validator.dart';
import 'package:folly_fields/validators/time_validator.dart';
import 'package:folly_fields_example/example_enum.dart';

///
///
///
class ExampleModel extends AbstractModel<int> {
  static final TimeValidator _timeValidator = TimeValidator();
  static const ExampleEnumParser _exampleEnumParser = ExampleEnumParser();
  static final ColorValidator _colorValidator = ColorValidator();
  static final Random rnd = Random();

  Decimal decimal = Decimal(precision: 2);
  int integer = 0;
  String text = '';
  String email = '';
  String password = '';
  String visiblePassword = '';
  String cpf = '';
  String cnpj = '';
  String document = '';
  String phone = '';
  String localPhone = '';
  DateTime dateTime = DateTime.now();
  DateTime? date;
  TimeOfDay time = TimeOfDay.now();
  Duration duration = Duration.zero;
  String? macAddress;
  String? ncm;
  String? cest;
  String? cnae;
  String? licencePlate;
  String? cep;
  ExampleEnum ordinal = _exampleEnumParser.defaultItem;
  Color? color;
  bool active = true;
  IconData? icon;
  String multiline = '';
  Uint8List blob = Uint8List(0);
  int? fruitIndex;

  ///
  ///
  ///
  ExampleModel();

  ///
  ///
  ///
  @override
  ExampleModel.fromJson(super.map)
      : decimal = ModelUtils.fromJsonDecimal(map['decimal'], 2),
        integer = map['integer'] ?? 0,
        text = map['text'] ?? '',
        email = map['email'] ?? '',
        password = map['password'] ?? '',
        visiblePassword = map['visiblePassword'] ?? '',
        cpf = map['cpf'] ?? '',
        cnpj = map['cnpj'] ?? '',
        document = map['document'] ?? '',
        phone = map['phone'] ?? '',
        localPhone = map['localPhone'] ?? '',
        dateTime = ModelUtils.fromJsonDateMillis(map['dateTime']),
        date = ModelUtils.fromJsonNullableDateMillis(map['date']),
        time = _timeValidator.parse(map['time']) ?? TimeOfDay.now(),
        duration = Duration(microseconds: map['duration'] ?? 0),
        macAddress = map['macAddress'],
        ncm = map['ncm'],
        cest = map['cest'],
        cnae = map['cnae'],
        licencePlate = map['licencePlate'],
        cep = map['cep'],
        ordinal = _exampleEnumParser.fromJson(map['ordinal']),
        color = _colorValidator.parse(map['color']),
        active = map['active'] ?? true,
        icon = map['icon'] == null ? null : IconHelper.iconData(map['icon']),
        multiline = map['multiline'] ?? '',
        blob = base64.decode(map['blob'] ?? ''),
        fruitIndex = map['fruitIndex'],
        super.fromJson();

  ///
  ///
  ///
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['decimal'] = ModelUtils.toMapDecimal(decimal);
    map['integer'] = integer;
    map['text'] = text;
    map['email'] = email;
    map['password'] = password;
    map['visiblePassword'] = visiblePassword;
    map['cpf'] = cpf;
    map['cnpj'] = cnpj;
    map['document'] = document;
    map['phone'] = phone;
    map['localPhone'] = localPhone;
    map['dateTime'] = ModelUtils.toMapDateMillis(dateTime);
    map['date'] = ModelUtils.toMapNullableDateMillis(date);
    map['time'] = _timeValidator.format(time);
    map['duration'] = duration.inMicroseconds;
    map['macAddress'] = macAddress;
    map['ncm'] = ncm;
    map['cest'] = cest;
    map['cnae'] = cnae;
    map['licencePlate'] = licencePlate;
    map['cep'] = cep;
    map['ordinal'] = _exampleEnumParser.toMap(ordinal);
    if (color != null) {
      map['color'] = _colorValidator.format(color!);
    }
    map['active'] = active;
    if (icon != null) {
      map['icon'] = IconHelper.iconName(icon!);
    }
    map['multiline'] = multiline;
    map['blob'] = base64.encode(blob);
    if (fruitIndex != null) {
      map['fruitIndex'] = fruitIndex;
    }
    return map;
  }

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
  ExampleModel.generate({int seed = 1}) {
    DateTime now = DateTime.now();

    int ms = seed * 1000 + now.millisecond;

    id = ms;
    updatedAt = now.millisecondsSinceEpoch;
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
    date = DateTime(now.year, now.month, now.day);
    time = TimeOfDay(hour: now.hour, minute: now.minute);
    dateTime =
        FollyUtils.dateMergeStart(date: date, time: time) ?? DateTime.now();
    macAddress = MacAddressValidator.generate();
    ncm = complete(8);
    cest = complete(7);
    cnae = complete(7);
    licencePlate = '${generateUpperString(3)}${complete(4)}';
    cep = complete(8);
    color = randomColor;
    ordinal = _exampleEnumParser.random;
    active = ms.isEven;

    int iconNumber = rnd.nextInt(IconHelper.data.keys.length);
    String iconName = IconHelper.data.keys.elementAt(iconNumber);
    icon = IconHelper.iconData(iconName);

    multiline = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
        ' Curabitur ullamcorper, nisi nec ultrices congue, ante metus congue '
        'mi, a congue tortor nisl sed odio. Curabitur lacinia elit ac dolor '
        'luctus vulputate. Quisque lectus purus, egestas quis augue nec, '
        'rhoncus consequat nisi. Praesent tempor fringilla leo. Aliquam id '
        'ipsum eu sapien tincidunt eleifend. Nullam convallis iaculis mattis. '
        'Sed semper nunc eget dui sagittis commodo.';
  }

  ///
  ///
  ///
  static String complete(int length) =>
      List<String>.generate(length, (_) => rnd.nextInt(10).toString()).join();

  ///
  ///
  ///
  static String generateUpperString(
    int length, {
    String domain = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
  }) =>
      List<String>.generate(
        length,
        (_) => domain[rnd.nextInt(domain.length)],
      ).join();

  ///
  ///
  ///
  static final Map<Color, String> _colors = <Color, String>{
    Colors.red.shade500: 'Vermelho',
    Colors.green.shade500: 'Verde',
    Colors.blue.shade500: 'Azul',
  };

  ///
  ///
  ///
  static Color get randomColor =>
      _colors.keys.elementAt(rnd.nextInt(_colors.length));
}
