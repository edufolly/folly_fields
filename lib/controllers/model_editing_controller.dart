import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_model.dart';

///
///
///
class ModelEditingController<T extends AbstractModel<ID>, ID>
    extends TextEditingController {
  T? _model;

  ///
  ///
  ///
  ModelEditingController({T? model})
      : _model = model,
        super(text: (model ?? '').toString());

  ///
  ///
  ///
  T? get model => _model;

  ///
  ///
  ///
  set model(T? model) {
    _model = model;
    text = (model ?? '').toString();
  }
}
