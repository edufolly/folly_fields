import 'package:flutter/widgets.dart';
import 'package:folly_fields/extensions/scope_extension.dart';

class IntegerEditingController extends TextEditingController {
  IntegerEditingController({final int? value})
    : super(text: value?.let(toString) ?? '');

  int? get integer => int.tryParse(text);

  set integer(final int? value) => text = value?.let(toString) ?? '';
}
