import 'package:flutter/widgets.dart';

class IconDataExternalFieldController extends ValueNotifier<IconData?> {
  IconDataExternalFieldController({IconData? value}) : super(value);

  IconDataExternalFieldController.fromValue(
    IconDataExternalFieldController controller,
  ) : super(controller.value);
}
