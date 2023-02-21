import 'package:flutter/material.dart';

///
///
///
class IntegerEditingController extends TextEditingController {
  ///
  ///
  ///
  IntegerEditingController({int? value}) : super(text: value?.toString());

  ///
  ///
  ///
  int? get integer => int.tryParse(text);

  ///
  ///
  ///
  set integer(int? integer) => text = integer == null ? '' : integer.toString();
}
