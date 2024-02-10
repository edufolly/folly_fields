import 'package:flutter/material.dart';
import 'package:folly_fields/fields/choice_chip_field.dart';

///
///
///
class ChoiceChipFieldController<T> extends ValueNotifier<T?> {
  Map<T, ChipEntry>? _items;

  ///
  ///
  ///
  ChoiceChipFieldController({Map<T, ChipEntry>? items, T? value})
      : _items = items,
        super(value);

  ///
  ///
  ///
  ChoiceChipFieldController.fromValue(ChoiceChipFieldController<T> controller)
      : _items = controller.items,
        super(controller.value);

  ///
  ///
  ///
  Map<T, ChipEntry>? get items => _items;

  ///
  ///
  ///
  set items(Map<T, ChipEntry>? items) {
    _items = items;
    super.notifyListeners();
  }
}
