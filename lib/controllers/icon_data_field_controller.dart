import 'package:flutter/material.dart';

class IconDataFieldController extends ValueNotifier<IconData?> {
  Map<String, IconData> _icons;

  IconDataFieldController({
    final IconData? value,
    final Map<String, IconData> icons = const <String, IconData>{},
  }) : _icons = icons,
       super(value);

  IconDataFieldController.fromValue(final IconDataFieldController controller)
    : _icons = controller.icons,
      super(controller.value);

  Map<String, IconData> get icons => _icons;

  set icons(final Map<String, IconData> icons) {
    _icons = icons;
    super.notifyListeners();
  }

  String get name {
    if (value == null) {
      return '';
    }

    return _icons.keys.firstWhere(
      (final String key) => _icons[key] == value,
      orElse: () => '',
    );
  }
}
