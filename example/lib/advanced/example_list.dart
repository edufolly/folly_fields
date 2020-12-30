import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_list.dart';
import 'package:folly_fields_example/advanced/example_builder.dart';
import 'package:folly_fields_example/advanced/example_consumer.dart';
import 'package:folly_fields_example/advanced/example_edit.dart';
import 'package:folly_fields_example/example_model.dart';

///
///
///
class ExampleList
    extends AbstractList<ExampleModel, ExampleBuilder, ExampleConsumer> {
  ///
  ///
  ///
  ExampleList({
    Key key,
    bool selection = false,
    bool multipleSelection = false,
    String prefix,
  }) : super(
          key: key,
          selection: selection,
          multipleSelection: multipleSelection,
          forceOffline: false,
          consumer: ExampleConsumer(),
          uiBuilder: ExampleBuilder(prefix),
          onAdd: (
            ExampleConsumer consumer,
            ExampleBuilder uiBuilder,
          ) =>
              ExampleEdit(
            model: ExampleModel(),
            consumer: consumer,
            uiBuilder: uiBuilder,
          ),
          onUpdate: (
            ExampleModel model,
            ExampleConsumer consumer,
            ExampleBuilder uiBuilder,
            bool edit,
          ) =>
              ExampleEdit(
            model: model,
            consumer: consumer,
            uiBuilder: uiBuilder,
            edit: edit,
          ),
        );
}
