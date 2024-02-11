import 'dart:typed_data';

import 'package:flutter/material.dart';

///
///
///
@Deprecated('Will be removed in the next version.')
class FileFieldController extends ValueNotifier<Uint8List?> {
  ///
  ///
  ///
  @Deprecated('Will be removed in the next version.')
  FileFieldController({Uint8List? value}) : super(value);

  ///
  ///
  ///
  @Deprecated('Will be removed in the next version.')
  FileFieldController.fromValue(FileFieldController controller)
      : super(controller.value);
}
