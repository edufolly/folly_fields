import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_model.dart';

///
///
///
abstract class AbstractEditController<T extends AbstractModel<ID>, ID> {
  ///
  ///
  ///
  Future<void> init(BuildContext context, T model);

  ///
  ///
  ///
  Future<void> dispose(BuildContext context);

  ///
  ///
  ///
  Future<bool> validate(BuildContext context, T model) async => true;
}
