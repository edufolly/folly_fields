import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_function.dart';
import 'package:folly_fields/crud/abstract_list.dart';
import 'package:folly_fields_example/advanced/example_builder.dart';
import 'package:folly_fields_example/advanced/example_consumer.dart';
import 'package:folly_fields_example/advanced/example_edit.dart';
import 'package:folly_fields_example/advanced/example_map_function_route.dart';
import 'package:folly_fields_example/advanced/example_model_function_route.dart';
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
    super.key,
    super.selection = false,
    super.multipleSelection = false,
    super.invertSelection = false,
    String labelPrefix = '',
  }) : super(
          forceOffline: false,
          showRefreshButton: true,
          consumer: const ExampleConsumer(),
          uiBuilder: ExampleBuilder(labelPrefix: labelPrefix),
          onAdd: (
            BuildContext context,
            ExampleBuilder uiBuilder,
            ExampleConsumer consumer,
          ) async =>
              ExampleEdit(ExampleModel(), uiBuilder, consumer, edit: true),
          onUpdate: (
            BuildContext context,
            ExampleModel model,
            ExampleBuilder uiBuilder,
            ExampleConsumer consumer,
            bool edit,
          ) async =>
              ExampleEdit(model, uiBuilder, consumer, edit: edit),
          onLongPress: (
            BuildContext context,
            ExampleModel model,
            ExampleBuilder uiBuilder,
            ExampleConsumer consumer,
            bool edit,
          ) async =>
              ExampleEdit(model, uiBuilder, consumer, edit: edit),
          mapFunctions: <AbstractMapFunction>[
            const ExampleMapFunctionRoute(),
          ],
          modelFunctions: <AbstractModelFunction<ExampleModel>>[
            const ExampleModelFunctionRoute(),
          ],
        );
}
