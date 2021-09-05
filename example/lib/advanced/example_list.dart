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
    Key? key,
    bool selection = false,
    bool multipleSelection = false,
    String prefix = '',
  }) : super(
          key: key,
          selection: selection,
          multipleSelection: multipleSelection,
          forceOffline: false,
          consumer: const ExampleConsumer(),
          uiBuilder: ExampleBuilder(prefix),
          onAdd: (
            BuildContext context,
            ExampleBuilder uiBuilder,
            ExampleConsumer consumer,
          ) async =>
              ExampleEdit(ExampleModel(), uiBuilder, consumer, true),
          onUpdate: (
            BuildContext context,
            ExampleModel model,
            ExampleBuilder uiBuilder,
            ExampleConsumer consumer,
            bool edit,
          ) async =>
              ExampleEdit(model, uiBuilder, consumer, edit),
          onLongPress: (
            BuildContext context,
            ExampleModel model,
            ExampleBuilder uiBuilder,
            ExampleConsumer consumer,
            bool edit,
          ) async =>
              ExampleEdit(model, uiBuilder, consumer, edit),
        );
}
