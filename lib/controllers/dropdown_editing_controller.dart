import 'package:flutter/material.dart' show DropdownMenuItem;
import 'package:flutter/widgets.dart';
import 'package:folly_fields/extensions/map_extension.dart';
import 'package:folly_fields/extensions/scope_extension.dart';

class DropdownEditingController<T, I extends Widget> extends ValueNotifier<T?> {
  Map<T, I>? _items;

  DropdownEditingController({final Map<T, I>? items, final T? value})
    : _items = items,
      super(value);

  DropdownEditingController.fromValue(
    final DropdownEditingController<T, I> controller,
  ) : _items = controller.items,
      super(controller.value);

  Map<T, I>? get items => _items;

  set items(final Map<T, I>? items) {
    _items = items;
    super.notifyListeners();
  }

  List<DropdownMenuItem<T>> getDropdownItems() =>
      _items.takeIf(isNotEmpty)?.let(_convert) ?? <DropdownMenuItem<T>>[];

  List<DropdownMenuItem<T>> _convert(final Map<T, I> map) => map.entries
      .map(
        (final MapEntry<T, I> it) =>
            DropdownMenuItem<T>(value: it.key, child: it.value),
      )
      .toList();
}
