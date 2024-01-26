import 'package:flutter/material.dart';

///
///
///
class DropdownEditingController<T, I extends Widget> extends ValueNotifier<T?> {
  Map<T, I>? _items;

  ///
  ///
  ///
  DropdownEditingController({Map<T, I>? items, T? value})
      : _items = items,
        super(value);

  ///
  ///
  ///
  DropdownEditingController.fromValue(
    DropdownEditingController<T, I> controller,
  )   : _items = controller.items,
        super(controller.value);

  ///
  ///
  ///
  Map<T, I>? get items => _items;

  ///
  ///
  ///
  set items(Map<T, I>? items) {
    _items = items;
    super.notifyListeners();
  }

  ///
  ///
  ///
  List<DropdownMenuItem<T>> getDropdownItems() => _items == null ||
          _items!.isEmpty
      ? <DropdownMenuItem<T>>[]
      : _items!.entries.map(
          (MapEntry<T, I> entry) {
            return DropdownMenuItem<T>(value: entry.key, child: entry.value);
          },
        ).toList();
}
