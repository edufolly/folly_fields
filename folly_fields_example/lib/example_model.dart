import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/validators/time_validator.dart';

///
///
///
class ExampleModel extends AbstractModel {
  static final TimeValidator timeValidator = TimeValidator();

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

  ///
  ///
  ///
  ExampleModel();

  ///
  ///
  ///
  @override
  ExampleModel.fromJson(Map<String, dynamic> map)
      : text = map['text'],
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
    return map;
  }

  ///
  ///
  ///
  @override
  String get searchTerm => text;
}
