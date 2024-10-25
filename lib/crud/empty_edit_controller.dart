import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_edit_controller.dart';
import 'package:folly_fields/crud/abstract_model.dart';

///
///
///
class EmptyEditController<T extends AbstractModel<ID>, ID>
    extends AbstractEditController<T, ID> {
  ///
  ///
  ///
  @override
  Future<void> init(BuildContext context, T model) async {}

  ///
  ///
  ///
  @override
  Future<void> dispose(BuildContext context) async {}
}
