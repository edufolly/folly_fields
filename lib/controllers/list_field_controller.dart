import 'package:flutter/foundation.dart';

class ListFieldController<T> extends ValueNotifier<List<T>> {
  ListFieldController({List<T>? value}) : super(value ?? <T>[]);

  ListFieldController.fromValue(ListFieldController<T> controller)
    : super(controller.value);
}
