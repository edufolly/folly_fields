import 'package:flutter/material.dart';

///
///
///
class DropdownEditingController<T> extends ValueNotifier<T?> {
  Map<T, String>? _items;

  ///
  ///
  ///
  DropdownEditingController({Map<T, String>? items, T? value})
      : _items = items,
        super(value);

  ///
  ///
  ///
  DropdownEditingController.fromValue(DropdownEditingController<T> controller)
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

  ///
  ///
  ///
  List<DropdownMenuItem<T>> getDropdownItems() =>
      _items == null || _items!.isEmpty
          ? <DropdownMenuItem<T>>[]
          : _items!.entries
              .map(
                (MapEntry<T, String> entry) => DropdownMenuItem<T>(
                  value: entry.key,
                  child: Text(entry.value),
                ),
              )
              .toList();
}
