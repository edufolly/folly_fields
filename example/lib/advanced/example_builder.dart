import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:folly_fields/crud/abstract_ui_builder.dart';
import 'package:folly_fields_example/example_model.dart';

///
///
///
class ExampleBuilder extends AbstractUIBuilder<ExampleModel> {
  ///
  ///
  ///
  ExampleBuilder({String prefix}) : super(prefix);

  ///
  ///
  ///
  @override
  String getInternalSingle() => 'Exemplo';

  ///
  ///
  ///
  @override
  String getInternalPlural() => 'Exemplos';

  ///
  ///
  ///
  @override
  Widget getTitle(ExampleModel model) => Text(model.text);
}
