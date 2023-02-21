import 'package:flutter/material.dart';

///
///
///
class ChoiceChipFieldController<T> extends ValueNotifier<T?> {
  Map<T, String>? _items;

  ///
  ///
  ///
  ChoiceChipFieldController({Map<T, String>? items, T? value})
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
  Map<T, String>? get items => _items;

  ///
  ///
  ///
  set items(Map<T, String>? items) {
    _items = items;
    super.notifyListeners();
  }
}
