import 'dart:typed_data';

import 'package:flutter/material.dart';

///
///
///
class FileFieldController extends ValueNotifier<Uint8List?> {
  ///
  ///
  ///
  FileFieldController({Uint8List? value}) : super(value);

  ///
  ///
  ///
  FileFieldController.fromValue(FileFieldController controller)
      : super(controller.value);
}
