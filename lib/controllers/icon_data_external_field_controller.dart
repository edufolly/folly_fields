import 'package:flutter/widgets.dart';

class IconDataExternalFieldController extends ValueNotifier<IconData?> {
  IconDataExternalFieldController({final IconData? value}) : super(value);

  IconDataExternalFieldController.fromValue(
    final IconDataExternalFieldController controller,
  ) : super(controller.value);
}
