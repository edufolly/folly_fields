import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_list.dart';
import 'package:folly_fields_example/advanced/example_builder.dart';
import 'package:folly_fields_example/advanced/example_consumer.dart';
import 'package:folly_fields_example/advanced/example_edit.dart';
import 'package:folly_fields_example/advanced/example_list_action.dart';
import 'package:folly_fields_example/advanced/example_list_row_action.dart';
import 'package:folly_fields_example/example_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    super.itemsPerPage = 10,
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
          actions: (
            BuildContext context,
            bool selection,
            Map<String, String> qsParam,
          ) {
            return <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => ExampleListAction(
                        model: ExampleMapModel(originalMap: qsParam),
                      ),
                    ),
                  );
                },
                icon: const Icon(FontAwesomeIcons.cube),
              ),
            ];
          },
          rowActions: (
            BuildContext context,
            bool selection,
            ExampleModel model,
            Map<String, String> qsParam,
            void Function({bool clear})? refresh,
          ) {
            return <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => ExampleListRowAction(
                        model: model,
                      ),
                    ),
                  );
                },
                icon: const Icon(FontAwesomeIcons.mugHot),
              ),
            ];
          },
        );
}
