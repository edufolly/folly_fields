import 'package:flutter/foundation.dart';

class ListFieldController<T> extends ValueNotifier<List<T>> {
  ListFieldController({final List<T>? value}) : super(value ?? <T>[]);

  ListFieldController.fromValue(final ListFieldController<T> controller)
    : super(controller.value);
}
